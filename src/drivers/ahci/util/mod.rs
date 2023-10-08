// SPDX-License-Identifier: GPL-3.0-or-later
// Code in this file was originally part of the Aero Project; see https://github.com/Andy-Python-Programmer/aero/raw/master/src/aero_kernel/src/utils/mod.rs for details
// Only including the parts of that file relevant to (working) AHCI implementation here

pub mod sync;

use core::cell::UnsafeCell;

/// Just like [`Cell`] but with [volatile] read / write operations
/// Differs from the Aero implementation by being in tuple struct form, which is much simpler to manage
///
/// [`Cell`]: https://doc.rust-lang.org/std/cell/struct.Cell.html
/// [volatile]: https://doc.rust-lang.org/std/ptr/fn.read_volatile.html
#[repr(transparent)]
pub struct VolatileCell<T>(UnsafeCell<T>);

impl<T: Copy> VolatileCell<T> {
    /// Returns a copy of the contained value.
    #[inline]
    pub fn get(&self) -> T {
        unsafe { core::ptr::read_volatile(self.0.get()) }
    }

    /// Sets the contained value.
    #[inline]
    pub fn set(&self, value: T) {
        unsafe { core::ptr::write_volatile(self.0.get(), value) }
    }

    /// Compatibility mode function for [`get`]
    #[inline]
    pub fn read_volatile(&self) -> T {
        self.get()
    }

    /// Compatibility mode function for [`set`]
    #[inline]
    pub fn write_volatile(&self, value: T) {
        self.set(value)
    }
}

// Key difference: if we want to use `VolatileCell` in statics, not implementing Send/Sync is a problem
unsafe impl<T> Send for VolatileCell<T> {}
unsafe impl<T> Sync for VolatileCell<T> {}

pub trait CeilDiv {
    fn ceil_div(self, d: Self) -> Self;
}

macro_rules! ceil_div_impl {
    ($($t:ty)*) => ($(
        impl CeilDiv for $t {
            fn ceil_div(self, d: $t) -> $t {
                (self + d - 1) / d
            }
        }
    )*)
}

ceil_div_impl!(u8 u16 u32 u64 usize u128);
