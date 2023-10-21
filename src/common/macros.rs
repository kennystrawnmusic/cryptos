use x86_64::{VirtAddr, structures::paging::{Size4KiB, Page, PageTableFlags}};

/// Macro for ensuring pages are properly mapped
///
/// Converts the Result thrown by map_to() to an Option in order to handle the MapToError cases properly
#[macro_export]
macro_rules! map_page {
    ($phys:expr, $virt:expr, $size:ty, $flags:expr) => {
        // macros expect everything to be imported each time they're used in a new file, so best to hardcode paths
        let frame = x86_64::structures::paging::PhysFrame::containing_address(x86_64::PhysAddr::new($phys as u64));
        let page = x86_64::structures::paging::Page::<$size>::containing_address(x86_64::VirtAddr::new($virt as u64));

        x86_64::instructions::interrupts::without_interrupts(|| {
            // suppress warnings if this macro is called from an unsafe fn
            #[allow(unused_unsafe)]
            let res = unsafe {
                // in case this macro is called from a file that doesn't import this
                use x86_64::structures::paging::Mapper as MacroMapper;

                $crate::MAPPER.get().unwrap().write().map_to(
                    page,
                    frame,
                    $flags,
                    &mut *$crate::FRAME_ALLOCATOR.get().unwrap().write(),
                )
            };

            let flush = match res{
               Ok(flush) => Some(flush),
                Err(e) => match e {
                    x86_64::structures::paging::mapper::MapToError::FrameAllocationFailed => panic!("Out of memory"),
                    x86_64::structures::paging::mapper::MapToError::PageAlreadyMapped(_) => {
                        // Skip mapping as page already exists
                        None
                    }
                    x86_64::structures::paging::mapper::MapToError::ParentEntryHugePage => {
                        // Skip mapping as page already exists
                        None
                    }
                },
            };

            if let Some(flush) = flush {
                flush.flush();
            }
        });
    };
}

/// Macro for unmapping pages
///
/// Just like `map_page!`, this macro converts the `Result` thrown by `Mapper::unmap`
/// to an `Option<MapperFlush<S>>` so the errors can just be skipped before the page table
/// is flushed
#[macro_export]
macro_rules! unmap_page {
    ($page:expr) => {
        use log::debug;
        use x86_64::structures::paging::{mapper::UnmapError, Mapper};

        let flush = match $crate::MAPPER.get().unwrap().write().unmap($page) {
            Ok((_, flush)) => Some(flush),
            Err(e) => match e {
                UnmapError::ParentEntryHugePage => {
                    // Skip unmap as large page already exists here
                    None
                }
                UnmapError::PageNotMapped => {
                    // Skip unmap as page never existed to begin with
                    None
                }
                UnmapError::InvalidFrameAddress(err) => {
                    panic!(
                        "The address you attempted to unmap from doesn't exist: {:?}",
                        err
                    )
                }
            },
        };

        if let Some(flush) = flush {
            flush.flush();
        }
    };
}