use crate::{cralloc::frames::XhciMapper, pci_impl::DeviceKind, FRAME_ALLOCATOR};
use alloc::boxed::Box;
use pcics::{header::HeaderType, Header};
use xhci::{registers::Operational, Registers};

pub fn xhci_init(header: &Header, mapper: XhciMapper) -> Option<Registers<XhciMapper>> {
    if let DeviceKind::UsbController =
        DeviceKind::new(header.class_code.base as u32, header.class_code.sub as u32)
    {
        if let HeaderType::Normal(header) = header.header_type.clone() {
            let bar0 = header.base_addresses.orig()[0];
            let bar1 = header.base_addresses.orig()[1];

            let full_bar = bar0 as u64 | ((bar1 as u64) << 32);

            let regs = unsafe { Registers::new(full_bar as usize, mapper) };

            Some(regs)
        } else {
            None
        }
    } else {
        None
    }
}
