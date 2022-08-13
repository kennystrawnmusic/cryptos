use core::{marker::PhantomData, mem::MaybeUninit};

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

pub fn kphysmap(address: usize, size: usize) -> usize {
    let phys_test_addr = VirtAddr::new(address as u64);
    let phys_test_page = Page::<Size4KiB>::containing_address(phys_test_addr);
    let mut phys = phys_test_page.start_address().as_u64();

    let virt_test_addr = VirtAddr::new(phys as u64 + unsafe { get_phys_offset() });
    let virt_test_page = Page::<Size4KiB>::containing_address(virt_test_addr);
    let mut virt = virt_test_page.start_address().as_u64();

    // capture before incrementing
    let virt_clone = virt.clone() as usize;

    for _ in 0..(crate::page_align(size.clone() as u64, virt) / virt_test_page.size() as usize) {
        map_page!(
            phys,
            virt,
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );
        phys += virt_test_page.size();
        virt += virt_test_page.size();
    }

    // return start of the virtual mapping
    virt_clone
}

pub fn kphysalloc(size: usize) -> (usize, usize) {
    // get physical address from next available usable page frame
    let phys_raw = crate::get_next_usable_frame().start_address().as_u64();

    let phys_test_addr = VirtAddr::new(phys_raw);
    let phys_test_page = Page::<Size4KiB>::containing_address(phys_test_addr);
    let mut phys = phys_test_page.start_address().as_u64();

    let virt_test_addr = VirtAddr::new(phys as u64 + unsafe { get_phys_offset() });
    let virt_test_page = Page::<Size4KiB>::containing_address(virt_test_addr);
    let mut virt = virt_test_page.start_address().as_u64();

    // capture the original addresses before incrementing
    let phys_clone = phys.clone() as usize;
    let virt_clone = virt.clone() as usize;

    for _ in 0..(crate::page_align(size.clone() as u64, virt) / virt_test_page.size() as usize) {
        map_page!(
            phys,
            virt,
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
        );
        phys += virt_test_page.size();
        virt += virt_test_page.size();
    }

    (phys_clone, virt_clone)
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
pub struct PageBox<T> {
    phys: usize,
    virt: usize,
    size: usize,
    raw: *mut T,
}

impl<T> PageBox<T> {
    pub unsafe fn from_raw_parts(address: usize, size: usize) -> Self {
        // again: use a test page to get page alignment out of the way
        let test_addr = VirtAddr::new(address as u64);
        let test_page = Page::<Size4KiB>::containing_address(test_addr);
        let phys = test_page.start_address().as_u64() as usize;

        let virt = (phys as u64 + get_phys_offset()) as usize;
        let aligned_size = crate::page_align(size as u64, virt as u64);

        Self {
            phys,
            virt,
            size: aligned_size,
            raw: virt as *mut T,
        }
    }

    pub fn new(size: usize) -> syscall::Result<Self> {
        let (phys, virt) = kphysalloc(size);
        Ok(Self {
            phys,
            virt,
            size: crate::page_align(size as u64, virt as u64),
            raw: virt as *mut T,
        })
    }

    pub fn new_at(physical: usize, size: usize) -> Self {
        let phys_test_addr = VirtAddr::new(physical as u64);
        let phys_test_page = Page::<Size4KiB>::containing_address(phys_test_addr);
        let mut phys = phys_test_page.start_address().as_u64();

        let virt_test_addr = VirtAddr::new(phys as u64 + unsafe { get_phys_offset() });
        let virt_test_page = Page::<Size4KiB>::containing_address(virt_test_addr);
        let mut virt = virt_test_page.start_address().as_u64();

        // as before
        let phys_clone = phys.clone() as usize;
        let virt_clone = virt.clone() as usize;

        for _ in 0..(crate::page_align(size.clone() as u64, virt) / virt_test_page.size() as usize)
        {
            map_page!(
                phys,
                virt,
                Size4KiB,
                PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
            );
            phys += virt_test_page.size();
            virt += virt_test_page.size();
        }

        Self {
            phys: phys_clone,
            virt: virt_clone,
            size: crate::page_align(size.clone() as u64, virt),
            raw: virt as *mut T,
        }
    }

    pub fn physical_address(&self) -> usize {
        self.phys
    }

    pub fn virtual_address(&self) -> usize {
        self.virt
    }

    pub fn size(&self) -> usize {
        self.size
    }

    pub unsafe fn as_mut_ptr(&self) -> *mut T {
        self.raw
    }
}

impl<T> Drop for PageBox<T> {
    fn drop(&mut self) {
        kphysfree(self.virt, self.size);
    }
}
