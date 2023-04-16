#![no_std]
#![no_main]
#![feature(allocator_api)]
#![feature(alloc_error_handler)]
#![feature(abi_x86_interrupt)]
#![feature(maybe_uninit_slice)]
#![feature(build_hasher_simple_hash_one)]
#![feature(never_type)]
#![feature(target_feature_11)]
#![feature(portable_simd)]
#![allow(unused_imports)]

extern crate alloc;

pub mod acpi_impl;
pub mod ahci;
pub mod apic_impl;
pub mod cralloc;
pub mod drm;
pub mod exceptions;
pub mod fs;
pub mod interrupts;
pub mod pci_impl;

use crate::{
    acpi_impl::KernelAcpi,
    ahci::{ahci_init, get_ahci, ABAR},
    drm::avx_accel::enable_avx,
    interrupts::{IDT, INTA_IRQ, INTB_IRQ, INTC_IRQ, INTD_IRQ},
    pci_impl::{PciDeviceHandle, PCI_TABLE},
};
use acpi::{
    fadt::Fadt,
    sdt::{SdtHeader, Signature},
    AcpiError, AcpiHandler, AcpiTables, HpetInfo, InterruptModel, PciConfigRegions,
    PhysicalMapping, PlatformInfo, RsdpError,
};
use alloc::{alloc::Global, boxed::Box, format, string::String, sync::Arc, vec::Vec};
use aml::{
    pci_routing::{PciRoutingTable, Pin},
    value::Args,
    AmlContext, AmlName, AmlValue, LevelType,
};
use bootloader_api::{
    config::{FrameBuffer, Mapping, Mappings},
    info::{FrameBufferInfo, MemoryRegions, Optional, TlsTemplate},
    *,
};
use bootloader_x86_64_common::logger::{LockedLogger, LOGGER};
use conquer_once::spin::OnceCell;
use core::{
    alloc::Layout,
    any::TypeId,
    fmt::Write,
    iter::Copied,
    marker::PhantomData,
    mem::MaybeUninit,
    ops::{
        Add, AddAssign, BitAnd, BitOr, DerefMut, Div, DivAssign, Mul, MulAssign, Not, Sub,
        SubAssign,
    },
    panic::PanicInfo,
    ptr::{addr_of, addr_of_mut, read_volatile, write_volatile, NonNull},
    sync::atomic::{AtomicU64, Ordering},
};
use cralloc::{
    frames::{map_memory, Falloc},
    heap_init, BEGIN_HEAP,
};
use itertools::Itertools;
use log::{debug, error, info};
use pcics::{
    capabilities::pci_express::Device,
    header::{Header, HeaderType, InterruptPin},
};
use raw_cpuid::CpuId;
use sha3::digest::typenum::U654;
use spin::{Mutex, RwLock};
use x86_64::{
    structures::paging::{
        FrameAllocator, Mapper, OffsetPageTable, Page, PageTableFlags, PhysFrame, Size1GiB,
        Size2MiB, Size4KiB,
    },
    PhysAddr, VirtAddr,
};
use xmas_elf::ElfFile;

pub use acpi_impl::aml_init; //compatibility

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

// needed to allow access outside main.rs
const BOOT_INFO_ADDR: u64 = (BEGIN_HEAP / 32) as u64;
const FB_ADDR: u64 = BOOT_INFO_ADDR * 2;

pub fn get_boot_info<'a>() -> &'a mut BootInfo {
    unsafe { &mut *(BOOT_INFO_ADDR as *mut BootInfo) }
}

// high half
const KERNEL_STACK_ADDR: u64 = 0xffff_0000_0000;

const MAPPINGS: Mappings = {
    let mut mappings = Mappings::new_default();
    mappings.kernel_stack = Mapping::FixedAddress(KERNEL_STACK_ADDR);
    mappings.boot_info = Mapping::FixedAddress(BOOT_INFO_ADDR);
    mappings.framebuffer = Mapping::FixedAddress(FB_ADDR);
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
    config.kernel_stack_size = 1024 * 1024 * 128;
    config
};

/// Creates a page-aligned size of something by creating a test page at a given address
///
pub fn page_align(size: u64, addr: u64) -> usize {
    let test = Page::<Size4KiB>::containing_address(VirtAddr::new(addr));
    let test_size = test.size() as usize;

    (((size as usize) - 1) / test_size + 1) * test_size
}

