use super::kphysalloc::{kphysalloc, kphysmap, PageBox};
use core::{
    mem::MaybeUninit,
    ops::{Deref, DerefMut},
};

pub struct Dma<T: ?Sized> {
    phys: usize,
    size: usize,
    virt: *mut T,
}

impl<T> Dma<T> {
    pub fn from_pagebox_uninit(pb: PageBox<T>) -> syscall::Result<Dma<MaybeUninit<T>>> {
        let phys = pb.physical_address();
        let virt = kphysmap(phys, pb.size()) as *mut MaybeUninit<T>;
        Ok(Dma {
            phys: pb.physical_address(),
            size: core::mem::size_of_val::<MaybeUninit<T>>(unsafe { &*virt }),
            virt,
        })
    }

    pub fn from_pagebox_zeroed(pb: PageBox<T>) -> syscall::Result<Dma<MaybeUninit<T>>> {
        let box_size = &pb.size();
        let ns = Self::from_pagebox_uninit(pb)?;

        unsafe { core::ptr::write_bytes(ns.virt as *mut MaybeUninit<u8>, 0, box_size.clone()) }

        Ok(ns)
    }

    pub fn from_pagebox(pb: PageBox<T>, value: T) -> syscall::Result<Self> {
        let ns = Self::from_pagebox_uninit(pb)?;
        Ok(unsafe {
            core::ptr::write(ns.virt, MaybeUninit::new(value));
            ns.assume_init()
        })
    }

    pub fn new(value: T) -> syscall::Result<Self> {
        let pb = PageBox::new(core::mem::size_of::<T>())?;
        Self::from_pagebox(pb, value)
    }

    pub fn zeroed() -> syscall::Result<Dma<MaybeUninit<T>>> {
        let pb = PageBox::new(core::mem::size_of::<T>())?;
        Self::from_pagebox_zeroed(pb)
    }

    pub fn physical(&self) -> usize {
        self.phys
    }

    pub fn size(&self) -> usize {
        self.size
    }
}

impl<T> Dma<MaybeUninit<T>> {
    pub unsafe fn assume_init(self) -> Dma<T> {
        let &Dma { phys, size, virt } = &self;
        core::mem::forget(self);

        Dma {
            phys,
            size,
            virt: virt as *mut T,
        }
    }
}

impl<T> Dma<[T]> {
    pub fn from_pagebox_uninit_unsized(
        pb: PageBox<T>,
        len: usize,
    ) -> syscall::Result<Dma<[MaybeUninit<T>]>> {
        let max = pb.size() / core::mem::size_of::<T>();

        // hate assertions because they always give the wrong information
        if len > max {
            panic!("Slice index out of bounds")
        }

        let phys = pb.physical_address();
        let size = core::mem::size_of::<T>();

        Ok(Dma {
            phys,
            size,
            virt: unsafe {
                core::slice::from_raw_parts_mut(kphysmap(phys, size) as *mut MaybeUninit<T>, len)
            } as *mut [MaybeUninit<T>],
        })
    }

    pub fn from_pagebox_zeroed_unsized(
        pb: PageBox<T>,
        len: usize,
    ) -> syscall::Result<Dma<[MaybeUninit<T>]>> {
        let ns = Self::from_pagebox_uninit_unsized(pb, len)?;
        unsafe { core::ptr::write_bytes(ns.virt as *mut MaybeUninit<u8>, 0, ns.size) }
        Ok(ns)
    }

    pub unsafe fn zeroed_unsized(byte_count: usize) -> syscall::Result<Self> {
        let pb = PageBox::new(core::mem::size_of::<T>() * byte_count)?;
        Ok(Self::from_pagebox_zeroed_unsized(pb, byte_count)?.assume_init())
    }
}

impl<T> Dma<[MaybeUninit<T>]> {
    pub unsafe fn assume_init(self) -> Dma<[T]> {
        let &Dma { phys, size, virt } = &self;
        core::mem::forget(self);

        Dma {
            phys,
            size,
            virt: virt as *mut [T],
        }
    }
}

impl<T: ?Sized> Deref for Dma<T> {
    type Target = T;
    fn deref(&self) -> &T {
        unsafe { &*self.virt }
    }
}

impl<T: ?Sized> DerefMut for Dma<T> {
    fn deref_mut(&mut self) -> &mut T {
        unsafe { &mut *self.virt }
    }
}

impl<T: ?Sized> Drop for Dma<T> {
    fn drop(&mut self) {
        unsafe { core::ptr::drop_in_place(self.virt) };
        super::kphysalloc::kphysfree(self.virt as *mut u8 as usize, self.size);
    }
}
