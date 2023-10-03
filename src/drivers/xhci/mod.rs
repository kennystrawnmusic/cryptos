use crate::{cralloc::frames::XhciMapper, pci_impl::{DeviceKind, FOSSPciDeviceHandle}, FRAME_ALLOCATOR};
use pcics::{header::HeaderType, Header};
use spin::RwLock;
use xhci::Registers;

#[allow(dead_code)] // not finished
pub(crate) static MAPPER: RwLock<XhciMapper> = RwLock::new(XhciMapper);

#[allow(dead_code)] // not finished
pub(crate) struct XhciImpl {
    pub(crate) regs: Option<Registers<XhciMapper>>,
}

#[allow(dead_code)] // not finished
impl XhciImpl {
    pub(crate) fn new(header: &Header) -> Self {
        Self {
            regs: {
                if let DeviceKind::UsbController =
                    DeviceKind::new(header.class_code.base as u32, header.class_code.sub as u32)
                {
                    if let HeaderType::Normal(header) = header.header_type.clone() {
                        let bar0 = header.base_addresses.orig()[0];
                        let bar1 = header.base_addresses.orig()[1];

                        let full_bar = bar0 as u64 | ((bar1 as u64) << 32);

                        let regs = unsafe { Registers::new(full_bar as usize, MAPPER.write().clone()) };

                        Some(regs)
                    } else {
                        None
                    }
                } else {
                    None
                }
            }
        }
    }
}

impl FOSSPciDeviceHandle for XhciImpl {
    fn handles(&self, vendor_id: crate::pci_impl::Vendor, device_id: DeviceKind) -> bool {
        matches!(
            (vendor_id, device_id),
            (crate::pci_impl::Vendor::Intel, DeviceKind::UsbController)
        )
    }

    fn start(&self, header: &mut pcics::Header) {
        todo!("use this to actually configure the space by parsing {:#?}", header);
    }
}