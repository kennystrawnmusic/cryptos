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
use embedded_graphics_core::{
    draw_target::DrawTarget,
    geometry::Point,
    pixelcolor::{raw::RawU24, Rgb555, Rgb565},
    prelude::RawData,
};
use minipng::ImageData;
use spin::RwLock;

use self::avx_accel::{enable_avx, with_avx};

/// Vector of compositing layers for the rendering loop to merge down as it iterates
pub(crate) static COMPOSITING_TABLE: RwLock<Vec<CanvasBuf>> = RwLock::new(Vec::new());

/// Converts a raw framebuffer byte stream into an iterator of `Point` objects
pub fn buffer_points(buffer: &FrameBuffer) -> impl Iterator<Item = Point> {
    let info = buffer.info();
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
    pub fn from_png_metadata(
        red: u8,
        green: u8,
        blue: u8,
        kind: minipng::ColorType,
        data: &ImageData,
    ) -> Self {
        let luma = ((red as u32 * green as u32 * blue as u32) / 3) as u8;
        match kind {
            minipng::ColorType::Gray => Self::U8(Gray8::new(luma)),
            minipng::ColorType::GrayAlpha => Self::U8(Gray8::new(luma)),
            minipng::ColorType::Rgb => Self::Rgb(Rgb888::new(red, green, blue)),
            minipng::ColorType::Rgba => Self::Rgb(Rgb888::new(red, green, blue)),
            minipng::ColorType::Indexed => Self::Rgb(Rgb888::new(
                data.palette(luma)[0],
                data.palette(luma)[1],
                data.palette(luma)[2],
            )),
        }
    }
    pub fn new(info: FrameBufferInfo, red: u8, green: u8, blue: u8) -> Self {
        let luma = ((red as u32 * green as u32 * blue as u32) / 3) as u8;
        match info.pixel_format {
            PixelFormat::Rgb => Self::Rgb(Rgb888::new(red, green, blue)),
            PixelFormat::Bgr => Self::Bgr(Bgr888::new(red, green, blue)),
            PixelFormat::U8 => Self::U8(Gray8::new(luma)),
            _ => panic!("Unknown pixel format"),
        }
    }
}

impl Clone for PixelColorKind {
    fn clone(&self) -> Self {
        *self
    }
}

impl From<RawU24> for PixelColorKind {
    fn from(value: RawU24) -> Self {
        Self::Rgb(Rgb888::from(value))
    }
}

impl From<Rgb555> for PixelColorKind {
    fn from(value: Rgb555) -> Self {
        Self::Rgb(Rgb888::from(value))
    }
}

impl From<Rgb565> for PixelColorKind {
    fn from(value: Rgb565) -> Self {
        Self::Rgb(Rgb888::from(value))
    }
}

impl From<Rgb888> for PixelColorKind {
    fn from(value: Rgb888) -> Self {
        Self::Rgb(value)
    }
}

impl Copy for PixelColorKind {}

impl PixelColor for PixelColorKind {
    type Raw = RawU24; // as high as Rgb888/Bgr888 will go
}

/// Extracts color information from the framebuffer
pub fn buffer_color(buffer: &FrameBuffer) -> Box<dyn Iterator<Item = PixelColorKind> + '_> {
    let info = buffer.info();
    match info.pixel_format {
        PixelFormat::Rgb => {
            let red = buffer.buffer().iter().step_by(info.bytes_per_pixel);
            let green = buffer.buffer().iter().skip(1).step_by(info.bytes_per_pixel);
            let blue = buffer.buffer().iter().skip(2).step_by(info.bytes_per_pixel);
            Box::new(
                red.zip(green)
                    .zip(blue)
                    .map(move |((r, g), b)| PixelColorKind::new(info, *r, *g, *b)),
            )
        }
        PixelFormat::Bgr => {
            let blue = buffer.buffer().iter().step_by(info.bytes_per_pixel);
            let green = buffer.buffer().iter().skip(1).step_by(info.bytes_per_pixel);
            let red = buffer.buffer().iter().skip(2).step_by(info.bytes_per_pixel);
            Box::new(
                red.zip(green)
                    .zip(blue)
                    .map(move |((r, g), b)| PixelColorKind::new(info, *r, *g, *b)),
            )
        }
        PixelFormat::U8 => {
            let gray = buffer.buffer().iter().step_by(info.bytes_per_pixel);
            Box::new(gray.map(move |g| PixelColorKind::new(info, *g, *g, *g)))
        }
        _ => panic!("Unknown pixel format"),
    }
}

/// Converts a raw framebuffer byte stream into an iterator over pixels
pub fn buffer_pixels(buffer: &FrameBuffer) -> impl Iterator<Item = Pixel<PixelColorKind>> + '_ {
    buffer_points(buffer)
        .zip(buffer_color(buffer))
        .map(|(point, color)| Pixel(point, color))
}

/// Canvas buffer for compositing
///
/// Includes a `.merge_down()` method to allow for easy writes to the main framebuffer after computation
#[allow(dead_code)]
#[derive(Clone)]
pub struct CanvasBuf {
    pixels: Vec<Pixel<PixelColorKind>>,
    info: FrameBufferInfo,
}

