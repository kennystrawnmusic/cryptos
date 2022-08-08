#![no_std]
#![no_main]
#![feature(alloc_error_handler)]
#![feature(generic_arg_infer)]
#![feature(panic_info_message)]
#![feature(abi_x86_interrupt)]
#![feature(cfg_target_abi)]
#![feature(concat_idents)]

extern crate alloc;

pub mod ahci;
pub mod apic_impl;
pub mod cralloc;
pub mod exceptions;
pub mod interrupts;

#[allow(unused_imports)] //future-proof
use {
    acpi::{
        AcpiError, AcpiHandler, AcpiTables, HpetInfo, InterruptModel, PciConfigRegions,
        PhysicalMapping, PlatformInfo, RsdpError,
    },
    alloc::boxed::Box,
    alloc::sync::Arc,
    alloc::vec::Vec,
    bootloader::{
        boot_info::{FrameBuffer, FrameBufferInfo},
        entry_point, BootInfo,
    },
    conquer_once::spin::OnceCell,
    core::{
        alloc::Layout,
        marker::PhantomData,
        mem::MaybeUninit,
        ops::{Add, AddAssign, BitAnd, BitOr, Div, DivAssign, Mul, MulAssign, Not, Sub, SubAssign},
        panic::PanicInfo,
        ptr::{addr_of, addr_of_mut, read_volatile, write_volatile, NonNull},
    },
    cralloc::{
        frames::{map_memory, Falloc},
        heap_init,
    },
    log::*,
    printk::LockedPrintk,
    spin::Mutex,
    syscall::io::Io,
    x86_64::{
        structures::paging::{
            mapper::MapToError, Mapper, OffsetPageTable, Page, PageTableFlags, PhysFrame, Size4KiB,
        },
        PhysAddr, VirtAddr,
    },
};

pub use crate::ahci::hba::{find_base_with_mcfg, find_base_without_mcfg, EIO_DEBUG};
use ahci::hba::{structs::InterruptError, EIO_STATUS};
use alloc::string::String;
pub use syscall;
use x86_64::structures::paging::Size2MiB; // definitely going to need this later, i.e. for compatibility with Redox apps

pub static PHYS_OFFSET: OnceCell<u64> = OnceCell::uninit();
pub static INTERRUPT_MODEL: OnceCell<InterruptModel> = OnceCell::uninit();
pub static PCI_CONFIG: OnceCell<Option<PciConfigRegions>> = OnceCell::uninit();

/// Convenient wrapper for getting the physical memory offset
///
/// Safety: only call this if you know that the OnceCell holding the physical memory offset has been initialized
pub unsafe fn get_phys_offset() -> u64 {
    PHYS_OFFSET.get().unwrap().clone()
}

pub fn get_mcfg() -> Option<PciConfigRegions> {
    PCI_CONFIG.get().clone().unwrap().clone()
}

/// Function which retrieves a debug string for handling I/O errors
///
/// TODO: register this function as a system call
pub fn eio_debug() -> (Option<String>, Option<InterruptError>) {
    let msg = match EIO_DEBUG.read().clone() {
        Some(s) => Some(s.clone()),
        None => None,
    };
    let internal = match EIO_STATUS.read().clone() {
        Some(err) => Some(err.clone()),
        None => None,
    };
    (msg, internal)
}

/// Creates a page-aligned size of something by creating a test page at a given address
/// Useful for mapping things like the ACPI tables (see below)
pub fn page_align(size: u64, addr: u64) -> usize {
    let test = Page::<Size4KiB>::containing_address(VirtAddr::new(addr));
    let test_size = test.size() as usize;

    (((size as usize) - 1) / test_size + 1) * test_size
}

/// Rewrite of Redox's Mmio<T> as a tuple struct to reduce write time
///
/// Also has a sounder implementation of the `new()` constructor that calls `from` instead of `uninit` behind the scenes
/// to ensure proper initialization before any read attempts

#[repr(packed)]
pub struct Mmio<T>(MaybeUninit<T>);

impl<T> Mmio<T> {
    /// Constructs a `Mmio` from a given type
    pub const fn new(value: T) -> Self {
        Self::from(value)
    }

    const fn from(value: T) -> Self {
        Self(MaybeUninit::new(value))
    }

    /// Constructs an uninitialized `Mmio`
    ///
    /// Safety: make sure you initialize this later before attempting a read!
    pub unsafe fn uninit() -> Self {
        Self(MaybeUninit::uninit())
    }

