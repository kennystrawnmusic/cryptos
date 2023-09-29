use syscall::{Error, MapFlags, PhysallocFlags, PhysmapFlags, Result, EINVAL, ENOMEM};
use x86_64::{
    structures::{
        idt::InterruptStackFrame,
        paging::{
            frame::PhysFrameRangeInclusive, Mapper, Page, PageTableFlags, PhysFrame, Size4KiB,
        },
    },
    PhysAddr, VirtAddr,
};

use crate::{map_page, FRAME_ALLOCATOR};

// Compatibility
pub(crate) fn translate_flags(physmap: PhysmapFlags, map: MapFlags) -> PageTableFlags {
    let mut new_flags = PageTableFlags::empty();

    // TODO: find a better way than this mess
    match map {
        MapFlags::PROT_NONE => {}
        MapFlags::PROT_READ => new_flags.set(PageTableFlags::PRESENT, true),
        MapFlags::PROT_WRITE => {
            new_flags.set(PageTableFlags::PRESENT, true);
            new_flags.set(PageTableFlags::WRITABLE, true);
        }
        MapFlags::PROT_EXEC => new_flags.set(PageTableFlags::NO_EXECUTE, false),
        MapFlags::MAP_FIXED => new_flags.set(PageTableFlags::GLOBAL, true),
        MapFlags::MAP_FIXED_NOREPLACE => new_flags.set(PageTableFlags::GLOBAL, true),
        MapFlags::MAP_LAZY => new_flags.set(PageTableFlags::WRITE_THROUGH, true),
        MapFlags::MAP_PRIVATE => new_flags.set(PageTableFlags::USER_ACCESSIBLE, false),
        MapFlags::MAP_SHARED => new_flags.set(PageTableFlags::USER_ACCESSIBLE, true),
        _ => unreachable!(),
    }

    match physmap {
        PhysmapFlags::PHYSMAP_WRITE => {
            new_flags.set(PageTableFlags::PRESENT, true);
            new_flags.set(PageTableFlags::WRITABLE, true);
        }
        PhysmapFlags::PHYSMAP_WRITE_COMBINE => {
            new_flags.set(PageTableFlags::PRESENT, true);
            new_flags.set(PageTableFlags::WRITABLE, true);
        }
        PhysmapFlags::PHYSMAP_NO_CACHE => {
            new_flags.set(PageTableFlags::PRESENT, true);
            new_flags.set(PageTableFlags::NO_CACHE, true);
        }
        _ => unreachable!(),
    }

    new_flags
}

// I/O Privilege Level
pub fn iopl(level: usize, frame: &mut InterruptStackFrame) -> Result<usize> {
    if level <= 3 {
        unsafe {
            let mut clone = **frame;
            clone.cpu_flags = (frame.cpu_flags & !(3 << 12)) | (((level & 3) << 12) as u64);
            frame.as_mut().write(clone);
        }

        Ok(0)
    } else {
        Err(Error::new(EINVAL))
    }
}

// Physical memory allocation (necessary for usermode drivers to access device address space)
fn physalloc_inner(
    size: usize,
    flags: PhysallocFlags,
) -> Result<(usize, PhysFrameRangeInclusive<Size4KiB>)> {
    if flags.contains(PhysallocFlags::SPACE_32 | PhysallocFlags::SPACE_64)
        || flags.contains(PhysallocFlags::SPACE_32)
        || flags.contains(PhysallocFlags::SPACE_64)
    {
        if let Some((frame_range, size)) = FRAME_ALLOCATOR
            .get()
            .unwrap()
            .write()
            .allocate_multiple(size)
        {
            Ok((size, frame_range))
        } else {
            Err(Error::new(ENOMEM))
        }
    } else {
        Err(Error::new(EINVAL))
    }
}

pub fn physalloc(size: usize) -> Result<usize> {
    // TODO: make sure only root can do this

    match physalloc_inner(size, PhysallocFlags::SPACE_64) {
        Ok((size, _)) => Ok(size),
        Err(e) => Err(e),
    }
}

fn physfree_inner(addr: usize, count: usize) -> Result<usize> {
    let range = PhysFrame::<Size4KiB>::range_inclusive(
        PhysFrame::containing_address(PhysAddr::new(addr as u64)),
        PhysFrame::containing_address(PhysAddr::new(count as u64)),
    );

    FRAME_ALLOCATOR
        .get()
        .unwrap()
        .write()
        .deallocate_multiple(range);
    Ok(0)
}

pub fn physfree(addr: usize, count: usize) -> Result<usize> {
    // TODO: make sure only root can do this
    physfree_inner(addr, count)
}

fn physmap_inner(len: usize, flags: PhysmapFlags) -> Result<usize> {
    let mut map_flags = MapFlags::MAP_SHARED | MapFlags::PROT_READ;
    map_flags.set(
        MapFlags::PROT_WRITE,
        flags.contains(PhysmapFlags::PHYSMAP_WRITE),
    );

    let pt_flags = translate_flags(flags, map_flags);
    let (_, frame_range) = physalloc_inner(len, PhysallocFlags::SPACE_64)?;

    for f in frame_range {
        let p = Page::<Size4KiB>::containing_address(VirtAddr::new(f.start_address().as_u64()));

        // Identity-map for now; will fix this later
        map_page!(
            p.start_address().as_u64(),
            f.start_address().as_u64(),
            Size4KiB,
            pt_flags
        );
    }

    Ok(len)
}

pub fn physmap(_phys: usize, len: usize, flags: PhysmapFlags) -> Result<usize> {
    // TODO: ensure that only root can do this
    physmap_inner(len, flags)
}
