use alloc::vec::Vec;
use bootloader_api::info::{MemoryRegion, MemoryRegionKind, MemoryRegions};
use core::{num::NonZeroUsize, ops::DerefMut};
use spin::RwLock;
use x86_64::structures::paging::{frame::PhysFrameRangeInclusive, FrameDeallocator};
#[allow(unused_imports)] //future-proof
use x86_64::{
    registers::control::{Cr3, Cr3Flags},
    structures::paging::{
        FrameAllocator, Mapper, OffsetPageTable, Page, PageTable, PageTableFlags, PhysFrame,
        Size4KiB,
    },
    PhysAddr, VirtAddr,
};

use super::{get_falloc, get_mapper};
use crate::{ahci::util::sync::Mutex, get_boot_info, get_phys_offset};

unsafe fn active_pml4(offset: VirtAddr) -> &'static mut PageTable {
    let (pml4_frame, _) = Cr3::read();

    let phys = pml4_frame.start_address();
    let virt = offset + phys.as_u64();
    let ptpt = virt.as_mut_ptr::<PageTable>();

    &mut *ptpt // Safety: returns mutable reference to raw pointer
}

pub fn safe_active_pml4(offset: VirtAddr) -> Mutex<PageTable> {
    Mutex::new(unsafe { active_pml4(offset).clone() })
}

/// Creates an `x86:64::structures::paging::OffsetPageTable` using an offset provided as an argument
///
/// # Safety
///
/// As this function calls the `OffsetPageTable`'s constructor, the same safety rules for that apply here.
pub unsafe fn map_memory(offset: VirtAddr) -> OffsetPageTable<'static> {
    let pml4 = active_pml4(offset);
    OffsetPageTable::new(pml4, offset)
}

/// The frame allocator
pub struct KernelFrameAlloc {
    map: &'static MemoryRegions,
    next: usize,
}

impl KernelFrameAlloc {
    /// Creates a new frame allocator using the memory region slice provided by the bootloader
    ///
    /// # Safety
    ///
    /// Caller must ensure that the memory regions they're using point to valid addresses
    pub unsafe fn new(map: &'static MemoryRegions) -> Self {
        Self { map, next: 0 }
    }

    pub fn usable(&self) -> impl Iterator<Item = PhysFrame> + '_ {
        let all = self.map.iter();
        let usable = all.filter(|r| r.kind == MemoryRegionKind::Usable);

        let ranges = usable.map(|r| r.start..r.end);
        let faddrs = ranges.flat_map(|r| r.step_by(4096));
        faddrs.map(|a| PhysFrame::containing_address(PhysAddr::new(a)))
    }

    pub fn allocate_multiple(
        &mut self,
        size: usize,
    ) -> Option<(PhysFrameRangeInclusive<Size4KiB>, usize)> {
        let begin = self.usable().nth(self.next)?;
        let end = self.usable().nth(self.next + size)?;

        self.next += size + 1;

        Some((PhysFrame::range_inclusive(begin, end), self.next))
    }

    pub fn deallocate_multiple(&mut self, range: PhysFrameRangeInclusive<Size4KiB>) -> usize {
        for frame in range {
            unsafe { self.deallocate_frame(frame) };
        }

        range.count()
    }
}

unsafe impl FrameAllocator<Size4KiB> for KernelFrameAlloc {
    fn allocate_frame(&mut self) -> Option<PhysFrame<Size4KiB>> {
        let f = self.usable().nth(self.next);
        self.next += 1;
        f
    }
}

impl FrameDeallocator<Size4KiB> for KernelFrameAlloc {
    unsafe fn deallocate_frame(&mut self, mut _frame: PhysFrame<Size4KiB>) {
        let current_addr = _frame.start_address();

        let new_frame = PhysFrame::<Size4KiB>::containing_address(current_addr - 4096u64);
        let new_addr = new_frame.start_address();

        self.next -= 1;
        _frame = PhysFrame::containing_address(new_addr);
    }
}

