// SPDX-License-Identifier: GPL-3.0-or-later

use alloc::vec::Vec;
use bootloader_api::info::{FrameBuffer, FrameBufferInfo, PixelFormat};
use core::iter::zip;
use embedded_graphics::{
    pixelcolor::{raw::RawU8, Bgr888, Gray8, Rgb888},
    prelude::{GrayColor, OriginDimensions, PixelColor, RgbColor, Size},
    Pixel,
};
use embedded_graphics_core::{draw_target::DrawTarget, geometry::Point, prelude::RawData};
use spin::RwLock;

use crate::FRAMEBUFFER_ADDR;

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
    type Raw = RawU8; // FIXME: figure out how to auto-detect this
}

pub fn buffer_pixels(
    buffer: &'static mut FrameBuffer,
    red: u8,
    green: u8,
    blue: u8,
) -> impl Iterator<Item = Pixel<PixelColorKind>> {
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
}

impl CompositingLayer {
    pub fn new(buffer: &'static mut FrameBuffer, red: u8, green: u8, blue: u8) -> Self {
        let info = buffer.info().clone();

        Self {
            color: PixelColorKind::new(info, red, green, blue),
            fb: buffer
                .buffer_mut()
                .iter()
                .map(|i| i.clone())
                .collect::<Vec<_>>(),
            info,
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

    fn draw_iter<I>(&mut self, pixels: I) -> Result<(), Self::Error>
    where
        I: IntoIterator<Item = embedded_graphics::Pixel<Self::Color>>,
    {
        let pixels = pixels.into_iter().collect::<Vec<_>>();
        let colors = pixels.iter().map(|p| p.1.clone()).collect::<Vec<_>>();

        for (index, point) in pixels.iter().map(|p| p.0).enumerate() {
            let pixel_offset = point.y as usize * self.info.stride + point.x as usize;

            let color = match colors[index] {
                PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
            };

            let pixel_bytes = self.info.bytes_per_pixel;
            let byte_offset = pixel_offset * pixel_bytes;

            self.fb[byte_offset..(byte_offset + pixel_bytes)]
                .copy_from_slice(&color[..pixel_bytes]);
        }
        Ok(())
    }
}
