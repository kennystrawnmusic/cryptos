// SPDX-License-Identifier: GPL-3.0-or-later

use alloc::{boxed::Box, vec::Vec};
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

/// Converts a raw framebuffer byte stream into an iterator of `Point` objects
pub fn buffer_points(buffer: &mut FrameBuffer) -> impl Iterator<Item = Point> {
    let info = buffer.info().clone();
    (0..info.width).flat_map(move |x| (0..info.height).map(move |y| Point::new(x as i32, y as i32)))
}

/// Enum for easy conversion of the framebuffer's `PixelFormat` structure to equivalent `PixelColor` implementors in the `embedded-graphics` crate
///
/// Implements `PixelColor` itself for easy drawing
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

/// Extracts color information from the framebuffer
pub fn buffer_color(buffer: &FrameBuffer) -> Box<dyn Iterator<Item = PixelColorKind> + '_> {
    let info = buffer.info().clone();
    match info.pixel_format {
        PixelFormat::Rgb => {
            let red = buffer.buffer().iter().step_by(info.bytes_per_pixel);
            let green = buffer.buffer().iter().skip(1).step_by(info.bytes_per_pixel);
            let blue = buffer.buffer().iter().skip(2).step_by(info.bytes_per_pixel);
            Box::new(
                red.zip(green).zip(blue).map(move |((r, g), b)| {
                    PixelColorKind::new(info, r.clone(), g.clone(), b.clone())
                }),
            )
        }
        PixelFormat::Bgr => {
            let blue = buffer.buffer().iter().step_by(info.bytes_per_pixel);
            let green = buffer.buffer().iter().skip(1).step_by(info.bytes_per_pixel);
            let red = buffer.buffer().iter().skip(2).step_by(info.bytes_per_pixel);
            Box::new(
                red.zip(green).zip(blue).map(move |((r, g), b)| {
                    PixelColorKind::new(info, r.clone(), g.clone(), b.clone())
                }),
            )
        }
        PixelFormat::U8 => {
            let gray = buffer.buffer().iter().step_by(info.bytes_per_pixel);
            Box::new(gray.map(move |g| PixelColorKind::new(info, g.clone(), g.clone(), g.clone())))
        }
        _ => panic!("Unknown pixel format"),
    }
}

/// Converts a raw framebuffer byte stream into an iterator over pixels
pub fn buffer_pixels(buffer: &mut FrameBuffer) -> impl Iterator<Item = Pixel<PixelColorKind>> + '_ {
    buffer_points(buffer)
        .zip(buffer_color(buffer))
        .map(|(point, color)| Pixel(point, color))
}

/// Data structure for the `embedded-graphics` crate to draw to
///
/// Includes a `.merge_down()` method to allow for easy writes to the main framebuffer after computation
#[allow(dead_code)]
#[derive(Clone)]
pub struct CompositingLayer {
    color: PixelColorKind,
    fb: Vec<u8>,
    info: FrameBufferInfo,
}

impl CompositingLayer {
    /// Creates a new `CompositingLayer` using a provided `FrameBuffer` and color values
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
