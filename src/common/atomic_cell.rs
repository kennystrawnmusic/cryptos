use alloc::boxed::Box;
use core::{
    ptr::addr_of,
    sync::atomic::{AtomicPtr, Ordering},
};
use x86_64::{
    structures::paging::{Page, PageTableFlags, Size4KiB},
    VirtAddr,
};

use crate::{map_page, unmap_page};

/// RAII guard of an atomic pointer
pub struct AtomicCell<T>(AtomicPtr<T>);

impl<T> AtomicCell<T> {
    pub fn new(data: T) -> Self {
        let addr_of_data = addr_of!(data) as u64;
        let mut virt = Page::<Size4KiB>::containing_address(VirtAddr::new(addr_of_data))
            .start_address()
            .as_u64();

        map_page!(
            addr_of_data,
            virt,
            Size4KiB,
            PageTableFlags::PRESENT
                | PageTableFlags::WRITABLE
                | PageTableFlags::NO_CACHE
                | PageTableFlags::WRITE_THROUGH
        );

        Self(AtomicPtr::new(&mut virt as *mut _ as *mut T))
    }

    pub fn get_mut(&mut self) -> &mut T {
        unsafe { &mut *self.0.load(Ordering::SeqCst) }
    }

    /// Compatibility-mode alias for \`get\`
    pub fn read(&mut self) -> &T {
        self.get()
    }

    /// Compatibility-mode alias for \`get_mut\`
    pub fn write(&mut self) -> &mut T {
        self.get_mut()
    }

    pub fn get(&self) -> &T {
        unsafe { &*self.0.load(Ordering::SeqCst) }
    }

    pub fn set(&self, data: T) {
        unsafe { *self.0.load(Ordering::SeqCst) = data };
    }

    pub fn swap(&self, data: T) -> *mut T {
        self.0.swap(Box::into_raw(Box::new(data)), Ordering::SeqCst)
    }

    pub fn compare_exchange(&self, current: T, new: T) -> Result<*mut T, *mut T> {
        let current = Box::into_raw(Box::new(current));
        let new = Box::into_raw(Box::new(new));
        match self
            .0
            .compare_exchange(current, new, Ordering::SeqCst, Ordering::SeqCst)
        {
            Ok(_) => Ok(current),
            Err(_) => Err(new),
        }
    }

    pub fn compare_exchange_weak(&self, current: T, new: T) -> Result<*mut T, *mut T> {
        let current = Box::into_raw(Box::new(current));
        let new = Box::into_raw(Box::new(new));
        match self
            .0
            .compare_exchange_weak(current, new, Ordering::SeqCst, Ordering::SeqCst)
        {
            Ok(_) => Ok(current),
            Err(_) => Err(new),
        }
    }
}

impl<T> Drop for AtomicCell<T> {
    fn drop(&mut self) {
        unmap_page!(Page::<Size4KiB>::containing_address(VirtAddr::new(
            &mut self.0 as *mut _ as u64
        )));
    }
}
