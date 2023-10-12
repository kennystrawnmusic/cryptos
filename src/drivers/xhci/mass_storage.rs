use super::*;

use alloc::sync::Arc;
use spin::RwLock;

#[allow(dead_code)]  // not ready to use this yet
pub struct MassStorageDriver<const N: usize> {
    xhci: Arc<RwLock<XhciImpl>>,
    device: Arc<RwLock<Device<N>>>,
    slot_id: u8,
    endpoint: u8,
    max_packet_size: u16,
    max_lun: u8,
    block_size: u32,
    block_count: u32,
}