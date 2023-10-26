extern crate alloc as inner_alloc;

pub mod alloc {
    pub use core::alloc::*;
    pub use alloc::alloc::Global;
}

pub use core::any;
pub use core::arch;
pub use core::array;
pub use core::ascii;

pub mod backtrace {
    pub use x86_64::structures::idt::InterruptStackFrame as BacktraceFrame;
}

pub mod borrow {
    extern crate alloc as inner_alloc;
    pub use core::borrow::*;
    pub use inner_alloc::borrow::{Cow, ToOwned};
}

pub use inner_alloc::boxed;

pub use core::cell::*;
pub use core::char;
pub use core::clone;
pub use core::cmp;

pub mod collections {
    extern crate alloc as inner_alloc;
    pub use inner_alloc::collections::*;
    pub use super::super::hash_map::HashMap;
}

pub use core::convert;
pub use core::default;
pub use core::f32;
pub use core::f64;

pub mod ffi {
    extern crate alloc as inner_alloc;
    pub use core::ffi::*;
    pub use inner_alloc::ffi::*;
}

pub mod fmt {
    extern crate alloc as inner_alloc;
    pub use core::fmt::*;
    pub use inner_alloc::fmt::{Debug, Display, Formatter, Result};
}

pub use core::future;
pub use inner_alloc::format;
pub use core::hash;
pub use core::hint;
pub use core::i128;
pub use core::i16;
pub use core::i32;
pub use core::i64;
pub use core::i8;
pub use core::isize;
pub use core::iter;
pub use core::marker;
pub use core::mem;
pub use core::num;
pub use core::ops;
pub use core::option;
pub use core::panic;
pub use core::pin;
pub use core::prelude;
pub use core::primitive;
pub use core::ptr;
pub use inner_alloc::rc;
pub use core::result;

pub mod slice {
    extern crate alloc as inner_alloc;
    pub use core::slice::*;
    pub use inner_alloc::slice::*;
}

pub mod str {
    extern crate alloc as inner_alloc;
    pub use core::str::*;
    pub use inner_alloc::str::*;
}

pub use inner_alloc::string;

pub mod sync {
    extern crate alloc as inner_alloc;
    pub use core::sync::*;
    pub use inner_alloc::sync::*;
    pub use super::super::IrqLock as RwLock;
    pub use super::super::IrqMutex as Mutex;
}

pub mod task {
    extern crate alloc as inner_alloc;
    pub use core::task::*;
    pub use inner_alloc::task::*;
}

pub use core::time;

pub mod vec {
    extern crate alloc as inner_alloc;
    pub use inner_alloc::vec::*;
}

#[macro_export]
macro_rules! vec {
    [ $($item:expr),* ] => {
        ::alloc::vec![$($item),*]
    }
}

pub use core::u128;
pub use core::u16;
pub use core::u32;
pub use core::u64;
pub use core::u8;
pub use core::usize;