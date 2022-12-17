// SPDX-License-Identifier: GPL-3.0-or-later

use alloc::vec::Vec;
use bootloader_api::info::{FrameBuffer, FrameBufferInfo};
use spin::RwLock;

use crate::FRAMEBUFFER_ADDR;

#[allow(dead_code)] // needed for later
pub static COMPOSITING_TABLE: RwLock<Vec<FrameBuffer>> = RwLock::new(Vec::new());

// Needed to allow rendering in multiple separate buffers — the very definition of compositing
pub fn clone_buffer(old: FrameBuffer) -> FrameBuffer {
    unsafe {
        FrameBuffer::new(FRAMEBUFFER_ADDR, old.info())
    }
}