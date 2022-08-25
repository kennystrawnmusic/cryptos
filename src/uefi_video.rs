use conquer_once::spin::OnceCell;
use core::fmt::Write;
use noto_sans_mono_bitmap::{get_bitmap, get_bitmap_width, BitmapChar, BitmapHeight, FontWeight};
use spin::Mutex;
use spinning_top::{lock_api::RawMutex, Spinlock};
use uefi::{
    proto::console::gop::{GraphicsOutput, PixelFormat},
    table::{Boot, SystemTable},
};
use x86_64::PhysAddr;

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
pub enum ColorFormat {
    Rgb,
    Bgr,
    U8,
}

#[derive(Debug, Clone, Copy)]
pub struct FramebufferInfo {
    pub byte_count: usize,
    pub x: usize,
    pub y: usize,
    pub color: ColorFormat,
    pub bpp: usize,
    pub stride: usize,
}

#[derive(Debug, Clone)] // compositing
pub struct Framebuffer {
    pub begin: u64,
    pub byte_count: usize,
    pub info: FramebufferInfo,
}

impl Framebuffer {
    unsafe fn as_slice<'a>(&self) -> &'static mut [u8] {
        core::slice::from_raw_parts_mut(self.begin as *mut u8, self.byte_count)
    }

    pub fn buffer(&self) -> &[u8] {
        unsafe { self.as_slice() }
    }

    pub fn buffer_mut(&mut self) -> &mut [u8] {
        unsafe { self.as_slice() }
    }

    pub fn info(&self) -> FramebufferInfo {
        self.info
    }

    pub fn alpha_blend(&mut self, _parent: Framebuffer) -> &mut [u8] {
        todo!()
    }
}

pub struct Printk {
    buffer: &'static mut [u8],
    info: FramebufferInfo,
    x: usize,
    y: usize,
}

impl Printk {
    #[allow(dead_code)]
    pub fn new(buffer: &'static mut [u8], info: FramebufferInfo) -> Self {
        let mut printk = Self {
            buffer,
            info,
            x: 0,
            y: 0,
        };
        printk.clear();
        printk
    }

    pub fn draw_grayscale(&mut self, x: usize, y: usize, intensity: u8) {
        // Pixel offset
        let poff = y * self.info.stride + x;

        let u8_intensity = {
            if intensity > 200 {
                0xf
            } else {
                0
            }
        };

        let color = match self.info.color {
            ColorFormat::Rgb => [intensity, intensity, intensity / 2, 0],

            ColorFormat::Bgr => [intensity / 2, intensity, intensity, 0],

            ColorFormat::U8 => [u8_intensity, 0, 0, 0],
            //TODO: use embedded-graphics to solve this problem
            // _ => panic!("Unknown pixel format"),
        };

        // Number of bytes in a pixel (4 on my machine)
        let bpp = self.info.bpp;

        // Byte offset: multiply bytes-per-pixel by pixel offset to obtain
        let boff = poff * bpp;

        // Copy bytes
        self.buffer[boff..(boff + bpp)].copy_from_slice(&color[..bpp]);

        // Raw pointer to buffer start ― that's why this is unsafe
        let _ = unsafe { core::ptr::read_volatile(&self.buffer[boff]) };
    }

    pub fn render(&mut self, rendered: BitmapChar) {
        // Loop through lines
        for (y, ln) in rendered.bitmap().iter().enumerate() {
            // Loop through characters on each line
            for (x, col) in ln.iter().enumerate() {
                // Use above draw_grayscale method to render each character in the bitmap
                self.draw_grayscale(self.x + x, self.y + y, *col)
            }
        }

        // Increment by width of each character
        self.x += rendered.width();
    }

    pub fn move_down(&mut self, distance: usize) {
        self.y += distance;
    }

    pub fn home(&mut self) {
        self.x = 0;
    }

    pub fn enter(&mut self) {
        self.move_down(14);
        self.home();
    }

    pub fn page_up(&mut self) {
        self.y = 0;
    }

    pub fn clear(&mut self) {
        self.home();
        self.page_up();
        self.buffer.fill(0);
    }

    pub fn width(&self) -> usize {
        self.info.x
    }

    pub fn height(&self) -> usize {
        self.info.y
    }

    pub fn putch(&mut self, c: char) {
        match c {
            '\n' => self.enter(),
            '\r' => self.home(),
            c => {
                if self.x >= self.width() {
                    self.enter();
                }
                const LETTER_WIDTH: usize =
                    get_bitmap_width(FontWeight::Regular, BitmapHeight::Size14);

                if self.y >= (self.height() - LETTER_WIDTH) {
                    self.clear();
                }

                let mapped = get_bitmap(c, FontWeight::Regular, BitmapHeight::Size14).unwrap();
                self.render(mapped);
            }
        }
    }
}

unsafe impl Send for Printk {}
unsafe impl Sync for Printk {}

impl core::fmt::Write for Printk {
    fn write_str(&mut self, s: &str) -> core::fmt::Result {
        for c in s.chars() {
            self.putch(c)
        }
        Ok(())
    }
}

pub struct LockedPrintk(Spinlock<Printk>);

impl LockedPrintk {
    // Constructor
    #[allow(dead_code)]
    pub fn new(buf: &'static mut [u8], i: FramebufferInfo) -> Self {
        LockedPrintk(Spinlock::new(Printk::new(buf, i)))
    }

    #[allow(dead_code)]
    pub unsafe fn force_unlock(&self) {
        self.0.force_unlock()
    }
}

impl log::Log for LockedPrintk {
    fn enabled(&self, _metadata: &log::Metadata) -> bool {
        true
    }

    fn log(&self, record: &log::Record) {
        let mut printk = self.0.lock();
        writeln!(printk, "{}", record.args()).unwrap();
        printk.move_down(2);
    }

    fn flush(&self) {}
}

pub fn printk_init(table: &SystemTable<Boot>) -> (PhysAddr, Framebuffer) {
    let inner = table
        .boot_services()
        .locate_protocol::<GraphicsOutput>()
        .expect("No Graphics Output Protocol found");
    let gop = unsafe { &mut *inner.get() };

    // default to using the highest-resolution mode available
    let x = gop.modes().map(|x| x.info().resolution().0).max().unwrap();
    let y = gop.modes().map(|y| y.info().resolution().1).max().unwrap();

    let mode = gop
        .modes()
        .find(|m| m.info().resolution().0 == x && m.info().resolution().1 == y)
        .unwrap();
    gop.set_mode(&mode).unwrap();

    let mi = gop.current_mode_info();
    let mut fb = gop.frame_buffer();

    let slice = unsafe { core::slice::from_raw_parts_mut(fb.as_mut_ptr(), fb.size()) };
    let info = FramebufferInfo {
        byte_count: fb.size(),
        x: mi.resolution().0,
        y: mi.resolution().1,
        color: match mi.pixel_format() {
            PixelFormat::Rgb => ColorFormat::Rgb,
            PixelFormat::Bgr => ColorFormat::Bgr,
            PixelFormat::Bitmask | PixelFormat::BltOnly => panic!("Unsupported pixel format"),
        },
        bpp: 4,
        stride: mi.stride(),
    };

    let buffer_init = Framebuffer {
        begin: slice.as_ptr() as usize as u64,
        byte_count: fb.size(),
        info,
    };

    crate::printk_init(slice, info);

    (
        PhysAddr::new(fb.as_mut_ptr() as u64),
        buffer_init
    )
}
