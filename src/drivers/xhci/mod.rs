use crate::{
    cralloc::frames::XhciMapper,
    pci_impl::{DeviceKind, FOSSPciDeviceHandle},
    FRAME_ALLOCATOR,
};
use pcics::{header::HeaderType, Header};
use spin::RwLock;
use xhci::{
    accessor::array::ReadWrite,
    registers::{
        doorbell::Register, Capability, InterrupterRegisterSet, Operational, PortRegisterSet,
        Runtime,
    },
    Registers,
};

#[allow(dead_code)] // not finished
pub(crate) static MAPPER: RwLock<XhciMapper> = RwLock::new(XhciMapper);

#[allow(dead_code)] // not finished
pub struct XhciImpl {
    regs: Option<Registers<XhciMapper>>,
}

#[allow(dead_code)] // not finished
impl XhciImpl {
    pub fn new(header: &Header) -> Self {
        Self {
            regs: {
                if let DeviceKind::UsbController =
                    DeviceKind::new(header.class_code.base as u32, header.class_code.sub as u32)
                {
                    if let HeaderType::Normal(header) = header.header_type.clone() {
                        let bar0 = header.base_addresses.orig()[0];
                        let bar1 = header.base_addresses.orig()[1];

                        let full_bar = bar0 as u64 | ((bar1 as u64) << 32);

                        let regs =
                            unsafe { Registers::new(full_bar as usize, MAPPER.read().clone()) };

                        Some(regs)
                    } else {
                        None
                    }
                } else {
                    None
                }
            },
        }
    }
    pub fn capabilities_mut(&mut self) -> Option<&mut Capability<XhciMapper>> {
        self.regs.as_mut().map(|regs| &mut regs.capability)
    }
    pub fn doorbell_mut(&mut self) -> Option<&mut ReadWrite<Register, XhciMapper>> {
        self.regs.as_mut().map(|regs| &mut regs.doorbell)
    }
    pub fn operational_mut(&mut self) -> Option<&mut Operational<XhciMapper>> {
        self.regs.as_mut().map(|regs| &mut regs.operational)
    }
    pub fn port_register_set_mut(&mut self) -> Option<&mut ReadWrite<PortRegisterSet, XhciMapper>> {
        self.regs.as_mut().map(|regs| &mut regs.port_register_set)
    }
    pub fn runtime_mut(&mut self) -> Option<&mut Runtime<XhciMapper>> {
        self.regs.as_mut().map(|regs| &mut regs.runtime)
    }
    pub fn interrupter_register_set_mut(
        &mut self,
    ) -> Option<&mut InterrupterRegisterSet<XhciMapper>> {
        self.regs
            .as_mut()
            .map(|regs| &mut regs.interrupter_register_set)
    }
    pub fn capabilities(&self) -> Option<&Capability<XhciMapper>> {
        self.regs.as_ref().map(|regs| &regs.capability)
    }
    pub fn doorbell(&self) -> Option<&ReadWrite<Register, XhciMapper>> {
        self.regs.as_ref().map(|regs| &regs.doorbell)
    }
    pub fn operational(&self) -> Option<&Operational<XhciMapper>> {
        self.regs.as_ref().map(|regs| &regs.operational)
    }
    pub fn port_register_set(&self) -> Option<&ReadWrite<PortRegisterSet, XhciMapper>> {
        self.regs.as_ref().map(|regs| &regs.port_register_set)
    }
    pub fn runtime(&self) -> Option<&Runtime<XhciMapper>> {
        self.regs.as_ref().map(|regs| &regs.runtime)
    }
    pub fn interrupter_register_set(&self) -> Option<&InterrupterRegisterSet<XhciMapper>> {
        self.regs
            .as_ref()
            .map(|regs| &regs.interrupter_register_set)
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
        todo!(
            "use this to actually configure the space by parsing {:#?}",
            header
        );
    }
}
