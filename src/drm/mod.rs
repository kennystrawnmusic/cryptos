// SPDX-License-Identifier: GPL-3.0-or-later

pub mod avx_accel;
pub mod cryptk;

use alloc::{boxed::Box, vec::Vec};
use bootloader_api::info::{FrameBuffer, FrameBufferInfo, PixelFormat};
use core::{
    iter::zip,
    marker::PhantomData,
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
use minipng::{ColorType, ImageData};
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
        kind: ColorType,
        data: &ImageData,
        alpha: Option<u8>,
    ) -> Self {
        let luma = ((red as u32 * green as u32 * blue as u32) / 3) as u8;
        match kind {
            ColorType::Gray => Self::U8(Gray8::new(luma)),
            ColorType::GrayAlpha => Self::U8(Gray8::new(luma))
                .alpha_blend(alpha.unwrap() as f32, Self::U8(Gray8::new(luma))),
            ColorType::Rgb => Self::Rgb(Rgb888::new(red, green, blue)),
            ColorType::Rgba => Self::Rgb(Rgb888::new(red, green, blue)).alpha_blend(
                alpha.unwrap() as f32,
                Self::Rgb(Rgb888::new(red, green, blue)),
            ),
            ColorType::Indexed => Self::Rgb(Rgb888::new(
                data.palette(luma)[0],
                data.palette(luma)[1],
                data.palette(luma)[2],
            )),
        }
    }
    pub fn from_framebuffer(info: FrameBufferInfo, red: u8, green: u8, blue: u8) -> Self {
        let luma = ((red as u32 * green as u32 * blue as u32) / 3) as u8;
        match info.pixel_format {
            PixelFormat::Rgb => Self::Rgb(Rgb888::new(red, green, blue)),
            PixelFormat::Bgr => Self::Bgr(Bgr888::new(red, green, blue)),
            PixelFormat::U8 => Self::U8(Gray8::new(luma)),
            _ => panic!("Unknown pixel format"),
        }
    }

    pub fn from_pixel_array(arr: [Pixel<Self>; 16]) -> [Self; 16] {
        [
            arr[0].1, arr[1].1, arr[2].1, arr[3].1, arr[4].1, arr[5].1, arr[6].1, arr[7].1,
            arr[8].1, arr[9].1, arr[10].1, arr[11].1, arr[12].1, arr[13].1, arr[14].1, arr[15].1,
        ]
    }

    pub fn from_array(info: FrameBufferInfo, arr: [u8; 64]) -> [Self; 16] {
        match info.pixel_format {
            PixelFormat::Rgb => [
                Self::Rgb(Rgb888::new(arr[0], arr[1], arr[2])),
                Self::Rgb(Rgb888::new(arr[4], arr[5], arr[6])),
                Self::Rgb(Rgb888::new(arr[8], arr[9], arr[10])),
                Self::Rgb(Rgb888::new(arr[12], arr[13], arr[14])),
                Self::Rgb(Rgb888::new(arr[16], arr[17], arr[18])),
                Self::Rgb(Rgb888::new(arr[20], arr[21], arr[22])),
                Self::Rgb(Rgb888::new(arr[24], arr[25], arr[26])),
                Self::Rgb(Rgb888::new(arr[28], arr[29], arr[30])),
                Self::Rgb(Rgb888::new(arr[32], arr[33], arr[34])),
                Self::Rgb(Rgb888::new(arr[36], arr[37], arr[38])),
                Self::Rgb(Rgb888::new(arr[40], arr[41], arr[42])),
                Self::Rgb(Rgb888::new(arr[44], arr[45], arr[46])),
                Self::Rgb(Rgb888::new(arr[48], arr[49], arr[50])),
                Self::Rgb(Rgb888::new(arr[52], arr[53], arr[54])),
                Self::Rgb(Rgb888::new(arr[56], arr[57], arr[58])),
                Self::Rgb(Rgb888::new(arr[60], arr[61], arr[62])),
            ],
            PixelFormat::Bgr => [
                Self::Bgr(Bgr888::new(arr[0], arr[1], arr[2])),
                Self::Bgr(Bgr888::new(arr[4], arr[5], arr[6])),
                Self::Bgr(Bgr888::new(arr[8], arr[9], arr[10])),
                Self::Bgr(Bgr888::new(arr[12], arr[13], arr[14])),
                Self::Bgr(Bgr888::new(arr[16], arr[17], arr[18])),
                Self::Bgr(Bgr888::new(arr[20], arr[21], arr[22])),
                Self::Bgr(Bgr888::new(arr[24], arr[25], arr[26])),
                Self::Bgr(Bgr888::new(arr[28], arr[29], arr[30])),
                Self::Bgr(Bgr888::new(arr[32], arr[33], arr[34])),
                Self::Bgr(Bgr888::new(arr[36], arr[37], arr[38])),
                Self::Bgr(Bgr888::new(arr[40], arr[41], arr[42])),
                Self::Bgr(Bgr888::new(arr[44], arr[45], arr[46])),
                Self::Bgr(Bgr888::new(arr[48], arr[49], arr[50])),
                Self::Bgr(Bgr888::new(arr[52], arr[53], arr[54])),
                Self::Bgr(Bgr888::new(arr[56], arr[57], arr[58])),
                Self::Bgr(Bgr888::new(arr[60], arr[61], arr[62])),
            ],
            PixelFormat::U8 => [
                Self::U8(Gray8::new(
                    ((arr[0] as u32 * arr[1] as u32 * arr[2] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[4] as u32 * arr[5] as u32 * arr[6] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[8] as u32 * arr[9] as u32 * arr[10] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[12] as u32 * arr[13] as u32 * arr[14] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[16] as u32 * arr[17] as u32 * arr[18] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[20] as u32 * arr[21] as u32 * arr[22] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[24] as u32 * arr[25] as u32 * arr[26] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[28] as u32 * arr[29] as u32 * arr[30] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[32] as u32 * arr[33] as u32 * arr[34] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[36] as u32 * arr[37] as u32 * arr[38] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[40] as u32 * arr[41] as u32 * arr[42] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[44] as u32 * arr[45] as u32 * arr[46] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[48] as u32 * arr[49] as u32 * arr[50] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[52] as u32 * arr[53] as u32 * arr[54] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[56] as u32 * arr[57] as u32 * arr[58] as u32) / 3) as u8,
                )),
                Self::U8(Gray8::new(
                    ((arr[60] as u32 * arr[61] as u32 * arr[62] as u32) / 3) as u8,
                )),
            ],
            _ => panic!("Unknown pixel format"),
        }
    }

    /// Method for computing alpha values on the fly
    /// Accelerated by SSE/AVX, which alone is powerful enough
    /// to replace most GPUs in terms of performance
    pub fn alpha_blend(&self, alpha: f32, other: PixelColorKind) -> Self {
        with_avx(|| {
            if !(0.0..=1.0).contains(&alpha) {
                panic!("Alpha value must be a value between 0 and 1");
            }

            let this_simd = match self {
                Self::Bgr(bgr) => Simd::<u8, 4>::from_slice(&[bgr.b(), bgr.g(), bgr.r(), 0]),
                Self::Rgb(rgb) => Simd::<u8, 4>::from_slice(&[rgb.r(), rgb.g(), rgb.b(), 0]),
                Self::U8(grayscale) => Simd::<u8, 4>::from_slice(&[
                    grayscale.luma(),
                    grayscale.luma(),
                    grayscale.luma(),
                    0,
                ]),
            };

            let other_simd = match other {
                Self::Bgr(bgr) => Simd::<u8, 4>::from_slice(&[bgr.b(), bgr.g(), bgr.r(), 0]),
                Self::Rgb(rgb) => Simd::<u8, 4>::from_slice(&[rgb.r(), rgb.g(), rgb.b(), 0]),
                Self::U8(grayscale) => Simd::<u8, 4>::from_slice(&[
                    grayscale.luma(),
                    grayscale.luma(),
                    grayscale.luma(),
                    0,
                ]),
            };

            let alpha_simd = Simd::<f32, 4>::from_array([alpha; 4]);

            let this_simd = ((alpha_simd * (this_simd.cast::<f32>()))
                + ((Simd::<f32, 4>::from_array([1.0; 4]) - alpha_simd)
                    * (other_simd.cast::<f32>())))
            .cast::<u8>();

            let out_simd = this_simd.to_array();

            match self {
                Self::Rgb(_) => Self::Rgb(Rgb888::new(out_simd[0], out_simd[1], out_simd[2])),
                Self::Bgr(_) => Self::Bgr(Bgr888::new(out_simd[0], out_simd[1], out_simd[2])),
                Self::U8(_) => {
                    let luma = {
                        let red_blend = out_simd[0] as u32;
                        let green_blend = out_simd[1] as u32;
                        let blue_blend = out_simd[2] as u32;
                        ((red_blend * green_blend * blue_blend) / 3) as u8
                    };
                    Self::U8(Gray8::new(luma))
                }
            }
        })
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
                    .map(move |((r, g), b)| PixelColorKind::from_framebuffer(info, *r, *g, *b)),
            )
        }
        PixelFormat::Bgr => {
            let blue = buffer.buffer().iter().step_by(info.bytes_per_pixel);
            let green = buffer.buffer().iter().skip(1).step_by(info.bytes_per_pixel);
            let red = buffer.buffer().iter().skip(2).step_by(info.bytes_per_pixel);
            Box::new(
                red.zip(green)
                    .zip(blue)
                    .map(move |((r, g), b)| PixelColorKind::from_framebuffer(info, *r, *g, *b)),
            )
        }
        PixelFormat::U8 => {
            let gray = buffer.buffer().iter().step_by(info.bytes_per_pixel);
            Box::new(gray.map(move |g| PixelColorKind::from_framebuffer(info, *g, *g, *g)))
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
    pub fn new<'a>(buffer: &'a mut FrameBuffer) -> Self {
        let info = buffer.info();
        Self {
            pixels: buffer_pixels(buffer).collect::<Vec<_>>(),
            info,
        }
    }

    /// Shortcut for draw_iter to avoid needing to call `unwrap` every time I need to use this
    pub fn draw_iter_shorthand<I>(&mut self, pixels: I)
    where
        I: IntoIterator<Item = Pixel<<Self as DrawTarget>::Color>>,
    {
        self.draw_iter(pixels).unwrap()
    }

    /// Computes alpha values on the fly
    pub fn alpha_blend(&mut self, alpha: f32, other: CanvasBuf) {
        with_avx(|| {
            let own_pixels = self.pixels.clone();
            let other_pixels = other.pixels.clone();

            let own_array_chunks = own_pixels.array_chunks::<16>();
            let other_array_chunks = other_pixels.array_chunks::<16>();

            let mut step_idx = 15;
            for (own, other) in own_array_chunks.zip(other_array_chunks).step_by(16) {
                let own_simd = Simd::<u8, 64>::from_slice(
                    &[
                        match own[0].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[1].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[2].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[3].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[4].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[5].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[6].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[7].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[8].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[9].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[10].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[11].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[12].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[13].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[14].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match own[15].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                    ]
                    .flatten(),
                );

                let other_simd = Simd::<u8, 64>::from_slice(
                    &[
                        match other[0].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[1].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[2].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[3].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[4].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[5].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[6].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[7].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[8].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[9].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[10].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[11].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[12].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[13].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[14].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                        match other[15].1 {
                            PixelColorKind::Bgr(bgr) => [bgr.b(), bgr.g(), bgr.r(), 0],
                            PixelColorKind::Rgb(rgb) => [rgb.r(), rgb.g(), rgb.b(), 0],
                            PixelColorKind::U8(gray) => [gray.luma(), 0, 0, 0],
                        },
                    ]
                    .flatten(),
                );

                let alpha_simd = Simd::<f32, 64>::from_array([alpha; 64]);

                let this_simd = ((alpha_simd * (own_simd.cast::<f32>()))
                    + ((Simd::<f32, 64>::from_array([1.0; 64]) - alpha_simd)
                        * (other_simd.cast::<f32>())))
                .cast::<u8>();

                let out_simd = this_simd.to_array();

                let out = PixelColorKind::from_array(self.info, out_simd);

                let out_pixels = [
                    Pixel(own[0].0, out[0]),
                    Pixel(own[1].0, out[1]),
                    Pixel(own[2].0, out[2]),
                    Pixel(own[3].0, out[3]),
                    Pixel(own[4].0, out[4]),
                    Pixel(own[5].0, out[5]),
                    Pixel(own[6].0, out[6]),
                    Pixel(own[7].0, out[7]),
                    Pixel(own[8].0, out[8]),
                    Pixel(own[9].0, out[9]),
                    Pixel(own[10].0, out[10]),
                    Pixel(own[11].0, out[11]),
                    Pixel(own[12].0, out[12]),
                    Pixel(own[13].0, out[13]),
                    Pixel(own[14].0, out[14]),
                    Pixel(own[15].0, out[15]),
                ];

                self.pixels[..step_idx].copy_from_slice(out_pixels.as_slice());
                step_idx += 16;
            }
        });
    }

    /// Writes finished canvas render to an existing root framebuffer after computations
    ///
    /// Automatically called by the rendering loop at the end of maink
    pub fn merge_down(&self, root_buffer: &mut FrameBuffer) {
        with_avx(|| {
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
        })
    }

    /// Adds this canvas to the compositing table
    pub fn register(self) {
        COMPOSITING_TABLE.write().push(self);
    }
}

impl OriginDimensions for CanvasBuf {
    fn size(&self) -> Size {
        let horiz = self.info.width as u32;
        let vert = self.info.height as u32;
        Size::new(horiz, vert)
    }
}

impl DrawTarget for CanvasBuf {
    type Color = PixelColorKind;

    // this is why calling `unwrap` on `draw_iter` is always safe: direct framebuffer writes never fail
    type Error = !;

    fn draw_iter<I>(&mut self, pixels: I) -> Result<(), Self::Error>
    where
        I: IntoIterator<Item = Pixel<Self::Color>>,
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
                    PixelColorKind::from_framebuffer(self.info, color[0], color[1], color[2]),
                ),
                PixelColorKind::Bgr(_) => Pixel(
                    point,
                    PixelColorKind::from_framebuffer(self.info, color[2], color[1], color[0]),
                ),
                PixelColorKind::U8(gray) => Pixel(
                    point,
                    PixelColorKind::from_framebuffer(
                        self.info,
                        gray.luma(),
                        gray.luma(),
                        gray.luma(),
                    ),
                ),
            };
        }
        Ok(())
    }
}

unsafe impl Send for CanvasBuf {}
unsafe impl Sync for CanvasBuf {}
