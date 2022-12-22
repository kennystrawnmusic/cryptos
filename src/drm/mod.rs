// SPDX-License-Identifier: GPL-3.0-or-later

use alloc::vec::Vec;
use bootloader_api::info::{FrameBuffer, FrameBufferInfo, PixelFormat};
use core::iter::zip;
use embedded_graphics::{
    pixelcolor::{raw::RawU8, Bgr888, Gray8, Rgb888},
    prelude::{GrayColor, PixelColor, RgbColor, OriginDimensions, Size}, Pixel,
};
use embedded_graphics_core::{geometry::Point, prelude::RawData, draw_target::DrawTarget};
use spin::RwLock;

use crate::FRAMEBUFFER_ADDR;

#[allow(dead_code)] // needed for later
pub static COMPOSITING_TABLE: RwLock<Vec<CompositingLayer>> = RwLock::new(Vec::new());

pub fn buffer_points(buffer: &'static mut FrameBuffer) -> impl Iterator<Item = Point> {
    (0..buffer.info().width)
        .flat_map(move |x| (0..buffer.info().height).map(move |y| Point::new(x as i32, y as i32)))
}

#[derive(Debug, PartialEq, Eq)]
pub enum PixelColorKind {
    Rgb(Rgb888),
    Bgr(Bgr888),
    U8(Gray8),
}

impl PixelColorKind {
    pub fn new(info: FrameBufferInfo, red: u8, green: u8, blue: u8) -> Self {
        let luma = ((red.clone() as u32 * green.clone() as u32 * blue.clone() as u32) / 3) as u8;
        match info.pixel_format {
            PixelFormat::Rgb => Self::Rgb(Rgb888::new(red.clone(), green.clone(), blue.clone())),
            PixelFormat::Bgr => Self::Bgr(Bgr888::new(red.clone(), green.clone(), blue.clone())),
            PixelFormat::U8 => Self::U8(Gray8::new(luma)),
            _ => panic!("Unknown pixel format"),
        }
    }
}

impl Clone for PixelColorKind {
    fn clone(&self) -> Self {
        match self {
            Self::Bgr(bgr) => Self::Bgr(Bgr888::new(bgr.r(), bgr.g(), bgr.b())),
            Self::Rgb(rgb) => Self::Rgb(Rgb888::new(rgb.r(), rgb.g(), rgb.b())),
            Self::U8(g) => Self::U8(Gray8::new(g.luma())),
        }
    }
}

impl Copy for PixelColorKind {}

impl PixelColor for PixelColorKind {
    type Raw = RawU8; // framebuffer is based on a byte slice
}

pub fn buffer_pixels(buffer: &'static mut FrameBuffer, red: u8, green: u8, blue: u8) -> impl Iterator<Item = Pixel<PixelColorKind>> {
    let info = buffer.info().clone();
    buffer_points(buffer).map(move |p| Pixel(p, PixelColorKind::new(info, red, green, blue)))
}

// Idea is to eventually implement DrawTarget for this
#[allow(dead_code)]
#[derive(Clone)]
pub struct CompositingLayer {
    color: PixelColorKind,
    fb: Vec<u8>,
    info: FrameBufferInfo,
    x: usize,
    y: usize,
}

impl CompositingLayer {
    pub fn new(buffer: &'static mut FrameBuffer, red: u8, green: u8, blue: u8, x: usize, y: usize) -> Self {
        let info = buffer.info().clone();

        Self {
            color: PixelColorKind::new(info, red, green, blue),
            fb: buffer
                .buffer_mut()
                .iter()
                .map(|i| i.clone())
                .collect::<Vec<_>>(),
            info,
            x,
            y,
        }
    }
    /// Writes finished render to an existing root framebuffer after computations
    pub fn merge_down(&self, root_buffer: &mut FrameBuffer) {
        for (index, byte) in self.fb.iter().enumerate() {
            root_buffer.buffer_mut()[index] = byte.clone();
        }
    }
    /// Adds the given `CompositingLayer` to the compositing table
    pub fn register(self) {
        COMPOSITING_TABLE.write().push(self);
    }
}

impl OriginDimensions for CompositingLayer {
    fn size(&self) -> embedded_graphics::prelude::Size {
        let horiz = self.info.width as u32;
        let vert = self.info.height as u32;
        Size::new(horiz, vert)
    }
}

impl DrawTarget for CompositingLayer {
    type Color = PixelColorKind;
    type Error = !; //direct framebuffer writes never fail

    fn draw_iter<I>(&mut self, _pixels: I) -> Result<(), Self::Error>
        where
            I: IntoIterator<Item = embedded_graphics::Pixel<Self::Color>> {
        todo!();
    }
}