#[allow(unused_imports)] //future-proof
use {
    bootloader::boot_info::{MemoryRegion, MemoryRegionKind, MemoryRegions},
    x86_64::{
        registers::control::Cr3,
        structures::paging::{
            FrameAllocator, Mapper, OffsetPageTable, Page, PageTable, PhysFrame, Size4KiB,
        },
        PhysAddr, VirtAddr,
    },
};

unsafe fn active_pml4(offset: VirtAddr) -> &'static mut PageTable {
    let (pml4_frame, _) = Cr3::read();

    let phys = pml4_frame.start_address();
    let virt = offset + phys.as_u64();
    let ptpt: *mut PageTable = virt.as_mut_ptr();

    &mut *ptpt // Safety: returns mutable reference to raw pointer
}

pub unsafe fn map_memory(offset: VirtAddr) -> OffsetPageTable<'static> {
    let pml4 = active_pml4(offset);
    OffsetPageTable::new(pml4, offset)
}

pub struct Falloc {
    map: &'static MemoryRegions,
    next: usize,
}

impl Falloc {
    pub unsafe fn new(map: &'static MemoryRegions) -> Self {
        Self { map, next: 0 }
    }

    pub fn usable(&self) -> impl Iterator<Item = PhysFrame> {
        let all = self.map.iter();
        let usable = all.filter(|r| r.kind == MemoryRegionKind::Usable);

        let ranges = usable.map(|r| r.start..r.end);
        let faddrs = ranges.flat_map(|r| r.step_by(4096));
        faddrs.map(|a| PhysFrame::containing_address(PhysAddr::new(a)))
    }
}

unsafe impl FrameAllocator<Size4KiB> for Falloc {
    fn allocate_frame(&mut self) -> Option<PhysFrame<Size4KiB>> {
        let f = self.usable().nth(self.next);
        self.next += 1;
        f
    }
}

/// Macro for ensuring pages are properly mapped
///
/// Converts the Result thrown by map_to() to an Option in order to handle the MapToError cases properly
#[macro_export]
macro_rules! map_page {
    ($phys:expr, $virt:expr, $size:ty, $flags:expr) => {
        // macros expect everything to be imported each time they're used in a new file, so best to hardcode paths
        let frame = x86_64::structures::paging::PhysFrame::<$size>::containing_address(x86_64::PhysAddr::new($phys as u64));
        let page = x86_64::structures::paging::Page::<$size>::containing_address(x86_64::VirtAddr::new($virt as u64));

        // suppress warnings if this macro is called from an unsafe fn
        #[allow(unused_unsafe)]
        let res = unsafe {
            crate::MAPPER.get().unwrap().lock().map_to(
                page,
                frame,
                $flags,
                &mut *crate::FRAME_ALLOCATOR.get().unwrap().lock(),
            )
        };

        let flush = match res{
            Ok(flush) => Some(flush),
            Err(e) => match e {
                x86_64::structures::paging::mapper::MapToError::FrameAllocationFailed => panic!("Out of memory"),
                x86_64::structures::paging::mapper::MapToError::PageAlreadyMapped(_) => {
                    log::debug!("Already have a page here; skipping mapping");
                    None
                }
                x86_64::structures::paging::mapper::MapToError::ParentEntryHugePage => {
                    log::debug!("Already have a huge page here; skipping mapping");
                    None
                }
            },
        };

        if let Some(flush) = flush {
            flush.flush();
        }
    };
}

#[macro_export]
macro_rules! map_page_from {
    ($phys:expr, $virt:expr, $size:ty, $flags:expr) => {
        // macros expect everything to be imported each time they're used in a new file, so best to hardcode paths
        let frame = x86_64::structures::paging::PhysFrame::<$size>::containing_address(x86_64::PhysAddr::new($phys as u64));
        let page = x86_64::structures::paging::Page::<$size>::from_start_address(x86_64::VirtAddr::new($virt as u64)).unwrap();

        // suppress warnings if this macro is called from an unsafe fn
        #[allow(unused_unsafe)]
        let res = unsafe {
            crate::MAPPER.get().unwrap().lock().map_to(
                page,
                frame,
                $flags,
                &mut *crate::FRAME_ALLOCATOR.get().unwrap().lock(),
            )
        };

        let flush = match res{
            Ok(flush) => Some(flush),
            Err(e) => match e {
                x86_64::structures::paging::mapper::MapToError::FrameAllocationFailed => panic!("Out of memory"),
                x86_64::structures::paging::mapper::MapToError::PageAlreadyMapped(_) => {
                    log::debug!("Already have a page here; skipping mapping");
                    None
                }
                x86_64::structures::paging::mapper::MapToError::ParentEntryHugePage => {
                    log::debug!("Already have a huge page here; skipping mapping");
                    None
                }
            },
        };

        if let Some(flush) = flush {
            flush.flush();
        }
    };
}

unsafe impl Send for Falloc {}
unsafe impl Sync for Falloc {}
