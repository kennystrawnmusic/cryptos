use syscall::{Error, PhysallocFlags, Result, EINVAL, ENOMEM};
use x86_64::{
    structures::{
        idt::InterruptStackFrame,
        paging::{PhysFrame, Size4KiB},
    },
    PhysAddr,
};

use crate::FRAME_ALLOCATOR;

// I/O Privilege Level
pub fn iopl(level: usize, frame: &mut InterruptStackFrame) -> Result<usize> {
    if level <= 3 {
        unsafe {
            let mut clone = frame.clone();
            clone.cpu_flags = (frame.cpu_flags & !(3 << 12)) | (((level & 3) << 12) as u64);
            frame.as_mut().write(clone);
        }

        Ok(0)
    } else {
        Err(Error::new(EINVAL))
    }
}

// Physical memory allocation (necessary for usermode drivers to access device address space)
fn physalloc_inner(size: usize, flags: PhysallocFlags) -> Result<usize> {
    if flags.contains(PhysallocFlags::SPACE_32 | PhysallocFlags::SPACE_64) {
        if let Some((_, size)) = FRAME_ALLOCATOR
            .get()
            .unwrap()
            .write()
            .allocate_multiple(size)
        {
            Ok(size)
        } else {
            Err(Error::new(ENOMEM))
        }
    } else {
        Err(Error::new(EINVAL))
    }
}

pub fn physalloc(size: usize) -> Result<usize> {
    // TODO: make sure only root can do this
    physalloc_inner(size, PhysallocFlags::SPACE_64)
}

pub fn physfree_inner(addr: usize, count: usize) -> Result<usize> {
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
    physfree_inner(addr, count)
}
