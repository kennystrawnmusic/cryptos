use embedded_graphics::{primitives::{Rectangle, RoundedRectangle, Circle, Line}, text::Text};
use u8g2_fonts::U8g2TextStyle;
use alloc::vec::Vec;

use super::{CompositingLayer, PixelColorKind};

#[allow(unused)] // not finished
pub struct WindowDecoration<'a> {
    background: RoundedRectangle,
    text: Text<'a, U8g2TextStyle<PixelColorKind>>,
}

#[non_exhaustive] // not finished
pub enum WidgetKind<'a> {
    Separator(Line),
    Window(WindowDecoration<'a>),
    MinMaxClose((Rectangle, [Circle; 3])),
    TextInput(RoundedRectangle),
    TextView(RoundedRectangle),
    Label(Rectangle),
    Search(RoundedRectangle),
    Tab(Rectangle),
    Scrollbar(Rectangle),
    Menu(RoundedRectangle),
    MenuItem(RoundedRectangle),
    Ribbon(Rectangle),
    SystemTray(Rectangle),
    Dock((RoundedRectangle, Vec<Rectangle>)),
    Overview(Rectangle),
    ListView(Rectangle),
    NavView([Rectangle; 2]),
    Slider((RoundedRectangle, Circle)),
    Toggle((RoundedRectangle, Circle)),
    ProgressBar([RoundedRectangle; 2]),
}

#[allow(unused)] // not finished
pub struct Widget<'a> {
    layer: CompositingLayer,
    kind: WidgetKind<'a>,
}