/// Macro for ensuring pages are properly mapped
///
/// Converts the Result thrown by map_to() to an Option in order to handle the MapToError cases properly
#[macro_export]
macro_rules! map_page {
    ($phys:expr, $virt:expr, $size:ty, $flags:expr) => {
        // macros expect everything to be imported each time they're used in a new file, so best to hardcode paths
        let frame = x86_64::structures::paging::PhysFrame::containing_address(x86_64::PhysAddr::new($phys as u64));
        let page = x86_64::structures::paging::Page::<$size>::containing_address(x86_64::VirtAddr::new($virt as u64));

        x86_64::instructions::interrupts::without_interrupts(|| {
            // suppress warnings if this macro is called from an unsafe fn
            #[allow(unused_unsafe)]
            let res = unsafe {
                $crate::MAPPER.get().unwrap().write().map_to(
                    page,
                    frame,
                    $flags,
                    &mut *$crate::FRAME_ALLOCATOR.get().unwrap().write(),
                )
            };

            let flush = match res{
               Ok(flush) => Some(flush),
                Err(e) => match e {
                    x86_64::structures::paging::mapper::MapToError::FrameAllocationFailed => panic!("Out of memory"),
                    x86_64::structures::paging::mapper::MapToError::PageAlreadyMapped(_) => {
                        // Skip mapping as page already exists
                        None
                    }
                    x86_64::structures::paging::mapper::MapToError::ParentEntryHugePage => {
                        // Skip mapping as page already exists
                        None
                    }
                },
            };

            if let Some(flush) = flush {
                flush.flush();
            }
        });
    };
}

/// Macro for unmapping pages
///
/// Just like `map_page!`, this macro converts the `Result` thrown by `Mapper::unmap`
/// to an `Option<MapperFlush<S>>` so the errors can just be skipped before the page table
/// is flushed
#[macro_export]
macro_rules! unmap_page {
    ($page:expr) => {
        use log::debug;
        use x86_64::structures::paging::{mapper::UnmapError, Mapper};

        let flush = match $crate::MAPPER.get().unwrap().write().unmap($page) {
            Ok((_, flush)) => Some(flush),
            Err(e) => match e {
                UnmapError::ParentEntryHugePage => {
                    // Skip unmap as large page already exists here
                    None
                }
                UnmapError::PageNotMapped => {
                    // Skip unmap as page never existed to begin with
                    None
                }
                UnmapError::InvalidFrameAddress(_) => {
                    panic!("The address you attempted to unmap from doesn't exist")
                }
            },
        };

        if let Some(flush) = flush {
            flush.flush();
        }
    };
}

unsafe impl Send for KernelFrameAlloc {}
unsafe impl Sync for KernelFrameAlloc {}

// Dummy type for getting around the issue of KernelFrameAlloc not implementing Clone
#[derive(Clone)]
pub struct XhciMapper;

impl xhci::accessor::Mapper for XhciMapper {
    unsafe fn map(&mut self, phys_start: usize, bytes: usize) -> core::num::NonZeroUsize {
        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(phys_start as u64));

        map_page!(
            phys_start,
            test.start_address().as_u64(),
            Size4KiB,
            PageTableFlags::PRESENT
                | PageTableFlags::WRITABLE
                | PageTableFlags::NO_CACHE
                | PageTableFlags::WRITE_THROUGH
        );

        if bytes > 4096 {
            let mut i = 4096;

            while i < bytes {
                let phys = phys_start + i;
                let test = Page::<Size4KiB>::containing_address(VirtAddr::new(phys as u64));

                let virt = test.start_address().as_u64();

                map_page!(
                    phys,
                    virt,
                    Size4KiB,
                    PageTableFlags::PRESENT
                        | PageTableFlags::WRITABLE
                        | PageTableFlags::NO_CACHE
                        | PageTableFlags::WRITE_THROUGH
                );

                i += 4096;
            }
        }

        NonZeroUsize::new(phys_start as usize).unwrap()
    }

    fn unmap(&mut self, virt_start: usize, bytes: usize) {
        if bytes > 4096 {
            let mut i = 4096;

            while i < bytes {
                let virt = (virt_start + i) as u64;
                let p = Page::<Size4KiB>::containing_address(VirtAddr::new(virt));

                unmap_page!(p);

                i += 4096;
            }
        } else {
            let p = Page::<Size4KiB>::containing_address(VirtAddr::new(virt_start as u64));

            unmap_page!(p);
        }
    }
}

// Needed to allow access from statics
unsafe impl Send for XhciMapper {}
unsafe impl Sync for XhciMapper {}
