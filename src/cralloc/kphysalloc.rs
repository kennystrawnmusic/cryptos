use core::marker::PhantomData;

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
    let test_addr = VirtAddr::new(size as u64 + unsafe { get_phys_offset() });
    let test_page = Page::<Size4KiB>::containing_address(test_addr);
    let mut virt = test_page.start_address().as_u64();

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

pub fn kphysfree(addr: usize, size: usize) {
    // same as before: use a test page to determine proper alignment
    let test_addr = VirtAddr::new(addr as u64 + size as u64 + unsafe { get_phys_offset() });
    let test_page = Page::<Size4KiB>::containing_address(test_addr);
    let mut virt = (test_page.start_address().as_u64() as usize)
        + crate::page_align(size as u64, test_addr.as_u64());

    for _ in (size / (test_page.size() as usize))..0 {
        let free_addr = VirtAddr::new(virt as u64);
        let to_free = Page::<Size4KiB>::containing_address(free_addr);

        let flush = if let Ok((_, free_flush)) = crate::MAPPER.get().unwrap().lock().unmap(to_free)
        {
            Some(free_flush)
        } else {
            None
        };

        if let Some(free_flush) = flush {
            free_flush.flush();
        }

        virt -= to_free.size() as usize; // reverse order
    }
}

/// RAII guard of a page mapping.
/// Does a lot of automatic page aligning behind the scenes to ensure better memory safety than `redox_syscall`'s PhysBox does
#[derive(Debug)]
pub struct PageBox<T: ?Sized> {
    address: usize,
    size: usize,
    marker: PhantomData<T>,
}

impl<T> PageBox<T> {
    pub unsafe fn from_raw_parts(address: usize, size: usize) -> Self {
        // again: use a test page to get page alignment out of the way
        let test_addr = VirtAddr::new(address as u64);
        let test_page = Page::<Size4KiB>::containing_address(test_addr);
        let phys = test_page.start_address().as_u64();

        let virt = (phys + get_phys_offset()) as usize;
        let aligned_size = crate::page_align(size as u64, virt as u64);

        Self {
            address: virt,
            size: aligned_size,
            marker: PhantomData,
        }
    }

    pub fn address(&self) -> usize {
        self.address
    }

    pub fn size(&self) -> usize {
        self.size
    }

    pub fn new(size: usize) -> syscall::Result<Self> {
        let addr = kphysalloc(size);
        Ok(unsafe { Self::from_raw_parts(addr, size) })
    }
}

impl<T: ?Sized> Drop for PageBox<T> {
    fn drop(&mut self) {
        kphysfree(self.address, self.size);
    }
}
