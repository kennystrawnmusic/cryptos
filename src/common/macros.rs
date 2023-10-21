use x86_64::{
    structures::paging::{Page, PageTableFlags, Size4KiB},
    VirtAddr,
};

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

/// One-to-one replacement for Redox's `int_like!` macro
#[macro_export]
macro_rules! int_like {
    ($new:ident, $backing:ident) => {
        pub struct $new($backing);

        impl $new {
            #[allow(dead_code)]
            #[inline(always)]
            pub const fn new(val: $backing) -> Self {
                $new(val)
            }

            #[allow(dead_code)]
            #[inline(always)]
            pub const fn get(&self) -> $backing {
                self.0
            }
        }

        impl ::core::convert::From<$backing> for $new {
            #[inline(always)]
            fn from(val: $backing) -> Self {
                Self::new(val)
            }
        }

        impl ::core::convert::From<$new> for $backing {
            #[inline(always)]
            fn from(val: $new) -> Self {
                val.get()
            }
        }
    };

    ($new:ident, $new_atomic:ident, $backing:ident, $backing_atomic:ident) => {
        int_like!($new, $backing);

        pub struct $new_atomic($backing_atomic);

        impl $new_atomic {
            #[allow(dead_code)]
            #[inline(always)]
            pub const fn new(x: $new) -> Self {
                $new_atomic($backing_atomic::new(x.get()))
            }

            #[allow(dead_code)]
            #[inline(always)]
            pub fn load(&self, order: ::core::sync::atomic::Ordering) -> $new {
                $new::new(self.0.load(order))
            }

            #[allow(dead_code)]
            #[inline(always)]
            pub fn store(&self, val: $new, order: ::core::sync::atomic::Ordering) {
                self.0.store(val.get(), order)
            }

            #[allow(dead_code)]
            #[inline(always)]
            pub fn swap(&self, val: $new, order: ::core::sync::atomic::Ordering) -> $new {
                $new::from(self.0.swap(val.get(), order))
            }

            #[allow(dead_code)]
            #[inline(always)]
            pub fn compare_exchange(
                &self,
                current: $new,
                new: $new,
                success: ::core::sync::atomic::Ordering,
                failure: ::core::sync::atomic::Ordering,
            ) -> ::core::result::Result<$new, $new> {
                match self
                    .0
                    .compare_exchange(current.get(), new.get(), success, failure)
                {
                    Ok(x) => Ok($new::from(x)),
                    Err(x) => Err($new::from(x)),
                }
            }

            #[allow(dead_code)]
            #[inline(always)]
            pub fn compare_exchange_weak(
                &self,
                current: $new,
                new: $new,
                success: ::core::sync::atomic::Ordering,
                failure: ::core::sync::atomic::Ordering,
            ) -> ::core::result::Result<$new, $new> {
                match self
                    .0
                    .compare_exchange_weak(current.get(), new.get(), success, failure)
                {
                    Ok(x) => Ok($new::from(x)),
                    Err(x) => Err($new::from(x)),
                }
            }
        }
        impl ::core::default::Default for $new_atomic {
            #[inline(always)]
            fn default() -> Self {
                Self::new($new::new(0))
            }
        }
    };
}

/// Kernel-mode version of the standard library's `println!` macro
/// TODO: figure out how to get around the borrow checker here (perhaps using const new method?)
#[macro_export]
macro_rules! printk {
    () => ({
        use core::fmt::Write;
        let mut writer = $crate::PRINTK.get().unwrap();
        writer.write_str("\n").unwrap();
    });
    ($($arg:tt)*) => ({
        use core::fmt::Write;
        let mut writer = $crate::PRINTK.get().unwrap();
        writer.write_fmt(format_args!($($arg)*)).unwrap();
    });
}
