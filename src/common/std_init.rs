// TODO: https://wiki.osdev.org/Porting_Rust_standard_library

#![allow(clippy::legacy_numeric_constants)]

extern crate alloc as inner_alloc;

pub mod alloc {
    pub use alloc::alloc::Global;
    pub use core::alloc::*;
}

pub use core::any;
pub use core::arch;
pub use core::array;
pub use core::ascii;

// TODO: properly redefine this module
// pub mod backtrace {
//     pub use x86_64::structures::idt::InterruptStackFrame as BacktraceFrame;
// }

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

    // Compatibility: most standard library users stick with the default HashMap implementation
    // as opposed to customizing the default hash builder as is done in my kernel.
    // This is a convenience for them, since AHash is generally faster than 512-bit SHA-3 anyway.
    pub use hashbrown::hash_map;
    pub use hashbrown::hash_set;
    pub use hashbrown::HashMap;
    pub use hashbrown::HashSet;
}

pub use core::convert;
pub use core::default;
pub use core::f32;
pub use core::f64;

#[allow(ambiguous_glob_reexports)]
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
pub use core::result;
pub use inner_alloc::format;
pub use inner_alloc::rc;

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
    pub use super::super::LazyLock;
    pub use super::super::Mutex;
    pub use super::super::RwLock;
    pub use core::sync::*;
    pub use inner_alloc::sync::*;
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

// Need to redefine this macro because attempting to import it causes a name conflict
#[macro_export]
macro_rules! vec {
    () => (::alloc::vec![]);
    ($elem:expr; $n:expr) => {
        let mut v = ::alloc::vec::Vec::new();
        for i in 0..$n {
            v.push($elem);
        }
    };
    ($($x:expr,)*) => (::alloc::vec![$($x),*]);
    ($($x:expr),+ $(,)?) => (::alloc::vec![$($x),+]);
}

pub use core::u128;
pub use core::u16;
pub use core::u32;
pub use core::u64;
pub use core::u8;
pub use core::usize;

// Experimental, feature-gated re-exports
pub use core::assert_matches;
pub use core::async_iter;
pub use core::error;
pub use core::intrinsics;
pub use core::net;
pub use core::panicking;
pub use core::simd;
pub use core::unicode;

// Experimental, feature-gated macro re-exports
pub use core::cfg_match;
pub use core::concat_bytes;
pub use core::concat_idents;
pub use core::const_format_args;
pub use core::format_args_nl;
pub use core::log_syntax;
pub use core::trace_macros;

// Re-export the rest of the macros one-by-one
pub use core::{
    assert, assert_eq, assert_ne, cfg, column, compile_error, concat, debug_assert,
    debug_assert_eq, debug_assert_ne, env, file, format_args, include, include_bytes, include_str,
    line, module_path, option_env, stringify, todo, unimplemented, unreachable, write, writeln,
};
