use bootloader_api::info::FrameBufferInfo;
use bootloader_x86_64_common::framebuffer::FrameBufferWriter;
use core::cell::UnsafeCell;
use core::fmt::Write;
use core::num::NonZeroUsize;
use core::ops::{Deref, DerefMut};
use core::sync::atomic::{AtomicUsize, Ordering};
use spin::RelaxStrategy;
use x86_64::instructions::{hlt, interrupts::without_interrupts};
use x86_64::structures::paging::{FrameAllocator, Page, PageTableFlags, PhysFrame, Size4KiB};
use x86_64::VirtAddr;

pub mod atomic_cell;
pub mod hash_map;
pub mod large_numbers;
pub mod macros;
pub mod random;
pub mod std_init;
pub mod sync;
pub mod trig_core;
pub mod volatile_cell;

use crate::{get_phys_offset, map_page, unmap_page, FRAME_ALLOCATOR, PRINTK};

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
    _semaphore: IrqLockWriteGuard<'a, ()>,
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

/// Wrapper for allocating frames
pub fn allocate_frame() -> PhysFrame<Size4KiB> {
    FRAME_ALLOCATOR
        .write()
        .allocate_frame()
        .expect("Out of memory")
}

/// Helper function for creating raw pointers safely
pub fn addralloc<T>() -> *mut T {
    let frame = allocate_frame();

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
            let frame = allocate_frame();

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

/// Relax strategy that disables interrupts and halts the CPU
pub struct IrqRelaxStrategy;

// Needed to tell the compiler this is safe to send
unsafe impl Send for IrqRelaxStrategy {}
unsafe impl Sync for IrqRelaxStrategy {}

impl RelaxStrategy for IrqRelaxStrategy {
    fn relax() {
        without_interrupts(hlt);
    }
}

/// RwLock that works by disabling interrupts and halting the CPU while held
pub type RwLock<T> = spin::rwlock::RwLock<T, IrqRelaxStrategy>;

/// RwLockWriteGuard that works by disabling interrupts and halting the CPU while held
pub type IrqLockWriteGuard<'a, T> = spin::rwlock::RwLockWriteGuard<'a, T, IrqRelaxStrategy>;

/// Mutex that works by disabling interrupts and halting the CPU while held
pub type Mutex<T> = spin::mutex::Mutex<T, IrqRelaxStrategy>;

/// LazyLock that works by disabling interrupts and halting the CPU while held
pub type LazyLock<T, F = fn() -> T> = spin::lazy::Lazy<T, F, IrqRelaxStrategy>;

/// Re-implementation of `bootloader-x86_64-common::logger::LockedLogger` that uses `IrqLock`
/// instead of `spinning_top::Spinlock` for improved performance
pub struct Printk(RwLock<FrameBufferWriter>);

impl Printk {
    pub fn new(buffer: &'static mut [u8], info: FrameBufferInfo) -> Self {
        Self(RwLock::new(FrameBufferWriter::new(buffer, info)))
    }

    /// Force-unlocks the logger
    /// # Safety
    /// This function is unsafe for the same reason why force-unlocking any other lock is unsafe
    pub unsafe fn force_unlock(&self) {
        unsafe {
            self.0.force_write_unlock();
        }
    }

    pub fn is_locked(&self) -> bool {
        self.0.try_write().is_none()
    }
}

impl log::Log for Printk {
    fn enabled(&self, metadata: &log::Metadata) -> bool {
        metadata.level() <= log::max_level()
    }

    fn flush(&self) {}

    fn log(&self, record: &log::Record) {
        while self.is_locked() {
            core::hint::spin_loop();
        }

        if self.enabled(record.metadata()) {
            let mut fb = self.0.write();
            writeln!(fb, "{}", record.args()).unwrap();
        }
    }
}

impl Write for Printk {
    fn write_str(&mut self, s: &str) -> core::fmt::Result {
        self.0.write().write_str(s)
    }
}

// Dummy type for getting around the issue of KernelFrameAlloc not implementing Clone
#[derive(Clone, Debug)]
pub struct XhciMapper;

impl xhci::accessor::Mapper for XhciMapper {
    unsafe fn map(&mut self, phys_start: usize, bytes: usize) -> NonZeroUsize {
        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(phys_start as u64));
        let virt_start = test.start_address().as_u64() + get_phys_offset();

        map_page!(
            phys_start,
            virt_start,
            Size4KiB,
            PageTableFlags::PRESENT
                | PageTableFlags::WRITABLE
                | PageTableFlags::NO_CACHE
                | PageTableFlags::WRITE_THROUGH
        );

        if bytes > Page::<Size4KiB>::SIZE as usize {
            let mut i = Page::<Size4KiB>::SIZE as usize;

            while i < bytes {
                let phys = phys_start + i;
                let test = Page::<Size4KiB>::containing_address(VirtAddr::new(phys as u64));

                let virt = test.start_address().as_u64() + get_phys_offset();

                map_page!(
                    phys,
                    virt,
                    Size4KiB,
                    PageTableFlags::PRESENT
                        | PageTableFlags::WRITABLE
                        | PageTableFlags::NO_CACHE
                        | PageTableFlags::WRITE_THROUGH
                );

                i += Page::<Size4KiB>::SIZE as usize;
            }
        }

        NonZeroUsize::new(virt_start as usize).unwrap()
    }

    fn unmap(&mut self, virt_start: usize, bytes: usize) {
        if bytes > 4096 {
            let mut i = 4096;

            while i < bytes {
                let virt = (virt_start + i) as u64;
                let p = Page::<Size4KiB>::containing_address(VirtAddr::new(virt));

                unmap_page!(p);

                i += 4096;
            }
        } else {
            let p = Page::<Size4KiB>::containing_address(VirtAddr::new(virt_start as u64));

            unmap_page!(p);
        }
    }
}

// Needed to allow access from statics
unsafe impl Send for XhciMapper {}
unsafe impl Sync for XhciMapper {}

pub fn detect_deadlock() -> Option<!> {
    if PRINTK.get().unwrap().is_locked() {
        panic!("Deadlock detected");
    } else {
        None
    }
}
