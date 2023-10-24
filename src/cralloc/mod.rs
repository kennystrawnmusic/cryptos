use core::{
    alloc::{Allocator, Layout},
    ptr::{addr_of, NonNull},
    sync::atomic::{AtomicU64, Ordering},
};

use alloc::alloc::Global;
use x86_64::{
    structures::paging::{OffsetPageTable, PageSize, PhysFrame},
    PhysAddr,
};

use crate::{common::IrqLock, get_boot_info, get_phys_offset, FRAME_ALLOCATOR, MAPPER};

use self::frames::{map_memory, KernelFrameAlloc};

pub mod frames;

use {
    slab_allocator_rs::*,
    x86_64::{
        structures::paging::{
            mapper::MapToError, FrameAllocator, Mapper, Page, PageTableFlags, Size4KiB,
        },
        VirtAddr,
    },
};

#[global_allocator]
pub static ALLOC: LockedHeap = LockedHeap::empty();

pub const BEGIN_HEAP: usize = 0x2000_0000_0000;
pub const HEAP_LEN: usize = 32 * 1024 * 1024;

pub static MAP_ADDR: AtomicU64 = AtomicU64::new(0);
pub static FRAME_ALLOC_ADDR: AtomicU64 = AtomicU64::new(0);

pub fn get_mapper<'a>() -> &'a mut OffsetPageTable<'static> {
    unsafe { &mut *(MAP_ADDR.load(Ordering::SeqCst) as *mut OffsetPageTable) }
}

pub fn get_falloc<'a>() -> &'a mut KernelFrameAlloc {
    unsafe { &mut *(FRAME_ALLOC_ADDR.load(Ordering::SeqCst) as *mut KernelFrameAlloc) }
}

pub fn heap_init_inner(
    mapper: &mut impl Mapper<Size4KiB>,
    falloc: &mut impl FrameAllocator<Size4KiB>,
) -> Result<(), MapToError<Size4KiB>> {
    let range = {
        let begin = VirtAddr::new(BEGIN_HEAP as u64);
        let end = begin + HEAP_LEN - 1u64;
        let first_page = Page::containing_address(begin);
        let last_page = Page::containing_address(end);
        Page::range_inclusive(first_page, last_page)
    };

    for p in range {
        let f = falloc
            .allocate_frame()
            .ok_or(MapToError::FrameAllocationFailed)?;

        let flags = PageTableFlags::PRESENT
            | PageTableFlags::WRITABLE
            | PageTableFlags::NO_CACHE
            | PageTableFlags::WRITE_THROUGH;

        unsafe { mapper.map_to(p, f, flags, falloc)?.flush() };
    }

    unsafe {
        ALLOC.init(BEGIN_HEAP, HEAP_LEN);
    }

    Ok(())
}

pub fn heap_init() {
    let boot_info = get_boot_info();

    let offset = VirtAddr::new(get_phys_offset());

    let map = unsafe { map_memory(offset) };
    let falloc = unsafe { KernelFrameAlloc::new(&boot_info.memory_regions) };

    MAPPER.get_or_init(move || IrqLock::new(map));
    FRAME_ALLOCATOR.get_or_init(move || IrqLock::new(falloc));

    heap_init_inner(
        &mut *MAPPER.get().unwrap().write(),
        &mut *FRAME_ALLOCATOR.get().unwrap().write(),
    )
    .unwrap_or_else(|e| panic!("Failed to initialize heap: {:#?}", e));
}

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
