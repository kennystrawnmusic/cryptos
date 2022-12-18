// SPDX-License-Identifier: GPL-3.0-or-later

use alloc::vec::Vec;
use bootloader_api::info::{FrameBuffer, FrameBufferInfo};
use core::iter::zip;
use embedded_graphics_core::geometry::Point;
use spin::RwLock;

use crate::FRAMEBUFFER_ADDR;

#[allow(dead_code)] // needed for later
pub static COMPOSITING_TABLE: RwLock<Vec<FrameBuffer>> = RwLock::new(Vec::new());

// Needed to allow rendering in multiple separate buffers — the very definition of compositing
pub fn clone_buffer(old: FrameBuffer) -> FrameBuffer {
    unsafe { FrameBuffer::new(FRAMEBUFFER_ADDR, old.info()) }
}

pub fn buffer_points(buffer: FrameBuffer) -> impl Iterator<Item = Point> {
    (0..buffer.info().width)
        .flat_map(move |x| (0..buffer.info().height).map(move |y| Point::new(x as i32, y as i32)))
}

// future-proof
#[allow(unused_variables)]
#[allow(unused_mut)]
pub fn render_points(points: impl Iterator<Item = Point>, mut buffer: FrameBuffer) {
    todo!()
}