impl CanvasBuf {
    /// Creates a new canvas using a provided `FrameBuffer` and color values
    pub fn new(buffer: &'static FrameBuffer) -> Self {
        let info = buffer.info();
        Self {
            pixels: buffer_pixels(buffer).collect::<Vec<_>>(),
            info,
        }
    }

    #[target_feature(enable = "avx")]
    unsafe fn alpha_blend_inner(&mut self, alpha: f32, other: CanvasBuf) {
        if !(0.0..=1.0).contains(&alpha) {
            panic!("Alpha value must be a value between 0 and 1");
        }

        let own_colors = self.pixels.iter().map(|p| p.1).collect::<Vec<_>>();
        let other_colors = other.pixels.iter().map(|p| p.1).collect::<Vec<_>>();

        let pixels = self.pixels.clone(); // borrow checker

        for (i, p) in pixels.iter().map(|p| p.0).enumerate() {
            let pixel_offset = p.y as usize * self.info.stride + p.x as usize;

            // first, copy all color values from layer we're currently on
            let mut this_simd = match own_colors[i] {
                PixelColorKind::Bgr(bgr) => {
                    Simd::<u8, 4>::from_slice(&[bgr.b(), bgr.g(), bgr.r(), 0])
                }
                PixelColorKind::Rgb(rgb) => {
                    Simd::<u8, 4>::from_slice(&[rgb.r(), rgb.g(), rgb.b(), 0])
                }
                PixelColorKind::U8(grayscale) => Simd::<u8, 4>::from_slice(&[
                    grayscale.luma(),
                    grayscale.luma(),
                    grayscale.luma(),
                    0,
                ]),
            };

            // next, copy all color values from layer we want to blend with
            let other_simd = match other_colors[i] {
                PixelColorKind::Bgr(bgr) => {
                    Simd::<u8, 4>::from_slice(&[bgr.b(), bgr.g(), bgr.r(), 0])
                }
                PixelColorKind::Rgb(rgb) => {
                    Simd::<u8, 4>::from_slice(&[rgb.r(), rgb.g(), rgb.b(), 0])
                }
                PixelColorKind::U8(grayscale) => Simd::<u8, 4>::from_slice(&[
                    grayscale.luma(),
                    grayscale.luma(),
                    grayscale.luma(),
                    0,
                ]),
            };

            // alpha value to compute
            let alpha_simd = Simd::<f32, 4>::from_array([alpha; 4]);

            // here's where the magic happens
            this_simd = ((alpha_simd * (this_simd.cast::<f32>()))
                + ((Simd::<f32, 4>::from_array([1.0; 4]) - alpha_simd)
                    * (other_simd.cast::<f32>())))
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
    /// Computes alpha values relative to those associated with another canvas
    pub fn alpha_blend(&mut self, alpha: f32, other: CanvasBuf) {
        with_avx(|| unsafe { self.alpha_blend_inner(alpha, other) });
    }
    /// Writes finished canvas render to an existing root framebuffer after computations
    ///
    /// Automatically called by the rendering loop at the end of maink
    pub fn merge_down(&self, root_buffer: &mut FrameBuffer) {
        with_avx(|| unsafe { self.merge_down_inner(root_buffer) })
    }

    #[target_feature(enable = "avx")]
    unsafe fn merge_down_inner(&self, root_buffer: &mut FrameBuffer) {
        let bpp = root_buffer.info().bytes_per_pixel;

        for (chunk, pixel) in root_buffer
            .buffer_mut()
            .chunks_exact_mut(bpp)
            .zip(&self.pixels)
        {
            let mut new_chunk = match pixel.1 {
                PixelColorKind::Bgr(bgr) => {
                    Simd::<u8, 4>::from_slice(&[bgr.b(), bgr.g(), bgr.r(), 0])
                }
                PixelColorKind::Rgb(rgb) => {
                    Simd::<u8, 4>::from_slice(&[rgb.r(), rgb.g(), rgb.b(), 0])
                }
                PixelColorKind::U8(grayscale) => {
                    Simd::<u8, 4>::from_slice(&[grayscale.luma(), 0, 0, 0])
                }
            };

            chunk.copy_from_slice(new_chunk.as_mut_array());
        }
    }
    /// Adds the given canvas to the compositing table
    pub fn register(self) {
        COMPOSITING_TABLE.write().push(self);
    }
}

impl OriginDimensions for CanvasBuf {
    fn size(&self) -> embedded_graphics::prelude::Size {
        let horiz = self.info.width as u32;
        let vert = self.info.height as u32;
        Size::new(horiz, vert)
    }
}

impl DrawTarget for CanvasBuf {
    type Color = PixelColorKind;
    type Error = !; //direct framebuffer writes never fail

    fn draw_iter<I>(&mut self, pixels: I) -> Result<(), Self::Error>
    where
        I: IntoIterator<Item = embedded_graphics::Pixel<Self::Color>>,
    {
        let pixels = pixels.into_iter().collect::<Vec<_>>();
        let colors = pixels.iter().map(|p| p.1).collect::<Vec<_>>();

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

unsafe impl Send for CanvasBuf {}
unsafe impl Sync for CanvasBuf {}
