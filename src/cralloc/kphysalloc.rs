use x86_64::structures::paging::mapper::UnmapError;

use {
    crate::{get_phys_offset, map_page},
    core::ptr::{read_volatile, write_volatile},
    // TODO
    x86_64::{
        structures::paging::{Mapper, Page, PageTableFlags, Size4KiB},
        VirtAddr,
    },
};

// Implementation objective: use map_page! macro along with more test pages to create physical mappings,
// then use read_volatile and write_volatile to actually perform operations
// Completion ETA: 8/13/2022 4PM PDT (UTC-7)

pub fn kphysalloc(size: usize) -> usize {
    let test_addr = VirtAddr::new(size as u64);
    let test_page = Page::<Size4KiB>::containing_address(test_addr);
    let mut virt = test_page.start_address().as_u64() + unsafe { get_phys_offset() };

    // capture the original address before incrementing
    let virt_clone = virt.clone();

    for _ in 0..(crate::page_align(size as u64, virt) / test_page.size() as usize) {
        map_page!(
            size,
            virt,
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );
        virt += test_page.size();
    }

    // return the start address
    virt_clone as usize
}

pub fn kphysfree(size: usize) {
    // same as before: use a test page to determine proper alignment
    let test_addr = VirtAddr::new(size as u64 + unsafe { get_phys_offset() });
    let test_page = Page::<Size4KiB>::containing_address(test_addr);
    let mut _virt = (test_page.start_address().as_u64() as usize)
        + crate::page_align(size as u64, test_addr.as_u64());

    for p in (size / crate::page_align(size as u64, test_addr.as_u64()))..0 {
        let test_addr_inner = VirtAddr::new((size as u64 + ((test_page.size() as u64) * (p as u64))) as u64);
        let to_free = Page::<Size4KiB>::containing_address(test_addr_inner);

        let flush = if let Ok((_, free_flush)) = crate::MAPPER.get().unwrap().lock().unmap(to_free) {
            Some(free_flush)
        } else {
            None
        };

        if let Some(free_flush) = flush {
            free_flush.flush();
        }

        _virt -= test_page.size() as usize; // reverse order
    }
}
