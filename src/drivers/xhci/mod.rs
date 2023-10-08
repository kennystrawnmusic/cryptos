use alloc::{collections::VecDeque, sync::Arc, vec::Vec};
use conquer_once::spin::OnceCell;
use core::{ptr::addr_of, sync::atomic::AtomicU64};
use x86_64::structures::paging::{Mapper, PageTableFlags, Size4KiB};

use crate::{
    cralloc::frames::XhciMapper,
    get_phys_offset, map_page,
    pci_impl::{
        register_device_driver, DeviceKind, FOSSPciDeviceHandle, PciDevice, Vendor, PCI_TABLE,
    },
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
use spin::{Once, RwLock};
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

                        // Align this properly
                        let full_bar = bar0 as u64
                            | ((bar1 as u64) << 32)
                                - ((bar0 as u64 | ((bar1 as u64) << 32))
                                    % (core::mem::size_of::<Registers<XhciMapper>>() as u64));

                        let regs =
                            unsafe { Registers::new(full_bar as usize + get_phys_offset() as usize, MAPPER.read().clone()) };

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
                    log::info!("Waiting for controller to be ready");
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

                op.usbcmd.update_volatile(|cmd| {
                    cmd.set_run_stop();
                    cmd.set_host_controller_reset();
                });
            })
            .expect("XHCI controller not found");
    }
}

pub(crate) static DRIVER: Once<Arc<XhciImpl>> = Once::new();

pub(crate) fn get_xhci<'a>() -> &'a Arc<XhciImpl> {
    DRIVER
        .get()
        .expect("Attempt to get XHCI controller before initializing it")
}

pub fn xhci_init() {
    DRIVER.call_once(|| {
        let guard = PCI_TABLE.read();
        let header = guard.headers.iter().find(|h| {
            matches!(
                (
                    Vendor::new(h.vendor_id as u32),
                    DeviceKind::new(h.vendor_id as u32, h.device_id as u32)
                ),
                (_, DeviceKind::UsbController)
            )
        });

        let out = header.map(|h| Arc::new(XhciImpl::new(h)));
        out.expect("XHCI device not in the table")
    });

    register_device_driver(get_xhci().clone());
}

impl FOSSPciDeviceHandle for XhciImpl {
    fn handles(&self, vendor_id: crate::pci_impl::Vendor, device_id: DeviceKind) -> bool {
        matches!((vendor_id, device_id), (_, DeviceKind::UsbController))
    }

    fn start(&self, header: &mut pcics::Header) {
        Self::new(&header).init();
    }
}
