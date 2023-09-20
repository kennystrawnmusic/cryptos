use embedded_graphics::primitives::{Rectangle, RoundedRectangle, Circle};

use super::CompositingLayer;

#[non_exhaustive] // not finished
pub enum WidgetClass {
    Window(RoundedRectangle),
    MinMaxClose((Rectangle, [Circle; 3])),
    TextInput(RoundedRectangle),
    TextView(RoundedRectangle),
    Search(RoundedRectangle),
    Tab(Rectangle),
    Scrollbar(Rectangle),
    Menu(RoundedRectangle),
    MenuItem(RoundedRectangle),
    Ribbon(Rectangle),
    SystemTray(Rectangle),
    Dock(RoundedRectangle),
    Overview(Rectangle),
    ListView(Rectangle),
    NavView([Rectangle; 2]),
    Slider((RoundedRectangle, Circle)),
    Toggle((RoundedRectangle, Circle)),
    ProgressBar([RoundedRectangle; 2]),
}

#[allow(unused)] // not finished
pub struct Widget {
    layer: CompositingLayer,
    class: WidgetClass,
}