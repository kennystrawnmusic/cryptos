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
use crate::{ahci::util::sync::Mutex, get_boot_info, get_phys_offset, map_page, unmap_page};

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

unsafe impl Send for KernelFrameAlloc {}
unsafe impl Sync for KernelFrameAlloc {}