pub static PRINTK: OnceCell<LockedLogger> = OnceCell::uninit();

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

pub static INTERRUPT_MODEL: OnceCell<InterruptModel<Global>> = OnceCell::uninit();
pub static PCI_CONFIG: OnceCell<Option<PciConfigRegions<Global>>> = OnceCell::uninit();

pub fn get_mcfg() -> &'static Option<PciConfigRegions<'static, Global>> {
    PCI_CONFIG.get().clone().unwrap().clone()
}

/// Returns an Iterator of all possible `Option<u64>` in the PCIe extended address space
///
/// Use the `.filter(|i| i.is_some())` method of the resulting iterator to get the PCI devices present on the system
pub fn mcfg_brute_force_inner() -> impl Itertools<Item = Option<u64>> {
    (0x0u32..0x00ffffffu32).map(|i: u32| match get_mcfg() {
        Some(mcfg) => match mcfg.physical_address(
            i.to_be_bytes()[0] as u16,
            i.to_be_bytes()[1],
            i.to_be_bytes()[2],
            i.to_be_bytes()[3],
        ) {
            Some(addr) => Some(addr),
            None => None,
        },
        None => None,
    })
}

pub fn mcfg_brute_force() -> impl Itertools<Item = u64> {
    mcfg_brute_force_inner()
        .filter(|i| i.is_some())
        .map(|i| i.unwrap())
        .dedup()
}

pub fn printk_init(buffer: &'static mut [u8], info: FrameBufferInfo) {
    let p = PRINTK.get_or_init(move || LockedLogger::new(buffer, info, true, false));
    log::set_logger(p).expect("Logger has already been set!");

    // Don't flood users with excessive messages if compiled with "--release"
    if cfg!(opt_level = "0") {
        log::set_max_level(log::LevelFilter::Trace);
    } else {
        log::set_max_level(log::LevelFilter::Info);
    }
    info!("CryptOS v. 0.1.1-alpha");
}

pub static TLS_TEMPLATE_ADDR: AtomicU64 = AtomicU64::new(0);
pub const TLS_TEMPLATE_SIZE: u64 = 0x600_0000; //100MB; increasing later as app size increases

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

    // map the TLS template onto the heap to ensure proper memory safety
    TLS_TEMPLATE_ADDR.store(Box::into_raw(Box::new(0)) as usize as u64, Ordering::SeqCst);

    let tls = TlsTemplate {
        start_addr: TLS_TEMPLATE_ADDR.load(Ordering::SeqCst),
        file_size: 0,
        mem_size: TLS_TEMPLATE_SIZE,
    };

    boot_info.tls_template = Optional::Some(tls);

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
    let vendor_info = CpuId::new().get_vendor_info();
    info!("CPU vendor: {}", vendor_info.unwrap().as_str());

    info!("RSDP address: {:#x}", rsdp.clone());
    info!(
        "Memory region start address: {:#x}",
        &boot_info.memory_regions.first().unwrap() as *const _ as usize
    );

    match unsafe { AcpiTables::from_rsdp(KernelAcpi, rsdp.clone() as usize) } {
        Ok(mut tables) => {
            let mcfg = match PciConfigRegions::new_in(&tables, &Global) {
                Ok(mcfg) => Some(mcfg),
                Err(_) => None,
            };

            if let Ok(platform_info) = PlatformInfo::new_in(&tables, &Global) {
                let interrupts = platform_info.interrupt_model;

                INTERRUPT_MODEL.get_or_init(move || interrupts);
                PCI_CONFIG.get_or_init(move || mcfg);

                debug!("Interrupt model: {:#?}", INTERRUPT_MODEL.get().unwrap());

                info!("TLS template: {:#x?}", boot_info.tls_template);

                ahci_init();
                pci_impl::init(&mut tables);
            }
        }
        Err(e) => error!("Failed to parse the ACPI tables: {:#?}", e),
    }

    loop {
        unsafe {
            core::arch::asm!("hlt");
        };
    }
}

#[alloc_error_handler]
fn alloc_err(_layout: Layout) -> ! {
    panic!("Out of memory!")
}
