use alloc::{boxed::Box, vec::Vec};
use bootloader_api::info::FrameBuffer;
use embedded_graphics::primitives::{Circle, Line, Rectangle, RoundedRectangle};
use embedded_graphics_core::{prelude::Point, Pixel};
use embedded_layout::{
    layout::linear::{
        spacing::{DistributeFill, Tight},
        FixedMargin, Horizontal, LinearLayout, Vertical,
    },
    prelude::{
        horizontal::{Center as HCenter, Left},
        vertical::{Bottom, Center as VCenter, Top, TopToBottom},
    },
};
use minipng::{ColorType, ImageData};
use tinybmp::Bmp;
use u8g2_fonts::U8g2TextStyle;

pub enum ImageKind<'a> {
    Bmp(Bmp<'a, PixelColorKind>),
    Png(Box<ImageData<'a>>),
}

use super::{CanvasBuf, PixelColorKind};

pub type Text<'a> = embedded_graphics::text::Text<'a, U8g2TextStyle<PixelColorKind>>;

#[allow(unused)] // not finished
pub struct IconButton<'a> {
    bg: Rectangle,
    fg: ImageKind<'a>,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct WindowControls {
    body: Rectangle,
    buttons: [Circle; 3],
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct WindowDecoration<'a> {
    layout: LinearLayout<Horizontal<Top, DistributeFill>, RoundedRectangle>,
    body: RoundedRectangle,
    text: Text<'a>,
    controls: WindowControls,
    appmenu: Menu<'a>,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct Window<'a> {
    layout: LinearLayout<Vertical<HCenter, FixedMargin>, RoundedRectangle>,
    body: RoundedRectangle,
    decoration: WindowDecoration<'a>,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct Dock<'a> {
    layout: LinearLayout<Horizontal<Bottom, FixedMargin>, CanvasBuf>,
    left: RoundedRectangle,
    right: RoundedRectangle,
    mid: Vec<IconButton<'a>>,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct TextInput<'a> {
    background: Rectangle,
    text: &'a mut Text<'a>, // TODO: replace this with owned type in impls
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct TextView<'a> {
    background: Rectangle,
    text: Text<'a>,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct Label<'a> {
    background: RoundedRectangle,
    text: Text<'a>,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct Search<'a> {
    background: RoundedRectangle,
    text: &'a mut Text<'a>, // TODO: replace this with owned type in impls
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct Menu<'a> {
    layout: LinearLayout<Vertical<Left, Tight>, RoundedRectangle>,
    top: RoundedRectangle,
    selection: Option<Label<'a>>,
    items: Vec<TextView<'a>>,
    bottom: RoundedRectangle,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct Tab<'a> {
    layout: LinearLayout<Vertical<Left, Tight>, Rectangle>,
    header: Label<'a>,
    body: Rectangle,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct Ribbon<'a> {
    layout: LinearLayout<Horizontal<VCenter, DistributeFill>, CanvasBuf>,
    system_menu: Menu<'a>,
    global_bar: Vec<TextView<'a>>,
    system_tray: Vec<IconButton<'a>>,
    clock: TextView<'a>,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct Overview<'a> {
    layout: Vec<LinearLayout<Horizontal<TopToBottom, FixedMargin>, CanvasBuf>>,
    grid: Vec<IconButton<'a>>,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct ListView<'a> {
    layout: LinearLayout<Vertical<Left, FixedMargin>, Rectangle>,
    items: Vec<TextView<'a>>,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct NavView<'a> {
    layout: LinearLayout<Horizontal<Top, FixedMargin>, Rectangle>,
    left: ListView<'a>,
    right: TextView<'a>, // TODO: support more view types
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct Slider {
    movable: Circle,
    axis: Line,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct Toggle {
    outline: RoundedRectangle,
    movable: Circle,
    canvas: CanvasBuf,
}

#[allow(unused)] // not finished
pub struct ProgressBar {
    outline: RoundedRectangle,
    indicator: RoundedRectangle,
    canvas: CanvasBuf,
}

pub fn png_points<'a>(inner: &'a ImageData) -> impl Iterator<Item = Point> + 'a {
    (0..inner.width())
        .flat_map(move |x| (0..inner.height()).map(move |y| Point::new(x as i32, y as i32)))
}

pub fn png_color<'a>(inner: &'a ImageData) -> Box<dyn Iterator<Item = PixelColorKind> + 'a> {
    Box::new(png_points(inner).map(move |point| {
        let pixel_chunk = inner
            .pixels()
            .chunks_exact(4)
            .nth(((point.x as u32) + (point.y as u32) * inner.width()) as usize)
            .unwrap();

        let red = pixel_chunk[0];
        let green = pixel_chunk[1];
        let blue = pixel_chunk[2];

        PixelColorKind::from_png_metadata(
            red,
            green,
            blue,
            inner.color_type(),
            inner,
            match inner.color_type() {
                ColorType::Gray => None,
                ColorType::GrayAlpha => Some(pixel_chunk[3]),
                ColorType::Rgb => None,
                ColorType::Rgba => Some(pixel_chunk[3]),
                ColorType::Indexed => None,
            },
        )
    }))
}

pub fn png_pixels<'a>(img: &'a ImageData) -> impl Iterator<Item = Pixel<PixelColorKind>> + 'a {
    png_points(img)
        .zip(png_color(img))
        .map(|(point, color)| Pixel(point, color))
}

pub struct DesktopBackground<'a> {
    img: ImageKind<'a>,
    canvas: CanvasBuf,
}

impl<'a> DesktopBackground<'a> {
    pub fn new(img: ImageKind<'a>, fb: &'a FrameBuffer) -> Self {
        let canvas = CanvasBuf::new(fb);
        Self { img, canvas }
    }

    pub fn image(&self) -> &ImageKind<'a> {
        &self.img
    }

    pub fn image_mut(&mut self) -> &mut ImageKind<'a> {
        &mut self.img
    }

    pub fn draw(&mut self) {
        match self.img {
            // Direct framebuffer writes never fail, as stated also in the `impl` of `DrawTarget` for `CanvasBuf`
            ImageKind::Bmp(ref bmp) => self.canvas.draw_iter_shorthand(bmp.pixels()),
            ImageKind::Png(ref png) => self.canvas.draw_iter_shorthand(png_pixels(png)),
        }
    }

    /// Pushes the canvas to the COMPOSITING_TABLE
    pub fn register(self) {
        self.canvas.register();
    }
}
