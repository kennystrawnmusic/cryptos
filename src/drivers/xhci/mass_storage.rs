use super::*;

use alloc::sync::Arc;
use spin::RwLock;
use xhci::context::{DeviceHandler, EndpointHandler, SlotHandler};

/// Wrapper for handling both 32 and 64-byte device cases
#[allow(clippy::large_enum_variant)]
pub enum UsbDeviceKind {
    Device8(Device<8>),
    Device16(Device<16>),
}

impl UsbDeviceKind {
    pub fn slot(&self) -> &dyn SlotHandler {
        match self {
            Self::Device8(device) => device.slot(),
            Self::Device16(device) => device.slot(),
        }
    }

    pub fn slot_mut(&mut self) -> &mut dyn SlotHandler {
        match self {
            Self::Device8(device) => device.slot_mut(),
            Self::Device16(device) => device.slot_mut(),
        }
    }

    pub fn endpoint(&self, index: usize) -> &dyn EndpointHandler {
        match self {
            Self::Device8(device) => device.endpoint(index),
            Self::Device16(device) => device.endpoint(index),
        }
    }

    pub fn endpoint_mut(&mut self, index: usize) -> &mut dyn EndpointHandler {
        match self {
            Self::Device8(device) => device.endpoint_mut(index),
            Self::Device16(device) => device.endpoint_mut(index),
        }
    }
}

impl From<usize> for UsbDeviceKind {
    fn from(size: usize) -> Self {
        match size {
            8 => Self::Device8(Device::new_32byte()),
            16 => Self::Device16(Device::new_64byte()),
            _ => panic!("Unsupported device size"),
        }
    }
}

#[allow(dead_code)] // not ready to use this yet
pub struct MassStorageDriver<'a, const N: usize> {
    xhci: Arc<RwLock<&'a mut XhciImpl>>,
    device: Arc<RwLock<UsbDeviceKind>>,
    slot_id: u8,
    max_packet_size: u16,
}

impl<'a, const N: usize> MassStorageDriver<'a, N> {
    pub fn new(xhci: &'a mut XhciImpl, endpoint: usize) -> Self {
        let slot_id = UsbDeviceKind::from(N).slot().usb_device_address();
        let max_packet_size = UsbDeviceKind::from(N).endpoint(endpoint).max_packet_size();

        Self {
            xhci: Arc::new(RwLock::new(xhci)),
            device: Arc::new(RwLock::new(UsbDeviceKind::from(N))),
            slot_id,
            max_packet_size,
        }
    }
}
