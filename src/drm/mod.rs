// SPDX-License-Identifier: GPL-3.0-or-later

pub mod avx_accel;
pub mod cryptk;

use alloc::{boxed::Box, vec::Vec};
use bootloader_api::info::{FrameBuffer, FrameBufferInfo, PixelFormat};
use core::simd::{Simd, SimdFloat, SimdUint};
use embedded_graphics::{
    pixelcolor::{Bgr888, Gray8, Rgb888},
    prelude::{GrayColor, OriginDimensions, PixelColor, RgbColor, Size},
    Pixel,
};
use embedded_graphics_core::{
    draw_target::DrawTarget,
    geometry::Point,
    pixelcolor::{raw::RawU24, Rgb555, Rgb565},
};
use minipng::{ColorType, ImageData};
use spin::RwLock;

use self::avx_accel::with_avx;

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

#[repr(simd)]
pub struct Pixelx16(
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
    *mut Pixel<PixelColorKind>,
);

impl Pixelx16 {
    pub fn new() -> Self {
        Self(
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
            Box::into_raw(Box::new(Pixel(
                Point::new(0, 0),
                PixelColorKind::U8(Gray8::new(0)),
            ))) as *mut _,
        )
    }

    pub fn from_array(arr: [Pixel<PixelColorKind>; 16]) -> Self {
        Self(
            Box::into_raw(Box::new(arr[0])) as *mut _,
            Box::into_raw(Box::new(arr[1])) as *mut _,
            Box::into_raw(Box::new(arr[2])) as *mut _,
            Box::into_raw(Box::new(arr[3])) as *mut _,
            Box::into_raw(Box::new(arr[4])) as *mut _,
            Box::into_raw(Box::new(arr[5])) as *mut _,
            Box::into_raw(Box::new(arr[6])) as *mut _,
            Box::into_raw(Box::new(arr[7])) as *mut _,
            Box::into_raw(Box::new(arr[8])) as *mut _,
            Box::into_raw(Box::new(arr[9])) as *mut _,
            Box::into_raw(Box::new(arr[10])) as *mut _,
            Box::into_raw(Box::new(arr[11])) as *mut _,
            Box::into_raw(Box::new(arr[12])) as *mut _,
            Box::into_raw(Box::new(arr[13])) as *mut _,
            Box::into_raw(Box::new(arr[14])) as *mut _,
            Box::into_raw(Box::new(arr[15])) as *mut _,
        )
    }

    pub fn from_slice<'a>(slice: &'a mut [Pixel<PixelColorKind>]) -> Self {
        Self(
            Box::into_raw(Box::new(slice[0])) as *mut _,
            Box::into_raw(Box::new(slice[1])) as *mut _,
            Box::into_raw(Box::new(slice[2])) as *mut _,
            Box::into_raw(Box::new(slice[3])) as *mut _,
            Box::into_raw(Box::new(slice[4])) as *mut _,
            Box::into_raw(Box::new(slice[5])) as *mut _,
            Box::into_raw(Box::new(slice[6])) as *mut _,
            Box::into_raw(Box::new(slice[7])) as *mut _,
            Box::into_raw(Box::new(slice[8])) as *mut _,
            Box::into_raw(Box::new(slice[9])) as *mut _,
            Box::into_raw(Box::new(slice[10])) as *mut _,
            Box::into_raw(Box::new(slice[11])) as *mut _,
            Box::into_raw(Box::new(slice[12])) as *mut _,
            Box::into_raw(Box::new(slice[13])) as *mut _,
            Box::into_raw(Box::new(slice[14])) as *mut _,
            Box::into_raw(Box::new(slice[15])) as *mut _,
        )
    }

    pub fn as_mut_slice<'a>(&mut self) -> &'a mut [Pixel<PixelColorKind>] {
        unsafe { core::slice::from_mut_ptr_range::<'a>(self.0..self.15) }
    }

    pub fn as_slice<'a>(&self) -> &'a [Pixel<PixelColorKind>] {
        unsafe { core::slice::from_mut_ptr_range(self.0..self.15) }
    }

    pub fn alpha_blend(&mut self, alpha: f32, other: Self) {
        let me = self.as_mut_slice();
        let other = other.as_slice();

        // Need to hardcode all these individually due to SIMD performance requirements
        me[0].1 = me[0].1.alpha_blend(alpha, other[0].1);
        me[1].1 = me[1].1.alpha_blend(alpha, other[1].1);
        me[2].1 = me[2].1.alpha_blend(alpha, other[2].1);
        me[3].1 = me[3].1.alpha_blend(alpha, other[3].1);
        me[4].1 = me[4].1.alpha_blend(alpha, other[4].1);
        me[5].1 = me[5].1.alpha_blend(alpha, other[5].1);
        me[6].1 = me[6].1.alpha_blend(alpha, other[6].1);
        me[7].1 = me[7].1.alpha_blend(alpha, other[7].1);
        me[8].1 = me[8].1.alpha_blend(alpha, other[8].1);
        me[9].1 = me[9].1.alpha_blend(alpha, other[9].1);
        me[10].1 = me[10].1.alpha_blend(alpha, other[10].1);
        me[11].1 = me[11].1.alpha_blend(alpha, other[11].1);
        me[12].1 = me[12].1.alpha_blend(alpha, other[12].1);
        me[13].1 = me[13].1.alpha_blend(alpha, other[13].1);
        me[14].1 = me[14].1.alpha_blend(alpha, other[14].1);
        me[15].1 = me[15].1.alpha_blend(alpha, other[15].1);
    }
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

    /// Method for computing alpha values on the fly
    /// Accelerated by SSE/AVX, which alone is powerful enough
    /// to replace most GPUs in terms of performance
    pub fn alpha_blend(&self, alpha: f32, other: PixelColorKind) -> Self {
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
            + ((Simd::<f32, 4>::from_array([1.0; 4]) - alpha_simd) * (other_simd.cast::<f32>())))
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
    pub fn alpha_blend(&mut self, alpha: f32, other: &mut CanvasBuf) {
        with_avx(|| {
            let mut new_pixels = self.pixels.clone(); // borrow checker

            let own_chunks = self.pixels.array_chunks_mut();
            let other_chunks = other.pixels.array_chunks_mut();
            let mut step_idx = 16;

            for (this, other) in own_chunks.zip(other_chunks) {
                let mut this = Pixelx16::from_array(*this);
                let other = Pixelx16::from_array(*other);

                this.alpha_blend(alpha, other);

                new_pixels[step_idx - 16..step_idx].copy_from_slice(this.as_slice());

                step_idx += 16;
            }

            self.pixels = new_pixels;
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
