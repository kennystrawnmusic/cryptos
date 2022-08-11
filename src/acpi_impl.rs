use x86_64::instructions::port::Port;

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
        map_page!(
            address,
            address as u64 + unsafe { get_phys_offset() },
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe { core::ptr::read_volatile((address + get_phys_offset() as usize) as *const u8) }
    }

    fn read_u16(&self, address: usize) -> u16 {
        map_page!(
            address,
            address as u64 + unsafe { get_phys_offset() },
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe { core::ptr::read_volatile((address + get_phys_offset() as usize) as *const u16) }
    }

    fn read_u32(&self, address: usize) -> u32 {
        map_page!(
            address,
            address as u64 + unsafe { get_phys_offset() },
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe { core::ptr::read_volatile((address + get_phys_offset() as usize) as *const u32) }
    }

    fn read_u64(&self, address: usize) -> u64 {
        map_page!(
            address,
            address as u64 + unsafe { get_phys_offset() },
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe { core::ptr::read_volatile((address + get_phys_offset() as usize) as *const u64) }
    }

    fn write_u8(&mut self, address: usize, value: u8) {
        map_page!(
            address,
            address as u64 + unsafe { get_phys_offset() },
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe {
            core::ptr::write_volatile((address + get_phys_offset() as usize) as *mut u8, value)
        }
    }

    fn write_u16(&mut self, address: usize, value: u16) {
        map_page!(
            address,
            address as u64 + unsafe { get_phys_offset() },
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe {
            core::ptr::write_volatile((address + get_phys_offset() as usize) as *mut u16, value)
        }
    }

    fn write_u32(&mut self, address: usize, value: u32) {
        map_page!(
            address,
            address as u64 + unsafe { get_phys_offset() },
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );

        unsafe {
            core::ptr::write_volatile((address + get_phys_offset() as usize) as *mut u32, value)
        }
    }

    fn write_u64(&mut self, address: usize, value: u64) {
        map_page!(
            address,
            address as u64 + unsafe { get_phys_offset() },
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

        map_page!(
            rebuilt,
            rebuilt as u64 + unsafe { get_phys_offset() },
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

        map_page!(
            rebuilt,
            rebuilt as u64 + unsafe { get_phys_offset() },
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

        map_page!(
            rebuilt,
            rebuilt as u64 + unsafe { get_phys_offset() },
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

        map_page!(
            rebuilt,
            rebuilt as u64 + unsafe { get_phys_offset() },
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

        map_page!(
            rebuilt,
            rebuilt as u64 + unsafe { get_phys_offset() },
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

        map_page!(
            rebuilt,
            rebuilt as u64 + unsafe { get_phys_offset() },
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
