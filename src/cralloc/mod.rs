use core::{
    alloc::{Allocator, GlobalAlloc, Layout},
    ptr::{addr_of, NonNull},
};

use alloc::alloc::Global;
use conquer_once::spin::Lazy;
use spin::RwLock;
use x86_64::{
    structures::paging::{OffsetPageTable, PageSize, PhysFrame},
    PhysAddr,
};

use crate::get_boot_info;

use self::frames::{map_memory, KernelFrameAlloc};

pub mod frames;

use {
    slab_allocator_rs::*,
    x86_64::{
        structures::paging::{FrameAllocator, Mapper, Page, PageTableFlags, Size4KiB},
        VirtAddr,
    },
};

// Needed to allow page/frame allocation outside of the entry point, by things like the ACPI handler
pub static MAPPER: Lazy<RwLock<OffsetPageTable>> = Lazy::new(|| {
    let map = unsafe { map_memory() };
    RwLock::new(map)
});

pub static FRAME_ALLOCATOR: Lazy<RwLock<KernelFrameAlloc>> = Lazy::new(|| {
    let boot_info = get_boot_info();

    let falloc = unsafe { KernelFrameAlloc::new(&boot_info.memory_regions) };
    RwLock::new(falloc)
});

#[global_allocator]
pub static ALLOC: LazyHeap = LazyHeap::new(|| {
    let heap = LockedHeap::empty();

    let range = {
        let begin = VirtAddr::new(BEGIN_HEAP as u64);
        let end = begin + HEAP_LEN - 1u64;
        let first_page = Page::containing_address(begin);
        let last_page = Page::containing_address(end);
        Page::<Size4KiB>::range_inclusive(first_page, last_page)
    };

    for p in range {
        let f = FRAME_ALLOCATOR
            .write()
            .allocate_frame()
            .expect("Out of memory");

        let flags = PageTableFlags::PRESENT
            | PageTableFlags::WRITABLE
            | PageTableFlags::NO_CACHE
            | PageTableFlags::WRITE_THROUGH;

        unsafe {
            if let Ok(flush) = MAPPER
                .write()
                .map_to(p, f, flags, &mut *(FRAME_ALLOCATOR.write()))
            {
                flush.flush();
            }
        };
    }

    unsafe {
        heap.init(BEGIN_HEAP, HEAP_LEN);
    }

    heap
});

pub const BEGIN_HEAP: usize = 0x2000_0000_0000;
pub const HEAP_LEN: usize = 32 * 1024 * 1024;

/// Structure that provides page/frame-aligned physical memory access
///
/// Proprietary drivers, which can *only* be usermode drivers if the GPL is to be honored, are going to need this.
///
/// Also exactly the point of making this a hybrid kernel in the roadmap: hybrid kernels can properly segregate proprietary drivers
/// while monolithic kernels like Linux can't.
pub struct PhysBox<T>(NonNull<T>);

impl<T> PhysBox<T> {
    /// Creates a new `PhysBox<T>` by creating a test page of size `S` at the address of `T`
    /// and aligning it to `T`'s start address
    ///
    /// Example (untested!!!):
    /// ```
    /// use x86_64::structures::paging::Size4KiB;
    ///
    /// fn foo() {
    ///     let x = 42u64;
    ///     let pb = PhysBox::new_inner::<Size4KiB>(x);
    ///     // do whatever you want with `pb` at this point
    /// }
    /// ```
    /// Help wanted for those who can come up with a better example than this
    pub fn new_inner<S: PageSize>(inner: T) -> Self {
        let inner_addr = addr_of!(inner) as usize as u64;
        let test = PhysFrame::<S>::containing_address(PhysAddr::new(inner_addr));

        let size = test.size() as usize;
        let align = test.start_address().as_u64() as usize;

        let layout = Layout::from_size_align(size, align)
            .unwrap_or_else(|e| panic!("Failed to create memory layout: {:#?}", e));
        let new_inner = Global
            .allocate_zeroed(layout)
            .unwrap_or_else(|e| panic!("Error allocating memory: {:#?}", e));

        Self(NonNull::<T>::new(unsafe { *(new_inner.as_ptr() as *mut _) }).unwrap())
    }
    /// 4KiB is by far the most common physical frame size.
    ///
    /// This, therefore, is shorthand for `PhysBox::new_inner::<Size4KiB>` for both ease of use
    /// and compatibility with redox_syscall which uses a similar structure defined by the Redox kernel
    pub fn new(inner: T) -> Self {
        Self::new_inner::<Size4KiB>(inner)
    }
}

/// Wrapper around `slab_allocator_rs::LockedHeap` that can be initialized lazily
pub struct LazyHeap(Lazy<LockedHeap>);

impl LazyHeap {
    pub const fn new(init: fn() -> LockedHeap) -> Self {
        Self(Lazy::new(init))
    }

    pub fn init(&self, begin: usize, len: usize) {
        unsafe {
            self.0.init(begin, len);
        }
    }
}

unsafe impl GlobalAlloc for LazyHeap {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        self.0.alloc(layout)
    }

    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        self.0.dealloc(ptr, layout)
    }
}
