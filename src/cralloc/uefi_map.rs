use crate::get_phys_offset;

use super::frames::{MemoryRegion, MemoryRegionKind, MemoryRegions, StubTables};
use core::alloc::Layout;
use core::mem::MaybeUninit;
use uefi::table::boot::{MemoryDescriptor, MemoryType};
use x86_64::{
    structures::paging::{FrameAllocator, Mapper, Page, PageTableFlags, PhysFrame, Size4KiB},
    PhysAddr, VirtAddr,
};

pub const PAGE_SIZE: u64 = 4096;

pub trait UefiMemoryRegion: Copy + core::fmt::Debug {
    fn start(&self) -> PhysAddr;
    fn len(&self) -> u64;
    fn kind(&self) -> MemoryRegionKind;
}

pub struct UefiMap<T, R> {
    pub orig: T,
    pub map: T,
    pub desc: Option<R>,
    pub next: PhysFrame,
}

impl<T, R> UefiMap<T, R>
where
    T: ExactSizeIterator<Item = R> + Clone,
    T::Item: UefiMemoryRegion,
{
    pub fn new_at(f: PhysFrame, map: T) -> Self {
        Self {
            orig: map.clone(),
            map,
            desc: None,
            next: f,
        }
    }

    pub fn as_slice(&mut self) -> &'static mut [T::Item] {
        let first_addr = &mut self.orig.nth(0) as *mut _ as usize as u64;
        unsafe { core::slice::from_raw_parts_mut(first_addr as *mut T::Item, self.orig.len()) }
    }

    pub fn new(map: T) -> Self {
        // Start at the memory offset constant
        let first_frame =
            PhysFrame::containing_address(PhysAddr::new(unsafe { get_phys_offset() }));
        Self::new_at(first_frame, map)
    }

    fn alloc_from_region(&mut self, region: R) -> Option<PhysFrame> {
        let begin = region.start();
        let first_frame = PhysFrame::containing_address(begin);
        let end = begin + region.len();
        let last_frame = PhysFrame::containing_address(end - 1u64);

        // begin next at start
        if self.next < first_frame {
            self.next = first_frame;
        }

        if self.next < last_frame {
            let r = self.next;
            self.next += 1;
            Some(r)
        } else {
            None
        }
    }

    pub fn len(&self) -> usize {
        self.orig.len()
    }

    pub fn max(&self) -> PhysAddr {
        self.orig
            .clone()
            .map(|r| r.start() + r.len())
            .max()
            .unwrap()
    }

    fn new_region(
        r: MemoryRegion,
        slice: &mut [MaybeUninit<MemoryRegion>],
        next: &mut usize,
    ) -> Result<(), ()> {
        unsafe { slice.get_mut(*next).ok_or(())?.as_mut_ptr().write(r) };
        *next += 1;
        Ok(())
    }

    pub fn build_map(self, slice: &mut [MaybeUninit<MemoryRegion>]) -> &mut [MemoryRegion] {
        let mut next = 0;

        for region in self.orig {
            let mut begin = region.start();
            let end = begin + region.len();
            let next_available = self.next.start_address();
            let kind = match region.kind() {
                MemoryRegionKind::Usable => {
                    if end <= next_available {
                        MemoryRegionKind::Kernel
                    } else if region.start() >= next_available {
                        MemoryRegionKind::Usable
                    } else {
                        let used = MemoryRegion {
                            begin: region.start().as_u64(),
                            end: next_available.as_u64(),
                            kind: MemoryRegionKind::Kernel,
                        };
                        Self::new_region(used, slice, &mut next)
                            .expect("Failed to add memory region");
                        begin = next_available;
                        MemoryRegionKind::Usable
                    }
                }
                MemoryRegionKind::Unknown(other) => match MemoryType(other) {
                    MemoryType::LOADER_CODE
                    | MemoryType::LOADER_DATA
                    | MemoryType::BOOT_SERVICES_CODE
                    | MemoryType::BOOT_SERVICES_DATA
                    | MemoryType::RUNTIME_SERVICES_CODE
                    | MemoryType::RUNTIME_SERVICES_DATA => MemoryRegionKind::Usable,
                    other => MemoryRegionKind::Unknown(other.0),
                },
                other => other,
            };
            let built_region = MemoryRegion {
                begin: begin.as_u64(),
                end: end.as_u64(),
                kind,
            };
            Self::new_region(built_region, slice, &mut next).unwrap();
        }
        let init = &mut slice[..next];
        unsafe { MaybeUninit::slice_assume_init_mut(init) }
    }
}

unsafe impl<T, R> FrameAllocator<Size4KiB> for UefiMap<T, R>
where
    T: ExactSizeIterator<Item = R> + Clone,
    T::Item: UefiMemoryRegion,
{
    fn allocate_frame(&mut self) -> Option<PhysFrame<Size4KiB>> {
        if let Some(curr) = self.desc {
            match self.alloc_from_region(curr) {
                Some(f) => return Some(f),
                None => {
                    self.desc = None;
                }
            }
        }

        while let Some(d) = self.map.next() {
            if d.kind() != MemoryRegionKind::Usable || MemoryRegionKind::Kernel {
                continue;
            }
            if let Some(f) = self.alloc_from_region(d) {
                self.desc = Some(d);
                return Some(f);
            }
        }
        None
    }
}

impl<'a> UefiMemoryRegion for MemoryDescriptor {
    fn start(&self) -> PhysAddr {
        PhysAddr::new(self.phys_start)
    }

    fn len(&self) -> u64 {
        self.page_count * PAGE_SIZE
    }

    fn kind(&self) -> MemoryRegionKind {
        match self.ty {
            MemoryType::CONVENTIONAL => MemoryRegionKind::Usable,
            other => MemoryRegionKind::Unknown(other.0),
        }
    }
}

pub fn create_region_slice<T>(
    mut uefi_map: UefiMap<T, MemoryDescriptor>,
    page_tables: &mut StubTables,
) -> &'static mut [MemoryRegion]
where
    T: ExactSizeIterator<Item = MemoryDescriptor> + Clone,
{
    let region_count = uefi_map.len() - 1;
    let memory_regions_layout = Layout::array::<MemoryRegion>(region_count).unwrap();

    let first_free = uefi_map
        .map
        .find(|desc| desc.ty == MemoryType::CONVENTIONAL)
        .unwrap();

    let region_slice_start_addr = VirtAddr::new(first_free.start().as_u64());
    let region_slice_end_addr = region_slice_start_addr + memory_regions_layout.size();

    let first_page = Page::<Size4KiB>::containing_address(region_slice_start_addr);
    let last_page = Page::<Size4KiB>::containing_address(region_slice_end_addr);

    for p in Page::range_inclusive(first_page, last_page) {
        let flags = PageTableFlags::PRESENT | PageTableFlags::WRITABLE;
        let frame = uefi_map
            .allocate_frame()
            .expect("Failed to allocate memory for memory info struct");
        match unsafe {
            page_tables
                .stub_kernel
                .map_to(p, frame, flags, &mut uefi_map)
        } {
            Ok(tlb) => tlb.flush(),
            Err(e) => panic!("Error attempting to flush page tables: {:#?}", e),
        }
    }

    let regions: &'static mut [MaybeUninit<MemoryRegion>] = unsafe {
        core::slice::from_raw_parts_mut(region_slice_start_addr.as_mut_ptr(), region_count)
    };
    let stub_regions = uefi_map.build_map(regions);

    stub_regions
}
