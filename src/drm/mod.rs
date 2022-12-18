// SPDX-License-Identifier: GPL-3.0-or-later

use alloc::vec::Vec;
use bootloader_api::info::{FrameBuffer, FrameBufferInfo};
use embedded_graphics_core::geometry::Point;
use spin::RwLock;
use core::iter::zip;

use crate::FRAMEBUFFER_ADDR;

#[allow(dead_code)] // needed for later
pub static COMPOSITING_TABLE: RwLock<Vec<FrameBuffer>> = RwLock::new(Vec::new());

// Needed to allow rendering in multiple separate buffers — the very definition of compositing
pub fn clone_buffer(old: FrameBuffer) -> FrameBuffer {
    unsafe { FrameBuffer::new(FRAMEBUFFER_ADDR, old.info()) }
}

pub fn buffer_points(buffer: FrameBuffer) -> impl Iterator<Item = Point> {
    (0..buffer.info().width).for_each(|x| {
        (0..buffer.info().height).map(|y| Point::new(x as i32, y as i32))
    })
}
