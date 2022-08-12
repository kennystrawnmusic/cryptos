use {
    crate::{map_page, get_phys_offset},
    x86_64::{structures::paging::{Mapper, Page, PageTableFlags, Size4KiB},VirtAddr},
    core::ptr::{read_volatile, write_volatile},
    // TODO
};

// Implementation objective: use map_page! macro along with more test pages to create physical mappings,
// then use read_volatile and write_volatile to actually perform operations
// Completion ETA: 8/13/2022 4PM PDT (UTC-7)

pub fn kphysalloc(size: usize) -> usize {
    let test_addr = VirtAddr::new(size as u64);
    let test_page = Page::<Size4KiB>::containing_address(test_addr);
    let virt = test_page.start_address().as_u64() + unsafe { get_phys_offset() };

    map_page!(
        size,
        virt,
        Size4KiB,
        PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
    );

    crate::page_align(size as u64, virt)
}