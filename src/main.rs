#![no_std]
#![no_main]
#![feature(
    allocator_api,
    alloc_error_handler,
    assert_matches,
    async_iterator,
    error_in_core,
    ip_in_core,
    core_panic,
    unicode_internals,
    abi_x86_interrupt,
    maybe_uninit_slice,
    never_type,
    target_feature_11,
    portable_simd,
    repr_simd,
    const_mut_refs,
    const_option,
    const_trait_impl,
    coroutines,
    coroutine_trait,
    coroutine_clone,
    core_intrinsics,
    intrinsics,
    extract_if,
    strict_provenance,
    split_array,
    generic_arg_infer,
    box_into_inner,
    unsized_locals,
    associated_type_bounds,
    ptr_metadata,
    array_chunks,
    slice_index_methods,
    slice_flatten,
    iter_array_chunks,
    slice_from_ptr_range,
    cfg_match,
    concat_bytes,
    concat_idents,
    const_format_args,
    format_args_nl,
    log_syntax,
    trace_macros,
    const_type_id
)]
#![allow(internal_features)]
#![allow(incomplete_features)]
#![allow(clippy::option_map_unit_fn)]

extern crate alloc;

pub mod arch;
pub mod common;
pub mod cralloc;
pub mod drivers;
pub mod drm;
pub mod fs;
pub mod process;
pub mod scheme;

use crate::{
    acpi_impl::{system_shutdown, KernelAcpi},
    drm::COMPOSITING_TABLE,
};
use acpi::{AcpiTables, InterruptModel, PciConfigRegions, PlatformInfo};
use alloc::{alloc::Global, boxed::Box};
use bootloader_api::{
    config::{Mapping, Mappings},
    info::{FrameBuffer, FrameBufferInfo, Optional, TlsTemplate},
    *,
};
use common::Printk;
use conquer_once::spin::OnceCell;
use core::{
    alloc::Layout,
    panic::PanicInfo,
    sync::atomic::{AtomicU64, Ordering},
};

use drivers::acpi_impl::UserAcpi;
use log::{debug, error, info};
use raw_cpuid::CpuId;
use spin::Once;
use x86_64::structures::paging::PhysFrame;

pub use common::std_init as std;

// Needed to clean up main while still ensuring that everything else works
pub use cralloc::*;

//compatibility
#[cfg(target_arch = "x86_64")]
pub use arch::x86_64::exceptions;
#[cfg(target_arch = "x86_64")]
pub use arch::x86_64::interrupts;
#[cfg(target_arch = "x86_64")]
pub use arch::x86_64::*;

pub use drivers::acpi_impl::aml_init;
pub use drivers::*;

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    error!("Kernel panic -- not syncing: {info}");
    if cfg!(feature = "shutdown_on_panic") {
        unsafe { system_shutdown() };
    } else {
        loop {}
    }
}
// needed to allow access outside main.rs
const BOOT_INFO_ADDR: u64 = (BEGIN_HEAP / 32) as u64;

/// Function that extracts BootInfo from raw pointer to BootInfo address
pub const fn get_boot_info<'a>() -> &'a mut BootInfo {
    unsafe { &mut *(BOOT_INFO_ADDR as *mut BootInfo) }
}

/// Function that uses the other function that extracts BootInfo
/// from the raw pointer to the BootInfo address
/// to in turn retrieve a mutable reference to the framebuffer
pub fn get_framebuffer<'a>() -> &'a mut FrameBuffer {
    get_boot_info::<'a>().framebuffer.as_mut().unwrap()
}

// high half
const KERNEL_STACK_ADDR: u64 = 0xffff_0000_0000;

const MAPPINGS: Mappings = {
    let mut mappings = Mappings::new_default();
    mappings.kernel_stack = Mapping::FixedAddress(KERNEL_STACK_ADDR);
    mappings.boot_info = Mapping::FixedAddress(BOOT_INFO_ADDR);
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
    config.kernel_stack_size = 1024 * 1024 * 128;
    config
};

pub static PRINTK: OnceCell<Printk> = OnceCell::uninit();

