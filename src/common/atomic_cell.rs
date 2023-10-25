use alloc::boxed::Box;
use core::sync::atomic::{AtomicPtr, Ordering};

/// Thread-safe mutable cell based on atomics
pub struct AtomicCell<T>(AtomicPtr<T>);

impl<T> AtomicCell<T> {
    pub fn new(mut data: T) -> Self {
        Self(AtomicPtr::new(&mut data as *mut T))
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

    pub fn into_inner(self) -> *mut T {
        self.0.into_inner()
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
