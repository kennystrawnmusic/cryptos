use core::sync::atomic::Ordering;

use acpi::{fadt::Fadt, sdt::SdtHeader};
use aml::{
    pci_routing::{PciRoutingTable, Pin},
    value::Args,
    AmlName, AmlValue,
};
use log::debug;
use pcics::{header::InterruptPin, Header};
use x86_64::instructions::port::Port;

use crate::interrupts::{INTA_IRQ, INTB_IRQ, INTC_IRQ, INTD_IRQ};

use {
    crate::{get_phys_offset, map_page},
    acpi::{
        sdt::Signature, AcpiError, AcpiHandler, AcpiTables, HpetInfo, InterruptModel,
        PciConfigRegions, PhysicalMapping, PlatformInfo, RsdpError,
    },
    alloc::boxed::Box,
    alloc::sync::Arc,
    alloc::vec::Vec,
    aml::AmlContext,
    core::{arch::asm, ptr::NonNull},
    x86_64::{
        structures::paging::{
            mapper::MapToError, Mapper, OffsetPageTable, Page, PageTableFlags, PhysFrame, Size4KiB,
        },
        PhysAddr, VirtAddr,
    },
};

/// Creates a page-aligned size of something by creating a test page at a given address
///
pub fn page_align(size: u64, addr: u64) -> usize {
    let test = Page::<Size4KiB>::containing_address(VirtAddr::new(addr));
    let test_size = test.size() as usize;

    (((size as usize) - 1) / test_size + 1) * test_size
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

impl aml::Handler for KernelAcpi {
    fn read_u8(&self, address: usize) -> u8 {
        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(address as u64));
        let test_start = test.start_address().as_u64();

        map_page!(
            address,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe { core::ptr::read_volatile((address + get_phys_offset() as usize) as *const u8) }
    }

    fn read_u16(&self, address: usize) -> u16 {
        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(address as u64));
        let test_start = test.start_address().as_u64();

        map_page!(
            address,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe { core::ptr::read_volatile((address + get_phys_offset() as usize) as *const u16) }
    }

    fn read_u32(&self, address: usize) -> u32 {
        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(address as u64));
        let test_start = test.start_address().as_u64();

        map_page!(
            address,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe { core::ptr::read_volatile((address + get_phys_offset() as usize) as *const u32) }
    }

    fn read_u64(&self, address: usize) -> u64 {
        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(address as u64));
        let test_start = test.start_address().as_u64();

        map_page!(
            address,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe { core::ptr::read_volatile((address + get_phys_offset() as usize) as *const u64) }
    }

    fn write_u8(&mut self, address: usize, value: u8) {
        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(address as u64));
        let test_start = test.start_address().as_u64();

        map_page!(
            address,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe {
            core::ptr::write_volatile((address + get_phys_offset() as usize) as *mut u8, value)
        }
    }

    fn write_u16(&mut self, address: usize, value: u16) {
        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(address as u64));
        let test_start = test.start_address().as_u64();

        map_page!(
            address,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe {
            core::ptr::write_volatile((address + get_phys_offset() as usize) as *mut u16, value)
        }
    }

    fn write_u32(&mut self, address: usize, value: u32) {
        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(address as u64));
        let test_start = test.start_address().as_u64();

        map_page!(
            address,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe {
            core::ptr::write_volatile((address + get_phys_offset() as usize) as *mut u32, value)
        }
    }

    fn write_u64(&mut self, address: usize, value: u64) {
        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(address as u64));
        let test_start = test.start_address().as_u64();
        map_page!(
            address,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe {
            core::ptr::write_volatile((address + get_phys_offset() as usize) as *mut u64, value)
        }
    }

    fn read_io_u8(&self, port: u16) -> u8 {
        let res: u8;
        unsafe {
            asm!("in al, dx", in("dx") port, out("al") res);
        }
        return res;
    }

    fn read_io_u16(&self, port: u16) -> u16 {
        let res: u16;
        unsafe {
            asm!("in ax, dx", in("dx") port, out("ax") res);
        }
        return res;
    }

    fn read_io_u32(&self, port: u16) -> u32 {
        let res: u32;
        unsafe {
            asm!("in eax, dx", in("dx") port, out("eax") res);
        }
        return res;
    }

    fn write_io_u8(&self, port: u16, value: u8) {
        unsafe {
            asm!("out dx, al", in("dx") port, in("al") value);
        }
    }

    fn write_io_u16(&self, port: u16, value: u16) {
        unsafe {
            asm!("out dx, ax", in("dx") port, in("ax") value);
        }
    }

    fn write_io_u32(&self, port: u16, value: u32) {
        unsafe {
            asm!("out dx, eax", in("dx") port, in("eax") value);
        }
    }

    fn read_pci_u8(&self, segment: u16, bus: u8, device: u8, function: u8, offset: u16) -> u8 {
        let seg_bytes = segment.to_be_bytes();
        let offs_bytes = offset.to_be_bytes();
        let rebuilt = u64::from_be_bytes([
            0,
            seg_bytes[0],
            seg_bytes[1],
            bus,
            device,
            function,
            offs_bytes[0],
            offs_bytes[1],
        ]);

        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(rebuilt));
        let test_start = test.start_address().as_u64();

        map_page!(
            rebuilt,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe { core::ptr::read_volatile(((rebuilt + get_phys_offset()) as usize) as *const u8) }
    }

    fn read_pci_u16(&self, segment: u16, bus: u8, device: u8, function: u8, offset: u16) -> u16 {
        let seg_bytes = segment.to_be_bytes();
        let offs_bytes = offset.to_be_bytes();
        let rebuilt = u64::from_be_bytes([
            0,
            seg_bytes[0],
            seg_bytes[1],
            bus,
            device,
            function,
            offs_bytes[0],
            offs_bytes[1],
        ]);

        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(rebuilt));
        let test_start = test.start_address().as_u64();

        map_page!(
            rebuilt,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe { core::ptr::read_volatile(((rebuilt + get_phys_offset()) as usize) as *const u16) }
    }

    fn read_pci_u32(&self, segment: u16, bus: u8, device: u8, function: u8, offset: u16) -> u32 {
        let seg_bytes = segment.to_be_bytes();
        let offs_bytes = offset.to_be_bytes();
        let rebuilt = u64::from_be_bytes([
            0,
            seg_bytes[0],
            seg_bytes[1],
            bus,
            device,
            function,
            offs_bytes[0],
            offs_bytes[1],
        ]);

        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(rebuilt));
        let test_start = test.start_address().as_u64();

        map_page!(
            rebuilt,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe { core::ptr::read_volatile(((rebuilt + get_phys_offset()) as usize) as *const u32) }
    }

    fn write_pci_u8(
        &self,
        segment: u16,
        bus: u8,
        device: u8,
        function: u8,
        offset: u16,
        value: u8,
    ) {
        let seg_bytes = segment.to_be_bytes();
        let offs_bytes = offset.to_be_bytes();
        let rebuilt = u64::from_be_bytes([
            0,
            seg_bytes[0],
            seg_bytes[1],
            bus,
            device,
            function,
            offs_bytes[0],
            offs_bytes[1],
        ]);

        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(rebuilt));
        let test_start = test.start_address().as_u64();

        map_page!(
            rebuilt,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe {
            core::ptr::write_volatile(((rebuilt + get_phys_offset()) as usize) as *mut u8, value)
        }
    }

    fn write_pci_u16(
        &self,
        segment: u16,
        bus: u8,
        device: u8,
        function: u8,
        offset: u16,
        value: u16,
    ) {
        let seg_bytes = segment.to_be_bytes();
        let offs_bytes = offset.to_be_bytes();
        let rebuilt = u64::from_be_bytes([
            0,
            seg_bytes[0],
            seg_bytes[1],
            bus,
            device,
            function,
            offs_bytes[0],
            offs_bytes[1],
        ]);

        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(rebuilt));
        let test_start = test.start_address().as_u64();

        map_page!(
            rebuilt,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe {
            core::ptr::write_volatile(((rebuilt + get_phys_offset()) as usize) as *mut u16, value)
        }
    }

    fn write_pci_u32(
        &self,
        segment: u16,
        bus: u8,
        device: u8,
        function: u8,
        offset: u16,
        value: u32,
    ) {
        let seg_bytes = segment.to_be_bytes();
        let offs_bytes = offset.to_be_bytes();
        let rebuilt = u64::from_be_bytes([
            0,
            seg_bytes[0],
            seg_bytes[1],
            bus,
            device,
            function,
            offs_bytes[0],
            offs_bytes[1],
        ]);

        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(rebuilt));
        let test_start = test.start_address().as_u64();

        map_page!(
            rebuilt,
            test_start + unsafe { get_phys_offset() } + test.size(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe {
            core::ptr::write_volatile(((rebuilt + get_phys_offset()) as usize) as *mut u32, value)
        }
    }
}

unsafe impl Send for KernelAcpi {}
unsafe impl Sync for KernelAcpi {}

pub fn aml_init(
    tables: &mut AcpiTables<KernelAcpi>,
    header: &mut Header,
) -> Option<[(u32, InterruptPin); 4]> {
    debug!("Parsing AML");
    let mut aml_ctx = AmlContext::new(Box::new(KernelAcpi), aml::DebugVerbosity::Scopes);

    let fadt = unsafe { &mut tables.get_sdt::<Fadt>(Signature::FADT).unwrap().unwrap() };

    // Properly reintroduce the size/length of the header
    let dsdt_addr = fadt.dsdt_address().unwrap();
    debug!("DSDT address: {:#x}", dsdt_addr.clone());
    let dsdt_len = tables.dsdt.as_ref().unwrap().length.clone() as usize;

    let aml_test_page =
        Page::<Size4KiB>::containing_address(VirtAddr::new(dsdt_addr.clone() as u64));
    let aml_virt = aml_test_page.start_address().as_u64() + unsafe { get_phys_offset() };

    map_page!(
        dsdt_addr,
        aml_virt,
        Size4KiB,
        PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
    );

    let raw_table = unsafe {
        core::slice::from_raw_parts_mut(
            aml_virt as *mut u8,
            dsdt_len.clone() + core::mem::size_of::<SdtHeader>(),
        )
    };

    if let Ok(()) = aml_ctx.initialize_objects() {
        if let Ok(()) =
            aml_ctx.parse_table(&raw_table.split_at_mut(core::mem::size_of::<SdtHeader>()).1)
        {
            // Make sure AML knows that the APIC, not the legacy PIC, is what's being used
            let _ = aml_ctx.invoke_method(
                &AmlName::from_str("\\_PIC").unwrap(),
                Args([
                    Some(AmlValue::Integer(1)),
                    None,
                    None,
                    None,
                    None,
                    None,
                    None,
                ]),
            );

            if let Ok(prt) = PciRoutingTable::from_prt_path(
                &AmlName::from_str("\\_SB.PCI0._PRT").unwrap(),
                &mut aml_ctx,
            ) {
                let mut a: [(u32, InterruptPin); 4] = [
                    (0, InterruptPin::IntA),
                    (0, InterruptPin::IntB),
                    (0, InterruptPin::IntC),
                    (0, InterruptPin::IntD),
                ];
                if let Ok(desc) = prt.route(
                    header.class_code.base as u16,
                    header.class_code.base as u16,
                    Pin::IntA,
                    &mut aml_ctx,
                ) {
                    debug!("IntA IRQ number: {:#?}", desc.irq.clone());
                    INTA_IRQ.store((desc.irq.clone() + 32) as u64, Ordering::SeqCst);
                    a[0] = (desc.irq, InterruptPin::IntA);
                }
                if let Ok(desc) = prt.route(
                    header.class_code.base as u16,
                    header.class_code.base as u16,
                    Pin::IntB,
                    &mut aml_ctx,
                ) {
                    debug!("IntB IRQ number: {:#?}", desc.irq.clone());
                    INTB_IRQ.store((desc.irq.clone() + 32) as u64, Ordering::SeqCst);
                    a[1] = (desc.irq, InterruptPin::IntB);
                }
                if let Ok(desc) = prt.route(
                    header.class_code.base as u16,
                    header.class_code.base as u16,
                    Pin::IntC,
                    &mut aml_ctx,
                ) {
                    debug!("IntC IRQ number: {:#?}", desc.irq.clone());
                    INTC_IRQ.store((desc.irq.clone() + 32) as u64, Ordering::SeqCst);
                    a[2] = (desc.irq, InterruptPin::IntC);
                }
                if let Ok(desc) = prt.route(
                    header.class_code.base as u16,
                    header.class_code.base as u16,
                    Pin::IntD,
                    &mut aml_ctx,
                ) {
                    debug!("IntD IRQ number: {:#?}", desc.irq.clone());
                    INTD_IRQ.store((desc.irq.clone() + 32) as u64, Ordering::SeqCst);
                    a[3] = (desc.irq, InterruptPin::IntD);
                }
                return Some(a);
            }
            return None;
        }
        return None;
    }
    None
}