/// Convenient wrapper for getting the next usable `PhysFrame` on the frame allocator's list
pub fn get_next_usable_frame() -> PhysFrame {
    FRAME_ALLOCATOR
        .read()
        .usable()
        .next()
        .expect("Out of memory")
}

/// Convenient wrapper for getting the physical memory offset
pub fn get_phys_offset() -> u64 {
    *(get_boot_info().physical_memory_offset.as_ref().unwrap())
}

pub static INTERRUPT_MODEL: OnceCell<InterruptModel<Global>> = OnceCell::uninit();
pub static PCI_CONFIG: OnceCell<Option<PciConfigRegions<Global>>> = OnceCell::uninit();

pub fn get_mcfg<'a>() -> &'a Option<PciConfigRegions<'a, Global>> {
    PCI_CONFIG.get().unwrap()
}

pub fn printk_init(buffer: &'static mut [u8], info: FrameBufferInfo) {
    let p = PRINTK.get_or_init(move || Printk::new(buffer, info));
    log::set_logger(p).expect("Logger has already been set!");

    // Don't flood users with excessive messages if compiled with "--release"
    if cfg!(opt_level = "0") {
        log::set_max_level(log::LevelFilter::Trace);
    } else {
        log::set_max_level(log::LevelFilter::Info);
    }
    info!("CryptOS v. {}", env!("CARGO_PKG_VERSION"));
}

pub static TLS_TEMPLATE_ADDR: AtomicU64 = AtomicU64::new(0);
pub const TLS_TEMPLATE_SIZE: u64 = 0x600_0000; //100MB; increasing later as app size increases

pub(crate) static USER_ACPI: Once<UserAcpi> = Once::new();

entry_point!(maink, config = &CONFIG);

pub fn maink(boot_info: &'static mut BootInfo) -> ! {
    // load the GDT early because repeated GDT loads cause a #GP
    crate::arch::x86_64::exceptions::init();

    // map the TLS template onto the heap to ensure proper memory safety
    TLS_TEMPLATE_ADDR.store(Box::into_raw(Box::new(0)) as usize as u64, Ordering::SeqCst);

    let tls = TlsTemplate {
        start_addr: TLS_TEMPLATE_ADDR.load(Ordering::SeqCst),
        file_size: TLS_TEMPLATE_SIZE - 1,
        mem_size: TLS_TEMPLATE_SIZE,
    };

    boot_info.tls_template = Optional::Some(tls);

    let buffer_optional = &mut boot_info.framebuffer;
    let buffer_option = buffer_optional.as_mut();
    let buffer = buffer_option.unwrap();
    let bi = buffer.info();
    let raw_buffer = buffer.buffer_mut();

    let rsdp = boot_info.rsdp_addr.into_option().unwrap();
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

    match unsafe { AcpiTables::from_rsdp(KernelAcpi, rsdp as usize) } {
        Ok(tables) => {
            USER_ACPI.call_once(|| UserAcpi::new(&tables));

            let mcfg = match PciConfigRegions::new_in(&tables, Global) {
                Ok(mcfg) => Some(mcfg),
                Err(_) => None,
            };

            if let Ok(platform_info) = PlatformInfo::new_in(&tables, Global) {
                let interrupts = platform_info.interrupt_model;

                INTERRUPT_MODEL.get_or_init(move || interrupts);
                PCI_CONFIG.get_or_init(move || mcfg);

                debug!("Interrupt model: {:#?}", INTERRUPT_MODEL.get().unwrap());

                debug!("TLS template: {:#x?}", boot_info.tls_template);
                pci_impl::init(&tables);
            }
        }
        Err(e) => error!("Failed to parse the ACPI tables: {:?}", e),
    }

    // Use the loop at the end of main as the rendering loop
    loop {
        if !(COMPOSITING_TABLE.read().is_empty()) {
            for canvas in COMPOSITING_TABLE.read().iter() {
                canvas.merge_down(get_framebuffer());
            }
        }
    }
}

#[alloc_error_handler]
fn alloc_err(_layout: Layout) -> ! {
    panic!("Out of memory!")
}
