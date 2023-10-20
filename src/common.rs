use core::cell::UnsafeCell;
use core::ops::{Deref, DerefMut};
use core::sync::atomic::{AtomicUsize, Ordering};
use spin::{RwLock, RwLockWriteGuard};
use x86_64::VirtAddr;
use x86_64::structures::paging::{Mapper, Page, Size4KiB, FrameAllocator, PageTableFlags};

use crate::{FRAME_ALLOCATOR, map_page, get_phys_offset};

/// A SeqLock that is supposed to work on bare metal
/// TODO: figure out why this is deadlocking when I try to use it to lock the frame allocators
pub struct SeqLock<T> {
    lock: AtomicUsize,
    data: UnsafeCell<T>,
    semaphore: RwLock<()>,
}

pub struct SeqLockReadGuard<'a, T> {
    lock: &'a AtomicUsize,
    data: *const T,
}

impl<'a, T> Deref for SeqLockReadGuard<'a, T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        while self.lock.load(Ordering::Acquire) & 1 == 1 {
            core::hint::spin_loop();
        }
        unsafe { &*(self.data) }
    }
}

pub struct SeqLockWriteGuard<'a, T> {
    lock: &'a AtomicUsize,
    data: *mut T,
    _semaphore: RwLockWriteGuard<'a, ()>,
}

impl<'a, T> Deref for SeqLockWriteGuard<'a, T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        while self.lock.load(Ordering::Acquire) & 1 == 1 {
            core::hint::spin_loop();
        }
        unsafe { &*(self.data) }
    }
}

impl<'a, T> DerefMut for SeqLockWriteGuard<'a, T> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        while self.lock.load(Ordering::Acquire) & 1 == 1 {
            core::hint::spin_loop();
        }
        unsafe { &mut *(self.data) }
    }
}

unsafe impl<T: Send> Send for SeqLock<T> {}
unsafe impl<T: Send> Sync for SeqLock<T> {}

impl<T: Copy> SeqLock<T> {
    pub fn new(inner: T) -> Self {
        Self {
            lock: AtomicUsize::new(0),
            data: UnsafeCell::new(inner),
            semaphore: RwLock::new(()),
        }
    }

    pub fn read(&self) -> SeqLockReadGuard<T> {
        loop {
            let lock = self.lock.load(Ordering::Acquire);
            if lock & 1 == 1 {
                continue;
            }
            self.lock.store(lock + 1, Ordering::Release);
            break;
        }
        SeqLockReadGuard {
            lock: &self.lock,
            data: unsafe { &*self.data.get() },
        }
    }

    pub fn write(&self) -> SeqLockWriteGuard<T> {
        loop {
            let lock = self.lock.load(Ordering::Acquire);
            if lock & 1 == 1 {
                continue;
            }
            self.lock.store(lock + 1, Ordering::Release);
            break;
        }
        SeqLockWriteGuard {
            lock: &self.lock,
            data: unsafe { &mut *self.data.get() },
            _semaphore: self.semaphore.write(),
        }
    }

    pub fn try_read(&self) -> Option<SeqLockReadGuard<T>> {
        let lock = self.lock.load(Ordering::Acquire);
        if lock & 1 == 1 {
            return None;
        }
        self.lock.store(lock + 1, Ordering::Release);
        Some(SeqLockReadGuard {
            lock: &self.lock,
            data: unsafe { &*self.data.get() },
        })
    }

    pub fn try_write(&self) -> Option<SeqLockWriteGuard<T>> {
        let lock = self.lock.load(Ordering::Acquire);
        if lock & 1 == 1 {
            return None;
        }
        self.lock.store(lock + 1, Ordering::Release);
        Some(SeqLockWriteGuard {
            lock: &self.lock,
            data: unsafe { &mut *self.data.get() },
            _semaphore: self.semaphore.write(),
        })
    }

    pub fn is_locked(&self) -> bool {
        self.lock.load(Ordering::Acquire) & 1 == 1
    }

    pub fn unlock(&self) {
        self.lock.fetch_add(1, Ordering::Release);
    }

    pub fn force_unlock(&self) {
        self.lock.store(0, Ordering::Release);
    }

    pub fn into_inner(self) -> T {
        self.data.into_inner()
    }
}

/// Helper function for creating raw pointers safely
pub fn addralloc<T>() -> *mut T {
    let frame = FRAME_ALLOCATOR
        .get()
        .expect("Frame allocator not initialized")
        .write()
        .allocate_frame()
        .expect("Failed to allocate frame for command ring");

    let page = Page::<Size4KiB>::containing_address(VirtAddr::new(
        frame.start_address().as_u64() + get_phys_offset(),
    ));

    map_page!(
        frame.start_address().as_u64(),
        page.start_address().as_u64(),
        Size4KiB,
        PageTableFlags::PRESENT
            | PageTableFlags::WRITABLE
            | PageTableFlags::NO_CACHE
            | PageTableFlags::WRITE_THROUGH
    );

    if core::mem::size_of::<T>() as u64 > Page::<Size4KiB>::SIZE {
        let total_size = core::mem::size_of::<T>() as u64;
        let mut i = Page::<Size4KiB>::SIZE;

        while i < total_size {
            let frame = FRAME_ALLOCATOR
                .get()
                .expect("Frame allocator not initialized")
                .write()
                .allocate_frame()
                .expect("Failed to allocate frame for command ring");

            let page = Page::<Size4KiB>::containing_address(VirtAddr::new(
                frame.start_address().as_u64() + get_phys_offset(),
            ));

            map_page!(
                frame.start_address().as_u64(),
                page.start_address().as_u64(),
                Size4KiB,
                PageTableFlags::PRESENT
                    | PageTableFlags::WRITABLE
                    | PageTableFlags::NO_CACHE
                    | PageTableFlags::WRITE_THROUGH
            );

            i += Page::<Size4KiB>::SIZE;
        }
    }

    page.start_address().as_u64() as *mut T
}