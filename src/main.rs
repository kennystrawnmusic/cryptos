#![no_std]
#![no_main]
#![feature(alloc_error_handler)]
#![feature(abi_x86_interrupt)]
#![feature(maybe_uninit_slice)]
#![allow(unused_imports)]

extern crate alloc;

pub mod acpi_impl;
pub mod ahci;
pub mod apic_impl;
pub mod cralloc;
pub mod exceptions;
pub mod interrupts;

use bootloader_api::{*, config::{Mapping, Mappings, FrameBuffer}, info::FrameBufferInfo};
use acpi::{AcpiTables, InterruptModel, PciConfigRegions};
use alloc::vec::Vec;
use conquer_once::spin::OnceCell;
use crate::acpi_impl::KernelAcpi;
use printk::LockedPrintk;
use core::{
    alloc::Layout, any::TypeId, fmt::Write, iter::Copied, mem::MaybeUninit, panic::PanicInfo,
};
use cralloc::{
    frames::{map_memory, Falloc},
    heap_init,
};
use log::{debug, error, info};
use spin::Mutex;
use x86_64::{
    structures::paging::{FrameAllocator, Mapper, OffsetPageTable, PhysFrame, Page, PageTableFlags, Size4KiB},
    PhysAddr, VirtAddr,
};
use xmas_elf::ElfFile;

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    error!("Kernel panic -- not syncing: {info}");
    loop {
        unsafe { 
            core::arch::asm!("cli");
            core::arch::asm!("hlt")
        };
    }
}

const MAPPINGS: Mappings = {
    let mut mappings = Mappings::new_default();
    mappings.kernel_stack = Mapping::FixedAddress(0xf000_0000_0000);
    mappings.boot_info = Mapping::Dynamic;
    mappings.framebuffer = Mapping::Dynamic;
    mappings.physical_memory = Some(Mapping::Dynamic);
    mappings.page_table_recursive = None;
    mappings.aslr = false;
    mappings.dynamic_range_start = Some(0);
    mappings.dynamic_range_end = Some(0xffff_ffff_ffff);
    mappings
};

const CONFIG: BootloaderConfig = {
    let mut config = BootloaderConfig::new_default();
    config.mappings = MAPPINGS;
    config.frame_buffer = FrameBuffer::new_default();
    config
};

/// Creates a page-aligned size of something by creating a test page at a given address
///
pub fn page_align(size: u64, addr: u64) -> usize {
    let test = Page::<Size4KiB>::containing_address(VirtAddr::new(addr));
    let test_size = test.size() as usize;

    (((size as usize) - 1) / test_size + 1) * test_size
}

pub static PRINTK: OnceCell<LockedPrintk> = OnceCell::uninit();

// override compiler's pickiness about raw pointers not implementing Send
pub struct SendRawPointer<T>(*mut T);

impl<T> SendRawPointer<T> {
    pub fn new(inner: *mut T) -> Self {
        Self(inner)
    }

    pub unsafe fn get(&self) -> *mut T {
        self.0
    }
}

unsafe impl<T> Send for SendRawPointer<T> {}

// Needed to allow page/frame allocation outside of the entry point, by things like the ACPI handler
pub static MAPPER: OnceCell<Mutex<OffsetPageTable>> = OnceCell::uninit();
pub static FRAME_ALLOCATOR: OnceCell<Mutex<Falloc>> = OnceCell::uninit();

pub fn get_next_usable_frame() -> PhysFrame {
    FRAME_ALLOCATOR
        .get()
        .as_ref()
        .unwrap()
        .lock()
        .usable()
        .next()
        .clone()
        .expect("Out of memory")
        .clone()
}

pub static PHYS_OFFSET: OnceCell<u64> = OnceCell::uninit();

/// Convenient wrapper for getting the physical memory offset
///
/// Safety: only call this if you know that the OnceCell holding the physical memory offset has been initialized
pub unsafe fn get_phys_offset() -> u64 {
    PHYS_OFFSET.get().clone().unwrap().clone()
}