    /// Constructs a `Mmio` and sets all bits to 0.
    ///
    /// Safety: this could erase parts of memory that are otherwise vital to system functionality
    pub unsafe fn zeroed() -> Self {
        Self(MaybeUninit::zeroed())
    }
}

impl<T> Io for Mmio<T>
where
    T: Copy + PartialEq + BitAnd<Output = T> + BitOr<Output = T> + Not<Output = T>,
{
    type Value = T;

    fn read(&self) -> Self::Value {
        unsafe { read_volatile(addr_of!(self.0).cast::<T>()) }
    }

    fn write(&mut self, value: Self::Value) {
        unsafe { write_volatile(addr_of_mut!(self.0).cast::<T>(), value) }
    }
}

#[derive(Clone)]
pub struct KernelAcpi;

impl AcpiHandler for KernelAcpi {
    unsafe fn map_physical_region<T>(
        &self,
        physical_address: usize,
        size: usize,
    ) -> PhysicalMapping<Self, T> {
        let virt = physical_address + get_phys_offset() as usize;

        // now that we handle the PageAlreadyMapped and ParentEntryHugePage errors properly, i.e. without panicking
        map_page!(
            physical_address,
            physical_address as u64 + get_phys_offset(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE
        );

        PhysicalMapping::new(
            physical_address,
            NonNull::new((physical_address as u64 + get_phys_offset()) as *mut _).unwrap(), //page must exist
            size,
            page_align(size as u64, virt as u64),
            Self,
        )
    }

    fn unmap_physical_region<T>(_region: &PhysicalMapping<Self, T>) {}
}

pub static PRINTK: OnceCell<LockedPrintk> = OnceCell::uninit();

// Needed to allow page/frame allocation outside of the entry point, by things like the ACPI handler above
pub static MAPPER: OnceCell<Mutex<OffsetPageTable>> = OnceCell::uninit();
pub static FRAME_ALLOCATOR: OnceCell<Mutex<Falloc>> = OnceCell::uninit();

pub fn printk_init(buffer: &'static mut [u8], info: FrameBufferInfo) {
    let p = PRINTK.get_or_init(move || LockedPrintk::new(buffer, info));
    set_logger(p).expect("Logger has already been set!");

    // Don't flood users with excessive messages if compiled with "--release"
    if cfg!(debug_assertions) {
        set_max_level(LevelFilter::Trace);
    } else {
        set_max_level(LevelFilter::Info);
    }

    info!("CryptOS v. 0.1.0");
}

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    error!("Kernel panic -- not syncing: {info}");
    loop {}
}

entry_point!(maink);

fn maink(boot_info: &'static mut BootInfo) -> ! {
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
    .unwrap_or_else(|e| error!("Failed to map{:#?}", e));

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
        boot_info.version_major, boot_info.version_minor, boot_info.version_patch
    );

    info!("RSDP address: {:#x}", rsdp.clone());
    info!(
        "Memory region start address: {:#x}",
        &boot_info.memory_regions.first().unwrap() as *const _ as usize
    );

    let tables = unsafe { AcpiTables::from_rsdp(KernelAcpi, rsdp.clone() as usize).unwrap() };
    let mcfg = match PciConfigRegions::new(&tables) {
        Ok(mcfg) => Some(mcfg),
        Err(_) => None,
    };

    INTERRUPT_MODEL.get_or_init(move || tables.platform_info().unwrap().interrupt_model);
    PCI_CONFIG.get_or_init(move || mcfg.clone());

    crate::interrupts::init();
    debug!("Interrupt model: {:#?}", INTERRUPT_MODEL.get().unwrap());

    info!("TLS template: {:#?}", boot_info.tls_template);
    info!("PCI Configuration Regions: {:#x?}", get_mcfg());

    let sata_ctrl = match get_mcfg() {
        Some(mcfg) => Some(get_mcfg().unwrap().abar()),
        None => None,
    };

    info!("SATA controller address: {:#x?}", sata_ctrl);

    if let Some(addr) = sata_ctrl {
        map_page!(
            addr,
            addr,
            Size2MiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );
        let (_, disks) = ahci::all_disks(addr as usize);
        info!("Found {:#?} disks", disks.len());
    }

    loop {
        unsafe { core::arch::asm!("hlt") };
    }
}

#[alloc_error_handler]
fn alloc_err(_layout: Layout) -> ! {
    panic!("Out of memory!")
}
