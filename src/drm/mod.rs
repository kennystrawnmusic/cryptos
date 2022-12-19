// SPDX-License-Identifier: GPL-3.0-or-later

use alloc::vec::Vec;
use bootloader_api::info::{FrameBuffer, FrameBufferInfo, PixelFormat};
use embedded_graphics::{prelude::PixelColor, pixelcolor::{Rgb888, Bgr888, Gray8}};
use core::iter::zip;
use embedded_graphics_core::geometry::Point;
use spin::RwLock;

use crate::FRAMEBUFFER_ADDR;

#[allow(dead_code)] // needed for later
pub static COMPOSITING_TABLE: RwLock<Vec<CompositingLayer>> = RwLock::new(Vec::new());

// Needed to allow rendering in multiple separate buffers — the very definition of compositing
pub fn clone_buffer(old: FrameBuffer) -> FrameBuffer {
    unsafe { FrameBuffer::new(FRAMEBUFFER_ADDR, old.info()) }
}

pub fn buffer_points(buffer: FrameBuffer) -> impl Iterator<Item = Point> {
    (0..buffer.info().width)
        .flat_map(move |x| (0..buffer.info().height).map(move |y| Point::new(x as i32, y as i32)))
}

// future-proof
#[allow(unused_variables)]
#[allow(unused_mut)]
pub fn render_points(points: impl Iterator<Item = Point>, mut buffer: FrameBuffer) {
    todo!()
}

pub enum PixelColorKind {
    Rgb(Rgb888),
    Bgr(Bgr888),
    U8(Gray8),
}

impl PixelColorKind {
    pub fn new(info: FrameBufferInfo, red: u8, green: u8, blue: u8) -> Self {
        let luma = ((red.clone() as u32 * green.clone() as u32 * blue.clone() as u32)/3) as u8;
        match info.pixel_format {
            PixelFormat::Rgb => Self::Rgb(Rgb888::new(red.clone(), green.clone(), blue.clone())),
            PixelFormat::Bgr => Self::Bgr(Bgr888::new(red.clone(), green.clone(), blue.clone())),
            PixelFormat::U8 => Self::U8(Gray8::new(luma)),
            _ => panic!("Unknown pixel format")
        }
    }
}

// Idea is to eventually implement DrawTarget for this
#[allow(dead_code)]
pub struct CompositingLayer {
    color: PixelColorKind,
    fb: &'static mut [u8],
    info: FrameBufferInfo,
    x: usize,
    y: usize,
}

impl CompositingLayer {
    pub fn new(mut buffer: FrameBuffer, red: u8, green: u8, blue: u8, x: usize, y: usize) -> Self {
        let info = buffer.info().clone();
        Self { 
            color: PixelColorKind::new(info, red, green, blue),
            // borrow checker throws a fit if I don't do this
            fb: buffer.buffer_mut().iter().map(|i| i.clone()).collect::<Vec<_>>().leak(),
            info,
            x,
            y
        }
    }
    /// Writes finished render to an existing root framebuffer after computations
    // future-proof
    #[allow(unused_variables)]
    #[allow(unused_mut)]
    pub fn merge_down(&self, mut root_buffer: FrameBuffer) {
        todo!()
    }
}