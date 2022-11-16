pub mod frames;

#[allow(unused_imports)] //future-proof
use {
    slab_allocator_rs::*,
    x86_64::{
        structures::paging::{
            mapper::MapToError, FrameAllocator, Mapper, Page, PageTable, PageTableFlags, Size4KiB,
        },
        VirtAddr,
    },
};

#[global_allocator]
pub static ALLOC: LockedHeap = LockedHeap::empty();

pub const BEGIN_HEAP: usize = 0x5000_0000_0000;
pub const HEAP_LEN: usize = 64 * 1024 * 1024;

pub fn heap_init(
    mapper: &mut impl Mapper<Size4KiB>,
    falloc: &mut impl FrameAllocator<Size4KiB>,
) -> Result<(), MapToError<Size4KiB>> {
    let range = {
        let begin = VirtAddr::new(BEGIN_HEAP as u64);
        let end = begin + HEAP_LEN - 1u64;
        let first_page = Page::containing_address(begin);
        let last_page = Page::containing_address(end);
        Page::range_inclusive(first_page, last_page)
    };

    for p in range {
        let f = falloc
            .allocate_frame()
            .ok_or(MapToError::FrameAllocationFailed)?;
        let flags = PageTableFlags::PRESENT | PageTableFlags::WRITABLE;
        unsafe { mapper.map_to(p, f, flags, falloc)?.flush() };
    }

    unsafe {
        ALLOC.init(BEGIN_HEAP, HEAP_LEN);
    }

    Ok(())
}
