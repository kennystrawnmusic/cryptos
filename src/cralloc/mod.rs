use x86_64::structures::paging::OffsetPageTable;

use crate::{get_phys_offset, PHYS_OFFSET};

use self::frames::{map_memory, Falloc};

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

pub const BEGIN_HEAP: usize = 0x2000_0000_0000;
pub const HEAP_LEN: usize = 32 * 1024 * 1024;

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

// needed to avoid mapper/frame-allocator deadlocks after heap is initialized
const MAPPER_ADDR: u64 = PHYS_OFFSET * 2;
const FRAME_ALLOC_ADDR: u64 = MAPPER_ADDR * 2;

pub fn get_mapper() -> &'static mut OffsetPageTable<'static> {
    unsafe { &mut *(MAPPER_ADDR as *mut OffsetPageTable) }
}

pub fn get_frame_alloc() -> &'static mut Falloc {
    unsafe { &mut *(FRAME_ALLOC_ADDR as *mut Falloc) }
}

pub fn heap_init_shorthand() {
    let map = unsafe { map_memory(VirtAddr::new(get_phys_offset())) };
    let frame_alloc = unsafe { Falloc::new() };

    unsafe {
        // TODO: identity-map pages
        *(MAPPER_ADDR as *mut OffsetPageTable) = map;
        *(FRAME_ALLOC_ADDR as *mut Falloc) = frame_alloc;
    }

    heap_init(get_mapper(), get_frame_alloc())
        .unwrap_or_else(|e| panic!("Failed to initialize heap: {:#?}", e));
}
