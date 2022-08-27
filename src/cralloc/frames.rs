use core::ops::DerefMut;

use super::uefi_map::UefiMemoryRegion;
use uefi::table::boot::MemoryDescriptor;
#[allow(unused_imports)] //future-proof
use x86_64::{
    registers::control::{Cr3, Cr3Flags},
    structures::paging::{
        FrameAllocator, Mapper, OffsetPageTable, Page, PageTable, PhysFrame, Size4KiB,
    },
    PhysAddr, VirtAddr,
};

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
#[repr(C)]
pub enum MemoryRegionKind {
    Usable,
    // as a UEFI stub, we *are* the bootloader now ― so no need to add that as a variant
    Unknown(u32),
    // don't need two unknowns because no plan to support BIOS here
}

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
#[repr(C)]
pub struct MemoryRegion {
    pub begin: u64,
    pub end: u64,
    pub kind: MemoryRegionKind,
}

impl MemoryRegion {
    pub const fn empty() -> Self {
        MemoryRegion {
            begin: 0,
            end: 0,
            kind: MemoryRegionKind::Usable,
        }
    }
}

#[derive(Debug)]
#[repr(C)]
pub struct MemoryRegions {
    pub ptr: *mut MemoryRegion,
    pub len: usize,
}

impl MemoryRegions {
    pub fn from_uefi(regions: &'static mut [MemoryDescriptor]) -> Self {
        let mut converted_iter = regions.iter().map(|uefi_region| MemoryRegion {
            begin: uefi_region.start().as_u64(),
            end: uefi_region.start().as_u64() + uefi_region.len(),
            kind: uefi_region.kind(),
        });

        let first_addr = &mut converted_iter.nth(0).unwrap() as *mut _ as usize as u64;
        Self {
            ptr: first_addr as *mut MemoryRegion,
            len: converted_iter.len(),
        }
    }

    pub fn as_static_mut(&'static mut self) -> &'static mut Self {
        self
    }

    pub fn as_static_slice(&'static mut self) -> &'static mut [MemoryRegion] {
        self.deref_mut()
    }
}

impl core::ops::Deref for MemoryRegions {
    type Target = [MemoryRegion];

    fn deref(&self) -> &Self::Target {
        unsafe { core::slice::from_raw_parts(self.ptr, self.len) }
    }
}

impl core::ops::DerefMut for MemoryRegions {
    fn deref_mut(&mut self) -> &mut Self::Target {
        unsafe { core::slice::from_raw_parts_mut(self.ptr, self.len) }
    }
}

impl From<&'static mut [MemoryRegion]> for MemoryRegions {
    fn from(slice: &'static mut [MemoryRegion]) -> Self {
        MemoryRegions {
            ptr: slice.as_mut_ptr(),
            len: slice.len(),
        }
    }
}

impl From<MemoryRegions> for &'static mut [MemoryRegion] {
    fn from(map: MemoryRegions) -> Self {
        unsafe { core::slice::from_raw_parts_mut(map.ptr, map.len) }
    }
}

impl From<MemoryDescriptor> for MemoryRegion {
    fn from(uefi_region: MemoryDescriptor) -> Self {
        MemoryRegion {
            begin: uefi_region.start().as_u64(),
            end: uefi_region.start().as_u64() + uefi_region.len(),
            kind: uefi_region.kind(),
        }
    }
}

#[derive(Debug)]
pub struct StubTables {
    pub stub_kernel: OffsetPageTable<'static>,
    pub pml4: PhysFrame,
}

// impl StubTables {
//     fn clone(&mut self) -> Self {
//         let stub_kernel = unsafe {
//             let cloned_offset = self.stub_kernel.phys_offset().clone();
//             OffsetPageTable::new(
//                 &mut self.stub_kernel.level_4_table().clone(),
//                 cloned_offset,
//             )
//         };
//         let pml4 = unsafe {
//             PhysFrame::<Size4KiB>::from_start_address(self.pml4.start_address()).unwrap()
//         };
//         Self { stub_kernel, pml4 }
//     }
// }

