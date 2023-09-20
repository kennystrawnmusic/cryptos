use embedded_graphics::primitives::{Rectangle, RoundedRectangle, Circle, Line};
use u8g2_fonts::U8g2TextStyle;
use alloc::vec::Vec;

use super::{Canvas, PixelColorKind};

pub type Text<'a> = embedded_graphics::text::Text<'a, U8g2TextStyle<PixelColorKind>>;

#[allow(unused)] // not finished
pub struct WindowControls {
    background: Rectangle,
    buttons: [Circle; 3],
}

#[allow(unused)] // not finished
pub struct WindowDecoration<'a> {
    background: RoundedRectangle,
    text: Text<'a>,
    controls: WindowControls,
}

#[allow(unused)] // not finished
pub struct Window<'a> {
    background: RoundedRectangle,
    decoration: WindowDecoration<'a>,
}

#[allow(unused)] // not finished
pub struct Dock {
    start: RoundedRectangle,
    mid: Vec<Rectangle>,
    end: RoundedRectangle,
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
    top: RoundedRectangle,
    selection: Option<RoundedRectangle>,
    items: Vec<TextView<'a>>,
    bottom: RoundedRectangle,
}

#[non_exhaustive] // not finished
pub enum WidgetKind<'a> {
    Separator(Line),
    Window(Window<'a>),
    TextInput(TextInput<'a>),
    TextView(TextView<'a>),
    Label(Label<'a>),
    Search(Search<'a>),
    Tab(Rectangle),
    Scrollbar(Rectangle),
    Menu(Menu<'a>),
    Ribbon(Rectangle),
    SystemTray(Rectangle),
    Dock(Dock),
    Overview(Rectangle),
    ListView(Rectangle),
    NavView([Rectangle; 2]),
    Slider((RoundedRectangle, Circle)),
    Toggle((RoundedRectangle, Circle)),
    ProgressBar([RoundedRectangle; 2]),
}

#[allow(unused)] // not finished
pub struct Widget<'a> {
    layer: Canvas,
    kind: WidgetKind<'a>,
}