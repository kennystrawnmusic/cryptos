use alloc::{boxed::Box, vec::Vec};
use byteorder::LittleEndian;
use embedded_graphics::{
    draw_target::DrawTarget,
    image::{Image, ImageRaw},
    primitives::{Circle, Line, Rectangle, RoundedRectangle},
};
use embedded_graphics_core::{prelude::Point, Pixel};
use embedded_layout::{
    layout::linear::{
        spacing::{DistributeFill, Tight},
        FixedMargin, Horizontal, LinearLayout, Vertical,
    },
    prelude::{
        horizontal::{Center as HCenter, Left, LeftToRight},
        vertical::{Bottom, Center as VCenter, Top, TopToBottom},
        Chain,
    },
};
use minipng::ImageData;
use tinybmp::Bmp;
use u8g2_fonts::U8g2TextStyle;

pub enum ImageKind<'a> {
    Bmp(Bmp<'a, PixelColorKind>),
    Png(ImageData<'a>),
}

use super::{CanvasBuf, PixelColorKind};

pub type Text<'a> = embedded_graphics::text::Text<'a, U8g2TextStyle<PixelColorKind>>;

#[allow(unused)] // not finished
pub struct IconButton<'a> {
    bg: Rectangle,
    fg: ImageKind<'a>,
}

#[allow(unused)] // not finished
pub struct WindowControls {
    background: Rectangle,
    buttons: [Circle; 3],
}

#[allow(unused)] // not finished
pub struct WindowDecoration<'a> {
    layout: LinearLayout<Horizontal<Top, DistributeFill>, RoundedRectangle>,
    background: RoundedRectangle,
    text: Text<'a>,
    controls: WindowControls,
    appmenu: Menu<'a>,
}

#[allow(unused)] // not finished
pub struct Window<'a> {
    layout: LinearLayout<Vertical<HCenter, FixedMargin>, RoundedRectangle>,
    background: RoundedRectangle,
    decoration: WindowDecoration<'a>,
}

#[allow(unused)] // not finished
pub struct Dock<'a> {
    layout: LinearLayout<Horizontal<Bottom, FixedMargin>, CanvasBuf>,
    left: RoundedRectangle,
    right: RoundedRectangle,
    mid: Vec<IconButton<'a>>,
}

#[allow(unused)] // not finished
pub struct TextInput<'a> {
    background: Rectangle,
    text: &'a mut Text<'a>, // TODO: replace this with owned type in impls
}

#[allow(unused)] // not finished
pub struct TextView<'a> {
    background: Rectangle,
    text: Text<'a>,
}

#[allow(unused)] // not finished
pub struct Label<'a> {
    background: RoundedRectangle,
    text: Text<'a>,
}

#[allow(unused)] // not finished
pub struct Search<'a> {
    background: RoundedRectangle,
    text: &'a mut Text<'a>, // TODO: replace this with owned type in impls
}

#[allow(unused)] // not finished
pub struct Menu<'a> {
    layout: LinearLayout<Vertical<Left, Tight>, RoundedRectangle>,
    top: RoundedRectangle,
    selection: Option<Label<'a>>,
    items: Vec<TextView<'a>>,
    bottom: RoundedRectangle,
}

#[allow(unused)] // not finished
pub struct Tab<'a> {
    layout: LinearLayout<Vertical<Left, Tight>, Rectangle>,
    header: Label<'a>,
    body: Rectangle,
}

#[allow(unused)] // not finished
pub struct Ribbon<'a> {
    layout: LinearLayout<Horizontal<VCenter, DistributeFill>, CanvasBuf>,
    system_menu: Menu<'a>,
    global_bar: Vec<TextView<'a>>,
    system_tray: Vec<IconButton<'a>>,
    clock: TextView<'a>,
}

#[allow(unused)] // not finished
pub struct Overview<'a> {
    layout: Vec<LinearLayout<Horizontal<TopToBottom, FixedMargin>, CanvasBuf>>,
    grid: Vec<IconButton<'a>>,
}

#[allow(unused)] // not finished
pub struct ListView<'a> {
    layout: LinearLayout<Vertical<Left, FixedMargin>, Rectangle>,
    items: Vec<TextView<'a>>,
}

#[allow(unused)] // not finished
pub struct NavView<'a> {
    layout: LinearLayout<Horizontal<Top, FixedMargin>, Rectangle>,
    left: ListView<'a>,
    right: TextView<'a>, // TODO: support more view types
}

#[allow(unused)] // not finished
pub struct Slider {
    movable: Circle,
    axis: Line,
}

#[allow(unused)] // not finished
pub struct Toggle {
    outline: RoundedRectangle,
    movable: Circle,
}

#[allow(unused)] // not finished
pub struct ProgressBar {
    outline: RoundedRectangle,
    indicator: RoundedRectangle,
}

#[non_exhaustive] // not finished
pub enum WidgetKind<'a> {
    Separator(Line),
    Window(Window<'a>),
    TextInput(TextInput<'a>),
    TextView(TextView<'a>),
    Label(Label<'a>),
    Search(Search<'a>),
    Tab(Tab<'a>),
    Scrollbar(Rectangle),
    Menu(Menu<'a>),
    Ribbon(Ribbon<'a>),
    Dock(Dock<'a>),
    Overview(Overview<'a>),
    ListView(ListView<'a>),
    NavView(NavView<'a>),
    Slider(Slider),
    Toggle(Toggle),
    ProgressBar(ProgressBar),
}

#[allow(unused)] // not finished
pub struct Widget<'a> {
    canvas: CanvasBuf,
    kind: WidgetKind<'a>,
}

pub struct DesktopBackground<'a>(ImageKind<'a>);

pub fn png_points<'a>(inner: &'a ImageData) -> impl Iterator<Item = Point> + 'a {
    (0..inner.width())
        .flat_map(move |x| (0..inner.height()).map(move |y| Point::new(x as i32, y as i32)))
}

pub fn png_color<'a>(inner: &'a ImageData) -> Box<dyn Iterator<Item = PixelColorKind> + 'a> {
    Box::new(png_points(inner).map(move |point| {
        let pixel_chunk = inner
            .pixels()
            .chunks_exact(4)
            .nth(point.y as usize)
            .unwrap();

        let red = pixel_chunk[0];
        let green = pixel_chunk[1];
        let blue = pixel_chunk[2];

        PixelColorKind::from_png_metadata(red, green, blue, inner.color_type(), &inner)
    }))
}

pub fn png_pixels<'a>(img: &'a ImageData) -> impl Iterator<Item = Pixel<PixelColorKind>> + 'a {
    png_points(img)
        .zip(png_color(img))
        .map(|(point, color)| Pixel(point, color))
}

impl<'a> DesktopBackground<'a> {
    pub fn new(image: ImageKind<'a>) -> Self {
        Self(image)
    }

    pub fn image(&self) -> &ImageKind<'a> {
        &self.0
    }

    pub fn image_mut(&mut self) -> &mut ImageKind<'a> {
        &mut self.0
    }

    pub fn draw(&self, c: &mut CanvasBuf) {
        match self.image() {
            ImageKind::Bmp(bmp) => {
                c.draw_iter(bmp.pixels()).unwrap(); // error is type-aliased to `!` anyway
            }
            ImageKind::Png(png) => {
                c.draw_iter(png_pixels(png)).unwrap(); // error is type-aliased to `!` anyway
            }
        }
    }
}