pub fn build_from_uefi(fa: &mut impl FrameAllocator<Size4KiB>) -> StubTables {
    // UEFI identity-maps everything
    let offset = VirtAddr::new(0);

    let (stub_kernel, pml4) = {
        let (old, old_flags) = {
            let f = Cr3::read().0;
            let flags = Cr3::read().1;
            let ptptr = (offset + f.start_address().as_u64()).as_ptr::<PageTable>();
            (unsafe { &*ptptr }, flags)
        };

        // overwrite old address
        let nf = PhysFrame::<Size4KiB>::containing_address(old.start_address());

        // back up Cr3 flags
        let new_flags = old_flags.clone();

        let new = {
            let ptr = (offset + nf.start_address().as_u64()).as_mut_ptr::<PageTable>();

            unsafe {
                ptr.write(PageTable::new());
                &mut *ptr
            }
        };

        new[0] = old[0].clone();

        unsafe {
            Cr3::write(nf, new_flags);
            (OffsetPageTable::new(&mut *new, offset), nf)
        }
    };

    StubTables { stub_kernel, pml4 }
}

unsafe fn active_pml4(offset: VirtAddr) -> &'static mut PageTable {
    let (pml4_frame, _) = Cr3::read();

    let phys = pml4_frame.start_address();
    let virt = offset + phys.as_u64();
    let ptpt: *mut PageTable = virt.as_mut_ptr();

    &mut *ptpt // Safety: returns mutable reference to raw pointer
}

pub unsafe fn map_memory(offset: VirtAddr) -> OffsetPageTable<'static> {
    let pml4 = active_pml4(offset);
    OffsetPageTable::new(pml4, offset)
}

pub struct Falloc {
    map: &'static mut [MemoryRegion],
    next: usize,
}

impl Falloc {
    pub unsafe fn new(map: &'static mut [MemoryRegion]) -> Self {
        Self { map, next: 0 }
    }

    pub fn usable(&self) -> impl Iterator<Item = PhysFrame> + '_ {
        let all = self.map.iter();
        let usable = all.filter(|r| r.kind == MemoryRegionKind::Usable);

        let ranges = usable.map(|r| r.begin..r.end);
        let faddrs = ranges.flat_map(|r| r.step_by(4096));
        faddrs.map(|a| PhysFrame::containing_address(PhysAddr::new(a)))
    }
}

unsafe impl FrameAllocator<Size4KiB> for Falloc {
    fn allocate_frame(&mut self) -> Option<PhysFrame<Size4KiB>> {
        let f = self.usable().nth(self.next);
        self.next += 1;
        f
    }
}

/// Macro for ensuring pages are properly mapped
///
/// Converts the Result thrown by map_to() to an Option in order to handle the MapToError cases properly
#[macro_export]
macro_rules! map_page {
    ($phys:expr, $virt:expr, $size:ty, $flags:expr) => {
        // macros expect everything to be imported each time they're used in a new file, so best to hardcode paths
        let frame = x86_64::structures::paging::PhysFrame::<$size>::containing_address(x86_64::PhysAddr::new($phys as u64));
        let page = x86_64::structures::paging::Page::<$size>::containing_address(x86_64::VirtAddr::new($virt as u64));

        // suppress warnings if this macro is called from an unsafe fn
        #[allow(unused_unsafe)]
        let res = unsafe {
            crate::STUB_TABLES.get().unwrap().lock().stub_kernel.map_to(
                page,
                frame,
                $flags,
                &mut *crate::FRAME_ALLOCATOR.get().unwrap().lock(),
            )
        };

        let flush = match res{
            Ok(flush) => Some(flush),
            Err(e) => match e {
                x86_64::structures::paging::mapper::MapToError::FrameAllocationFailed => panic!("Out of memory"),
                x86_64::structures::paging::mapper::MapToError::PageAlreadyMapped(_) => {
                    log::debug!("Already have a page here; skipping mapping");
                    None
                }
                x86_64::structures::paging::mapper::MapToError::ParentEntryHugePage => {
                    log::debug!("Already have a huge page here; skipping mapping");
                    None
                }
            },
        };

        if let Some(flush) = flush {
            flush.flush();
        }
    };
}

unsafe impl Send for Falloc {}
unsafe impl Sync for Falloc {}
