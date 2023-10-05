use alloc::{collections::VecDeque, vec::Vec};
use conquer_once::spin::OnceCell;
use core::{ptr::addr_of, sync::atomic::AtomicU64};
use x86_64::structures::paging::{Mapper, PageTableFlags, Size4KiB};

use crate::{
    cralloc::frames::XhciMapper,
    get_phys_offset, map_page,
    pci_impl::{DeviceKind, FOSSPciDeviceHandle, PCI_TABLE},
    FRAME_ALLOCATOR,
};
use pcics::{
    capabilities::{
        msi_x::Table,
        msi_x::{Bir, MessageControl},
        CapabilityKind, MsiX,
    },
    header::HeaderType,
    Capabilities, Header,
};
use spin::RwLock;
use xhci::{
    accessor::array::ReadWrite,
    context::Slot,
    registers::{
        doorbell::Register, Capability, InterrupterRegisterSet, Operational, PortRegisterSet,
        Runtime,
    },
    ring::trb::Link,
    Registers,
};

pub static ROOT_LINK: OnceCell<RwLock<Link>> = OnceCell::uninit();
pub(crate) static MAPPER: RwLock<XhciMapper> = RwLock::new(XhciMapper);

pub struct XhciImpl {
    regs: Option<Registers<XhciMapper>>,
}

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
    pub fn init(&mut self) {
        self.operational_mut()
            .map(|op| {
                while op.usbsts.read_volatile().controller_not_ready() {
                    core::hint::spin_loop();
                }

                op.config.update_volatile(|config| {
                    config.set_max_device_slots_enabled(255);
                });

                op.dcbaap.update_volatile(|dcbaap| {
                    dcbaap.set(dcbaap.get() + get_phys_offset());
                });

                op.crcr.update_volatile(|crcr| {
                    // First we actually need a TRB to place at the address we're telling the registers to access
                    let l = Link::new();
                    ROOT_LINK.get_or_init(move || RwLock::new(l));

                    let phys = addr_of!(*ROOT_LINK.get().unwrap().read()) as u64;

                    let virt = phys - (phys % (64 * 8)) + get_phys_offset();
                    crcr.set_command_ring_pointer(virt);
                });

                let pci_guard = PCI_TABLE.write();

                // borrow checker
                let headers_vec = pci_guard.headers.clone();
                let raw_headers_vec = pci_guard.raw_headers.clone();

                let headers_iter = headers_vec.iter().cloned();
                let raw_headers_iter = raw_headers_vec.iter().cloned();

                // Don't hold onto the lock for too long
                drop(pci_guard);

                let (raw, header) = raw_headers_iter
                    .zip(headers_iter)
                    .find_map(|(raw, header)| {
                        if let DeviceKind::UsbController = DeviceKind::new(
                            header.class_code.base as u32,
                            header.class_code.sub as u32,
                        ) {
                            Some((raw, header))
                        } else {
                            None
                        }
                    })
                    .expect("Controller not found");

                let mut caps = Capabilities::new(&raw, &header).filter_map(|cap| cap.ok());
                let msix = caps.find(|cap| matches!(cap.kind, CapabilityKind::MsiX(_)));

                if let Some(msix) = msix {
                    log::info!("Found MSI-X capability: {:#?}", msix.kind);
                }

                op.usbcmd.update_volatile(|cmd| {
                    cmd.set_run_stop();
                    cmd.set_host_controller_reset();
                });
            })
            .expect("XHCI controller not found");
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
