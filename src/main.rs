#![no_std]
#![no_main]
#![feature(abi_efiapi)]
#![feature(alloc_error_handler)]
#![feature(abi_x86_interrupt)]
#![feature(maybe_uninit_slice)]
#![allow(unused_imports)]

extern crate alloc;

pub mod acpi_impl;
pub mod apic_impl;
pub mod cralloc;
pub mod exceptions;
pub mod hmfs;
pub mod interrupts;
pub mod uefi_video;

use acpi::{AcpiTables, InterruptModel};
use alloc::vec::Vec;
use conquer_once::spin::OnceCell;
use core::{alloc::Layout, iter::Copied, mem::MaybeUninit, panic::PanicInfo};
use cralloc::{
    frames::{Falloc, MemoryRegion, MemoryRegions, StubTables},
    heap_init,
    uefi_map::{create_region_slice, UefiMap, UefiMemoryRegion},
};
use log::{error, info};
use spin::Mutex;
use uefi::{
    prelude::entry,
    proto::media::block::{BlockIO, BlockIOMedia},
    table::{boot::MemoryDescriptor, boot::MemoryType, Boot, SystemTable},
    Handle, Status,
};
use uefi_video::{LockedPrintk, FramebufferInfo, Framebuffer};
use x86_64::{
    structures::paging::{FrameAllocator, Mapper, OffsetPageTable, Page, PageTableFlags, Size4KiB},
    PhysAddr, VirtAddr,
};
use xmas_elf::ElfFile;

// defining this constant because we don't have a bootloader to depend on for this anymore
pub const PHYS_OFFSET: u64 = 0x1000_0000_0000;

pub unsafe fn get_phys_offset() -> u64 {
    PHYS_OFFSET.clone()
}

pub fn page_align(size: u64, addr: u64) -> usize {
    let test = Page::<Size4KiB>::containing_address(VirtAddr::new(addr));
    let test_size = test.size() as usize;

    (((size as usize) - 1) / test_size + 1) * test_size
}

// store init process in a static until ready to spawn it
// This is a Plan B in case the Block I/O protocol needs Boot Services active to be accessed
pub static INIT: OnceCell<ElfFile<'static>> = OnceCell::uninit();

// as before
pub static PRINTK: OnceCell<LockedPrintk> = OnceCell::uninit();

// store the mapper's parent struct in a static OnceCell to satisfy the borrow checker
pub static STUB_TABLES: OnceCell<Mutex<StubTables>> = OnceCell::uninit();

// as before
pub static FRAME_ALLOCATOR: OnceCell<Mutex<Falloc>> = OnceCell::uninit();
pub static INTERRUPT_MODEL: OnceCell<InterruptModel> = OnceCell::uninit();

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

// back up detected Block I/O media to a global locked raw pointer for easy access after boot services are exited
pub static BLOCK_IO_MEDIA: OnceCell<Mutex<SendRawPointer<BlockIOMedia>>> = OnceCell::uninit();

pub fn printk_init(buffer: &'static mut [u8], info: FramebufferInfo) {
    let p = PRINTK.get_or_init(move || LockedPrintk::new(buffer, info));
    log::set_logger(p).expect("Logger has already been set!");

    // Don't flood users with excessive messages if compiled with "--release"
    if cfg!(opt_level = "0") {
        log::set_max_level(log::LevelFilter::Trace);
    } else {
        log::set_max_level(log::LevelFilter::Info);
    }

    info!("CryptOS v. 0.1.0");
}

#[entry]
fn maink(image: Handle, table: SystemTable<Boot>) -> Status {
    let (_addr, _info) = uefi_video::printk_init(&table);
    
    let mem_map = {
        let max_len = table.boot_services().memory_map_size().map_size
            + 8 * core::mem::size_of::<MemoryDescriptor>();
        let ptr = table
            .boot_services()
            .allocate_pool(MemoryType::LOADER_DATA, max_len)?;
        unsafe { core::slice::from_raw_parts_mut(ptr, max_len) }
    };

    // make sure the Block I/O protocol is available before exiting boot services
    let bio = table.boot_services().locate_protocol::<BlockIO>()?;
    let bio = unsafe { &mut *bio.get() };

    let bio_media_addr = bio.media() as *const _ as usize;

    BLOCK_IO_MEDIA
        .get_or_init(move || Mutex::new(SendRawPointer::new(bio_media_addr as *mut BlockIOMedia)));

    // shadow the boot table with the runtime table so access can't be attempted after boot services are exited
    let (table, memory_map) = table
        .exit_boot_services(image, mem_map)
        .expect("Couldn't exit UEFI boot services");

    // Interrupt init function only loads the IDT this time; we can wait to init the APICs until later
    // Needed here to ensure that exceptions are handled properly in case any are thrown trying to set up the heap, etc
    crate::interrupts::init();

    let mut map = UefiMap::new(memory_map.copied());
    let page_tables = cralloc::frames::build_from_uefi(&mut map);

    STUB_TABLES.get_or_init(move || Mutex::new(page_tables));

    let stub_regions = create_region_slice(
        map,
        &mut *STUB_TABLES.get().as_mut().unwrap().clone().lock(),
    );

    // immediately remap memory that's freed after boot services are exited
    let falloc = unsafe { Falloc::new(stub_regions) };
    FRAME_ALLOCATOR.get_or_init(move || Mutex::new(falloc));

    // immediately reconfigure the heap
    heap_init(
        &mut STUB_TABLES.get().as_mut().unwrap().lock().stub_kernel,
        &mut *FRAME_ALLOCATOR.get().as_mut().unwrap().lock(),
    )
    .unwrap_or_else(|e| panic!("Error allocating heap: {:#?}", e));

    // get the RSDP address from the UEFI config table
    let rsdp = {
        use uefi::table::cfg;
        let mut entries = table.config_table().iter();
        let acpi2 = entries.find(|e| matches!(e.guid, cfg::ACPI2_GUID));

        let rsdp = acpi2.or_else(|| entries.find(|e| matches!(e.guid, cfg::ACPI_GUID)));
        rsdp.map(|e| PhysAddr::new(e.address as u64))
    };

    let acpi = unsafe {
        AcpiTables::from_rsdp(acpi_impl::KernelAcpi, rsdp.unwrap().as_u64() as usize)
            .unwrap_or_else(|e| panic!("Error parsing ACPI tables: {:#?}", e))
    };
    let interrupts = acpi.platform_info().unwrap().interrupt_model;

    INTERRUPT_MODEL.get_or_init(move || interrupts);

    // NOW we can init the APICs
    crate::apic_impl::init_all_available_apics();

    loop {
        unsafe { core::arch::asm!("hlt") };
    }
}

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    error!("Kernel panic -- not syncing: {info}");
    loop {
        unsafe { core::arch::asm!("hlt") };
    }
}

#[alloc_error_handler]
fn alloc_err(_layout: Layout) -> ! {
    panic!("Out of memory!")
}
