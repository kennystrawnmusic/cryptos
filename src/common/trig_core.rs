use core::intrinsics::{cosf32, cosf64, sinf32, sinf64};

/// Trait to re-implement trigonometric methods for 64-bit primitives in `#![no_std]` environments.

pub trait TrigCore64: Sized + Clone
where
    f64: From<Self>,
{
    fn cos(&self) -> f64 {
        unsafe { cosf64(f64::from(self.clone())) }
    }
    fn sin(&self) -> f64 {
        unsafe { sinf64(f64::from(self.clone())) }
    }
    fn tan(&self) -> f64 {
        self.sin() / self.cos()
    }
    fn csc(&self) -> f64 {
        1.0 / self.sin()
    }
    fn sec(&self) -> f64 {
        1.0 / self.cos()
    }
    fn cot(&self) -> f64 {
        self.cos() / self.sin()
    }
}

/// Trait to re-implement trigonometric methods for 32-bit primitives in `#![no_std]` environments.

pub trait TrigCore32: Sized + Clone
where
    f32: From<Self>,
{
    fn cos(&self) -> f32 {
        unsafe { cosf32(f32::from(self.clone())) }
    }
    fn sin(&self) -> f32 {
        unsafe { sinf32(f32::from(self.clone())) }
    }
    fn tan(&self) -> f32 {
        self.sin() / self.cos()
    }
    fn csc(&self) -> f32 {
        1.0 / self.sin()
    }
    fn sec(&self) -> f32 {
        1.0 / self.cos()
    }
    fn cot(&self) -> f32 {
        self.cos() / self.sin()
    }
}

impl TrigCore32 for f32 {}
impl TrigCore64 for f64 {}
