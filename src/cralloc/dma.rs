use super::kphysalloc::{kphysalloc, kphysmap, PageBox};
use core::mem::MaybeUninit;

pub struct Dma<T> {
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

    pub fn physical_address(&self) -> usize {
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
