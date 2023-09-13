// SPDX-License-Identifier: GPL-3.0-or-later

pub mod avx_accel;
pub mod cryptk;

use alloc::{boxed::Box, vec::Vec};
use bootloader_api::info::{FrameBuffer, FrameBufferInfo, PixelFormat};
use core::{
    iter::zip,
    simd::{f32x4, u8x4, Simd, SimdFloat, SimdUint},
};
use embedded_graphics::{
    pixelcolor::{raw::RawU32, Bgr888, Gray8, Rgb888},
    prelude::{GrayColor, OriginDimensions, PixelColor, RgbColor, Size},
    Pixel,
};
use embedded_graphics_core::{draw_target::DrawTarget, geometry::Point, prelude::RawData};
use spin::RwLock;

use self::avx_accel::{enable_avx, with_avx};

/// Vector of compositing layers for the rendering loop to merge down as it iterates
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
    pixels: Vec<Pixel<PixelColorKind>>,
    info: FrameBufferInfo,
}

impl CompositingLayer {
    /// Creates a new `CompositingLayer` using a provided `FrameBuffer` and color values
    pub fn new(buffer: &'static mut FrameBuffer) -> Self {
        let info = buffer.info().clone();
        Self {
            pixels: buffer_pixels(buffer).collect::<Vec<_>>(),
            info,
        }
    }

    #[target_feature(enable = "avx")]
    unsafe fn alpha_blend_inner(&mut self, alpha: f32, other: CompositingLayer) {
        if alpha > 1.0 || alpha < 0.0 {
            panic!("Alpha value must be a value between 0 and 1");
        }

        let own_colors = self.pixels.iter().map(|p| p.1.clone()).collect::<Vec<_>>();
        let other_colors = other.pixels.iter().map(|p| p.1.clone()).collect::<Vec<_>>();

        let pixels = self.pixels.clone(); // borrow checker

        for (i, p) in pixels.iter().map(|p| p.0).enumerate() {
            let pixel_offset = p.y as usize * self.info.stride + p.x as usize;

            // first, copy all color values from layer we're currently on
            let mut this_simd = match own_colors[i] {
                PixelColorKind::Bgr(bgr) => {
                    Simd::<u8, 4>::from_slice(&mut [bgr.b(), bgr.g(), bgr.r(), 0])
                }
                PixelColorKind::Rgb(rgb) => {
                    Simd::<u8, 4>::from_slice(&mut [rgb.r(), rgb.g(), rgb.b(), 0])
                }
                PixelColorKind::U8(grayscale) => Simd::<u8, 4>::from_slice(&mut [
                    grayscale.luma(),
                    grayscale.luma(),
                    grayscale.luma(),
                    0,
                ]),
            };

            // next, copy all color values from layer we want to blend with
            let other_simd = match other_colors[i] {
                PixelColorKind::Bgr(bgr) => {
                    Simd::<u8, 4>::from_slice(&mut [bgr.b(), bgr.g(), bgr.r(), 0])
                }
                PixelColorKind::Rgb(rgb) => {
                    Simd::<u8, 4>::from_slice(&mut [rgb.r(), rgb.g(), rgb.b(), 0])
                }
                PixelColorKind::U8(grayscale) => Simd::<u8, 4>::from_slice(&mut [
                    grayscale.luma(),
                    grayscale.luma(),
                    grayscale.luma(),
                    0,
                ]),
            };

            // alpha value to compute
            let alpha_simd = Simd::<f32, 4>::from_array([alpha; 4]);

            // here's where the magic happens
            this_simd = ((alpha_simd * (this_simd.clone().cast::<f32>()))
                + ((Simd::<f32, 4>::from_array([1.0; 4]) - alpha_simd)
                    * (other_simd.clone().cast::<f32>())))
            .cast::<u8>();
            
            // extract result of the alpha-blend formula
            let out_simd = this_simd.to_array();

            // finally, overwrite the pixels with the new values
            self.pixels[pixel_offset] = match own_colors[i] {
                PixelColorKind::Rgb(_) => Pixel(
                    p,
                    PixelColorKind::new(self.info, out_simd[0], out_simd[1], out_simd[2]),
                ),
                PixelColorKind::Bgr(_) => Pixel(
                    p,
                    PixelColorKind::new(self.info, out_simd[2], out_simd[1], out_simd[0]),
                ),
                PixelColorKind::U8(_) => panic!("Grayscale alpha blending not supported"),
            }
        }
    }
    /// Computes alpha values relative to those associated with another layer
    pub fn alpha_blend(&mut self, alpha: f32, other: CompositingLayer) {
        with_avx(|| unsafe { self.alpha_blend_inner(alpha, other) });
    }
    /// Writes finished render to an existing root framebuffer after computations
    pub fn merge_down(&self, root_buffer: &mut FrameBuffer) {
        with_avx(|| unsafe { self.merge_down_inner(root_buffer) })
    }

    #[target_feature(enable = "avx")]
    unsafe fn merge_down_inner(&self, root_buffer: &mut FrameBuffer) {
        for (chunk, pixel) in root_buffer
            .buffer_mut()
            .chunks_exact_mut(4)
            .zip(&self.pixels)
        {
            let mut new_chunk = match pixel.1 {
                PixelColorKind::Bgr(bgr) => {
                    Simd::<u8, 4>::from_slice(&mut [bgr.b(), bgr.g(), bgr.r(), 0])
                }
                PixelColorKind::Rgb(rgb) => {
                    Simd::<u8, 4>::from_slice(&mut [rgb.r(), rgb.g(), rgb.b(), 0])
                }
                PixelColorKind::U8(grayscale) => {
                    Simd::<u8, 4>::from_slice(&mut [grayscale.luma(), 0, 0, 0])
                }
            };

            chunk.copy_from_slice(new_chunk.as_mut_array());
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

            self.pixels[pixel_offset] = match colors[index] {
                PixelColorKind::Rgb(_) => Pixel(
                    point,
                    PixelColorKind::new(self.info, color[0], color[1], color[2]),
                ),
                PixelColorKind::Bgr(_) => Pixel(
                    point,
                    PixelColorKind::new(self.info, color[2], color[1], color[0]),
                ),
                PixelColorKind::U8(gray) => Pixel(
                    point,
                    PixelColorKind::new(self.info, gray.luma(), gray.luma(), gray.luma()),
                ),
            };
        }
        Ok(())
    }
}

unsafe impl Send for CompositingLayer {}
unsafe impl Sync for CompositingLayer {}
