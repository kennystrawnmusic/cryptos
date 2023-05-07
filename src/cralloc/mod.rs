use core::{
    ptr::addr_of,
    sync::atomic::{AtomicU64, Ordering},
};

use x86_64::structures::paging::OffsetPageTable;

use crate::{get_boot_info, get_phys_offset, map_memory, FRAME_ALLOCATOR, MAPPER};
use spin::Mutex;

use self::frames::Falloc;

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

pub static MAP_ADDR: AtomicU64 = AtomicU64::new(0);
pub static FRAME_ALLOC_ADDR: AtomicU64 = AtomicU64::new(0);

pub fn get_mapper<'a>() -> &'a mut OffsetPageTable<'static> {
    unsafe { &mut *(MAP_ADDR.load(Ordering::SeqCst) as *mut OffsetPageTable) }
}

pub fn get_falloc<'a>() -> &'a mut Falloc {
    unsafe { &mut *(FRAME_ALLOC_ADDR.load(Ordering::SeqCst) as *mut Falloc) }
}

pub fn heap_init_inner(
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

        let flags = PageTableFlags::PRESENT
            | PageTableFlags::WRITABLE
            | PageTableFlags::NO_CACHE
            | PageTableFlags::WRITE_THROUGH;

        unsafe { mapper.map_to(p, f, flags, falloc)?.flush() };
    }

    unsafe {
        ALLOC.init(BEGIN_HEAP, HEAP_LEN);
    }

    Ok(())
}

pub fn heap_init() {
    let boot_info = get_boot_info();

    let offset = VirtAddr::new(unsafe { get_phys_offset() });

    let map = unsafe { map_memory(offset) };
    let falloc = unsafe { Falloc::new(&boot_info.memory_regions) };

    MAPPER.get_or_init(move || Mutex::new(map));
    FRAME_ALLOCATOR.get_or_init(move || Mutex::new(falloc));

    heap_init_inner(
        &mut *MAPPER.get().unwrap().lock(),
        &mut *FRAME_ALLOCATOR.get().unwrap().lock(),
    )
    .unwrap_or_else(|e| panic!("Failed to initialize heap: {:#?}", e));
}