pub static INTERRUPT_MODEL: OnceCell<InterruptModel> = OnceCell::uninit();
pub static PCI_CONFIG: OnceCell<Option<PciConfigRegions>> = OnceCell::uninit();

pub fn get_mcfg() -> Option<PciConfigRegions> {
    PCI_CONFIG.get().clone().unwrap().clone()
}

pub fn printk_init(buffer: &'static mut [u8], info: FrameBufferInfo) {
    let p = PRINTK.get_or_init(move || LockedPrintk::new(buffer, info));
    log::set_logger(p).expect("Logger has already been set!");

    // Don't flood users with excessive messages if compiled with "--release"
    if cfg!(opt_level = "0") {
        log::set_max_level(log::LevelFilter::Trace);
    } else {
        log::set_max_level(log::LevelFilter::Info);
    }
    info!("CryptOS v. 0.1.1-alpha");
}

entry_point!(maink, config = &CONFIG);

pub fn maink(boot_info: &'static mut BootInfo) -> ! {
    // set up heap allocation ASAP
    let offset = VirtAddr::new(
        boot_info
            .physical_memory_offset
            .clone()
            .into_option()
            .unwrap(),
    );
    let map = unsafe { map_memory(offset) };
    let falloc = unsafe { Falloc::new(&boot_info.memory_regions) };

    MAPPER.get_or_init(move || Mutex::new(map));
    FRAME_ALLOCATOR.get_or_init(move || Mutex::new(falloc));

    heap_init(
        &mut *MAPPER.get().unwrap().lock(),
        &mut *FRAME_ALLOCATOR.get().unwrap().lock(),
    )
    .unwrap_or_else(|e| panic!("Failed to initialize heap: {:#?}", e));

    // clone the physical memory offset into a static ASAP
    // so it doesn't need to be hardcoded everywhere it's needed
    let cloned_offset = boot_info
        .physical_memory_offset
        .clone()
        .into_option()
        .unwrap();
    PHYS_OFFSET.get_or_init(move || cloned_offset);

    let buffer_optional = &mut boot_info.framebuffer;
    let buffer_option = buffer_optional.as_mut();
    let buffer = buffer_option.unwrap();
    let bi = buffer.info().clone();
    let raw_buffer = buffer.buffer_mut();

    let rsdp = boot_info.rsdp_addr.clone().into_option().unwrap();
    printk_init(raw_buffer, bi);
    info!(
        "Using version {}.{}.{} of crates.io/crates/bootloader",
        boot_info.api_version.version_major(),
        boot_info.api_version.version_minor(),
        boot_info.api_version.version_patch()
    );

    info!("RSDP address: {:#x}", rsdp.clone());
    info!(
        "Memory region start address: {:#x}",
        &boot_info.memory_regions.first().unwrap() as *const _ as usize
    );

    let mut tables = unsafe { AcpiTables::from_rsdp(KernelAcpi, rsdp.clone() as usize).unwrap() };
    let mcfg = match PciConfigRegions::new(&tables) {
        Ok(mcfg) => Some(mcfg),
        Err(_) => None,
    };

    let interrupts = tables.platform_info().unwrap().interrupt_model;

    INTERRUPT_MODEL.get_or_init(move || interrupts);
    PCI_CONFIG.get_or_init(move || mcfg.clone());

    debug!("Interrupt model: {:#?}", INTERRUPT_MODEL.get().unwrap());

    debug!("TLS template: {:#?}", boot_info.tls_template);
    debug!("PCI Configuration Regions: {:#x?}", get_mcfg());

    loop {
        unsafe { 
            core::arch::asm!("cli");
            core::arch::asm!("hlt");
        };
    }
}

#[alloc_error_handler]
fn alloc_err(_layout: Layout) -> ! {
    panic!("Out of memory!")
}