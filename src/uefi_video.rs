#![allow(unused_must_use)]

use conquer_once::spin::OnceCell;
use core::fmt::Write;
use noto_sans_mono_bitmap::{get_bitmap, get_bitmap_width, BitmapChar, BitmapHeight, FontWeight};
use spin::Mutex;
use spinning_top::{lock_api::RawMutex, Spinlock};
use uefi::{
    proto::console::gop::{GraphicsOutput, ModeInfo, PixelFormat},
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
#[non_exhaustive]
pub struct Framebuffer {
    pub first_byte: u64,
    pub byte_count: usize,
    pub info: FramebufferInfo,
}

impl Framebuffer {
    unsafe fn as_slice<'a>(&self) -> &'static mut [u8] {
        core::slice::from_raw_parts_mut(self.first_byte as *mut u8, self.byte_count)
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
    info: ModeInfo,
    x: usize,
    y: usize,
}

impl Printk {
    #[allow(dead_code)]
    pub fn new(buffer: &'static mut [u8], info: ModeInfo) -> Self {
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
        let poff = y * self.info.stride() + x;

        let color = match self.info.pixel_format() {
            PixelFormat::Rgb => [intensity, intensity, intensity / 2, 0],

            PixelFormat::Bgr => [intensity / 2, intensity, intensity, 0],

            PixelFormat::Bitmask | PixelFormat::BltOnly => panic!("Unknown pixel format"),
        };

        // Bytes per pixel is always 4 in UEFI
        let bpp = 4;

        // Byte offset: multiply bytes-per-pixel by pixel offset to obtain
        let boff = poff * bpp;

        // Copy bytes
        self.buffer[boff..(boff + bpp)].copy_from_slice(&color[..bpp]);

        // Raw pointer to buffer index ― that's why this is unsafe
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
        self.info.resolution().0
    }

    pub fn height(&self) -> usize {
        self.info.resolution().1
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
    pub fn new(buf: &'static mut [u8], i: ModeInfo) -> Self {
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

pub fn printk_init(table: &mut SystemTable<Boot>) -> (PhysAddr, FramebufferInfo) {
    // borrow checker throws a fit here if I don't do this
    let clone = unsafe { table.unsafe_clone() };

    let stdout = table.stdout();
    // Clear stdout immediately
    let _ = stdout.clear().unwrap_or_else(|e| {
        writeln!(stdout, "Error attempting to clear the UEFI standard output: {:#?}", e);
        loop {}
    });

    let inner = unsafe {
        clone
            .boot_services()
            .locate_protocol::<GraphicsOutput>()
            .expect("No Graphics Output Protocol found")
    };
    let gop = unsafe { &mut *inner.get() };

    // default to using the highest-resolution mode available
    let x = gop.modes().map(|x| x.info().resolution().0).max().unwrap_or_else(|| {
        writeln!(stdout, "Failed to get highest available horizontal resolution");
        loop {}
    });

    let y = gop.modes().map(|y| y.info().resolution().1).max().unwrap_or_else(|| {
        writeln!(stdout, "Failed to get highest available horizontal resolution");
        loop {}
    });

    let mode = gop
        .modes()
        .find(|m| m.info().resolution().0 == x && m.info().resolution().1 == y)
        .unwrap_or_else(|| {
            writeln!(stdout, "Failed to find display mode");
            loop {}
        });

    
    gop.set_mode(&mode).unwrap_or_else(|e| {
        writeln!(stdout, "Error attempting to set display mode: {:#?}", e);
        loop {}
    });

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
            PixelFormat::Bitmask | PixelFormat::BltOnly => {
                writeln!(stdout, "Unsupported pixel format");
                loop {}
            },
        },
        bpp: 4,
        stride: mi.stride(),
    };

    crate::printk_init(slice, mi);

    (PhysAddr::new(fb.as_mut_ptr() as u64), info)
}
