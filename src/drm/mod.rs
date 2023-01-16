// SPDX-License-Identifier: GPL-3.0-or-later

pub mod avx_accel;

use alloc::{boxed::Box, vec::Vec};
use bootloader_api::info::{FrameBuffer, FrameBufferInfo, PixelFormat};
use core::{iter::zip, simd::{Simd, f32x4, u8x4}};
use embedded_graphics::{
    pixelcolor::{raw::RawU32, Bgr888, Gray8, Rgb888},
    prelude::{GrayColor, OriginDimensions, PixelColor, RgbColor, Size},
    Pixel,
};
use embedded_graphics_core::{draw_target::DrawTarget, geometry::Point, prelude::RawData};
use spin::RwLock;

use self::avx_accel::avx_init;

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
    type Raw = RawU32; // always 4 bytes = 32 bits on UEFI systems
}

/// Extracts color information from the framebuffer
pub fn buffer_color(buffer: &FrameBuffer) -> Box<dyn Iterator<Item = PixelColorKind> + '_> {
    let info = buffer.info().clone();
    match info.pixel_format {
        PixelFormat::Rgb => {
            let red = buffer
                .buffer()
                .iter()
                .step_by(info.bytes_per_pixel)
                .map(|r| r.clone());
            let green = buffer
                .buffer()
                .iter()
                .skip(1)
                .step_by(info.bytes_per_pixel)
                .map(|g| g.clone());
            let blue = buffer
                .buffer()
                .iter()
                .skip(2)
                .step_by(info.bytes_per_pixel)
                .map(|b| b.clone());
            Box::new(
                red.zip(green)
                    .zip(blue)
                    .map(move |((r, g), b)| PixelColorKind::new(info, r, g, b)),
            )
        }
        PixelFormat::Bgr => {
            let blue = buffer
                .buffer()
                .iter()
                .step_by(info.bytes_per_pixel)
                .map(|b| b.clone());
            let green = buffer
                .buffer()
                .iter()
                .skip(1)
                .step_by(info.bytes_per_pixel)
                .map(|g| g.clone());
            let red = buffer
                .buffer()
                .iter()
                .skip(2)
                .step_by(info.bytes_per_pixel)
                .map(|r| r.clone());
            Box::new(
                red.zip(green)
                    .zip(blue)
                    .map(move |((r, g), b)| PixelColorKind::new(info, r, g, b)),
            )
        }
        PixelFormat::U8 => {
            let gray = buffer
                .buffer()
                .iter()
                .step_by(info.bytes_per_pixel)
                .map(|g| g.clone());
            Box::new(gray.map(move |g| PixelColorKind::new(info, g, g, g)))
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
    /// Computes alpha values relative to those associated with another layer
    #[allow(unused_assignments)]
    #[target_feature(enable = "avx")]
    pub fn alpha_blend(&mut self, alpha: f32, other: CompositingLayer) {
        if alpha > 1.0 || alpha < 0.0 {
            panic!("Alpha value must be a value between 0 and 1");
        }

        match self.color {
            PixelColorKind::Rgb(own_rgb) => {
                if let PixelColorKind::Rgb(other_rgb) = other.color {
                    let new_red = ((alpha * (own_rgb.r() as f32))
                        + ((1.0 - alpha) * (other_rgb.r() as f32)))
                        as u8;
                    let new_green = ((alpha * (own_rgb.g() as f32))
                        + ((1.0 - alpha) * (other_rgb.g() as f32)))
                        as u8;
                    let new_blue = ((alpha * (own_rgb.b() as f32))
                        + ((1.0 - alpha) * (other_rgb.b() as f32)))
                        as u8;

                    for (this, other) in self
                        .fb
                        .chunks_exact_mut(self.info.bytes_per_pixel)
                        .zip(other.fb.chunks_exact(self.info.bytes_per_pixel))
                    {
                        // bytes per pixel is always 4 in UEFI
                        let mut this = Simd::<u8, 4>::from_slice(this);
                        let other = Simd::<u8, 4>::from_slice(other);
                        let alpha = Simd::<f32, 4>::from_array([alpha; 4]);

                        this = ((alpha * (this.clone().cast::<f32>()))
                            + ((Simd::<f32, 4>::from_array([1.0; 4]) - alpha) * (other.clone().cast::<f32>())))
                            .cast::<u8>();
                    }

                    self.color = PixelColorKind::new(self.info, new_red, new_green, new_blue);
                } else {
                    unreachable!()
                }
            }
            PixelColorKind::Bgr(own_bgr) => {
                if let PixelColorKind::Bgr(other_bgr) = other.color {
                    let new_blue = ((alpha * (own_bgr.b() as f32))
                        + ((1.0 - alpha) * (other_bgr.b() as f32)))
                        as u8;
                    let new_green = ((alpha * (own_bgr.g() as f32))
                        + ((1.0 - alpha) * (other_bgr.g() as f32)))
                        as u8;
                    let new_red = ((alpha * (own_bgr.r() as f32))
                        + ((1.0 - alpha) * (other_bgr.r() as f32)))
                        as u8;

                    for (this, other) in self
                        .fb
                        .chunks_exact_mut(self.info.bytes_per_pixel)
                        .zip(other.fb.chunks_exact(self.info.bytes_per_pixel))
                    {
                        // bytes per pixel is always 4 in UEFI
                        let mut this = Simd::<u8, 4>::from_slice(this);
                        let other = Simd::<u8, 4>::from_slice(other);
                        let alpha = Simd::<f32, 4>::from_array([alpha; 4]);

                        this = ((alpha * (this.clone().cast::<f32>()))
                            + ((Simd::<f32, 4>::from_array([1.0; 4]) - alpha) * (other.clone().cast::<f32>())))
                            .cast::<u8>();
                    }

                    self.color = PixelColorKind::new(self.info, new_red, new_green, new_blue);
                } else {
                    unreachable!()
                }
            }
            PixelColorKind::U8(_) => panic!("Grayscale alpha blending not supported"),
        }
    }
    /// Writes finished render to an existing root framebuffer after computations
    pub fn merge_down(&self, root_buffer: &mut FrameBuffer) {
        for (index, byte) in self.fb.iter().enumerate() {
            root_buffer.buffer_mut()[index] = byte.clone();
        };
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

unsafe impl Send for CompositingLayer {}
unsafe impl Sync for CompositingLayer {}