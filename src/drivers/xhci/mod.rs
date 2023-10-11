use alloc::{collections::VecDeque, sync::Arc, vec::Vec};
use conquer_once::spin::OnceCell;
use core::{
    ptr::{addr_of, addr_of_mut},
    sync::atomic::AtomicU64,
};
use x86_64::{
    structures::paging::{Mapper, Page, PageTableFlags, Size4KiB},
    VirtAddr,
};

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
    Capabilities, Header, ECS_OFFSET,
};
use spin::{Once, RwLock};
use xhci::{
    accessor::array::ReadWrite,
    context::Slot,
    registers::{
        doorbell::Register, Capability, InterrupterRegisterSet, Operational, PortRegisterSet,
        Runtime,
    },
    ring::trb::{
        command::{
            AddressDevice, ConfigureEndpoint, DisableSlot, EvaluateContext, ForceEvent,
            ForceHeader, GetExtendedProperty, GetPortBandwidth, NegotiateBandwidth,
            Noop as CmdNoop, ResetDevice, ResetEndpoint, SetExtendedProperty,
            SetLatencyToleranceValue, SetTrDequeuePointer, StopEndpoint,
        },
        event::{
            BandwidthRequest, CommandCompletion, DeviceNotification, Doorbell, HostController,
            MfindexWrap, PortStatusChange, TransferEvent,
        },
        transfer::{
            DataStage, EventData, Isoch, Noop as TransferNoop, Normal, SetupStage, StatusStage,
        },
        Link,
    },
    Registers,
};

pub static ROOT_LINK: OnceCell<RwLock<Link>> = OnceCell::uninit();
pub(crate) static MAPPER: RwLock<XhciMapper> = RwLock::new(XhciMapper);

pub enum CommandKind {
    AddressDevice(AddressDevice),
    ConfigureEndpoint(ConfigureEndpoint),
    DisableSlot(DisableSlot),
    EvaluateContext(EvaluateContext),
    ForceEvent(ForceEvent),
    ForceHeader(ForceHeader),
    GetExtendedProperty(GetExtendedProperty),
    GetPortBandwidth(GetPortBandwidth),
    NegotiateBandwidth(NegotiateBandwidth),
    NoOp(CmdNoop),
    ResetDevice(ResetDevice),
    ResetEndpoint(ResetEndpoint),
    SetExtendedProperty(SetExtendedProperty),
    SetLatencyToleranceValue(SetLatencyToleranceValue),
    SetTrDequeuePointer(SetTrDequeuePointer),
    StopEndpoint(StopEndpoint),
}

pub enum EventKind {
    BandwidthRequest(BandwidthRequest),
    CommandCompletion(CommandCompletion),
    DeviceNotification(DeviceNotification),
    Doorbell(Doorbell),
    HostController(HostController),
    MfIndexWrap(MfindexWrap),
    PortStatusChange(PortStatusChange),
    Transfer(TransferEvent),
}

pub enum TransferKind {
    DataStage(DataStage),
    EventData(EventData),
    Isoch(Isoch),
    Noop(TransferNoop),
    Normal(Normal),
    SetupStage(SetupStage),
    StatusStage(StatusStage),
}

pub enum TrbKind {
    Command(CommandKind),
    Event(EventKind),
    Transfer(TransferKind),
    Link(Link),
}

pub struct Ring<'a>(VecDeque<&'a mut TrbKind>);

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
                        let full_bar = bar0 as u64 | ((bar1 as u64) << 32);

                        let offset_full_bar = {
                            let test = Page::<Size4KiB>::containing_address(VirtAddr::new(
                                full_bar as u64,
                            ));
                            test.start_address().as_u64()
                        } as usize;

                        let regs =
                            unsafe { Registers::new(offset_full_bar, MAPPER.read().clone()) };
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
        if let Some(op) = self.operational_mut() {
            log::info!("XHCI: Waiting for controller");
            while op.usbsts.read_volatile().controller_not_ready() {
                core::hint::spin_loop();
            }

            // Stop the host controller
            op.usbcmd.update_volatile(|cmd| {
                cmd.clear_run_stop();
            });

            // Wait for the host controller to stop
            log::info!("XHCI: Stopping controller");
            while op.usbcmd.read_volatile().run_stop() {
                core::hint::spin_loop();
            }

            // Reset the host controller
            op.usbcmd.update_volatile(|cmd| {
                cmd.set_host_controller_reset();
            });

            let max_slots = self
                .capabilities()
                .map(|cap| cap.hcsparams1.read_volatile().number_of_device_slots());
            let max_ports = self
                .capabilities()
                .map(|cap| cap.hcsparams1.read_volatile().number_of_ports());

            // Read the max number of slots from the capabilities and write that value into the operational register
            if let Some(slots) = max_slots {
                self.operational_mut().map(|op| {
                    op.config.update_volatile(|config| {
                        config.set_max_device_slots_enabled(slots);
                    })
                });
            }

            // Same with ports
            if let Some(ports) = max_ports {
                self.port_register_set_mut().map(|prs| {
                    for i in 0..ports {
                        prs.update_volatile_at(i as usize, |port| {
                            port.portsc.set_port_power();
                            port.portpmsc.clear_hardware_lpm_enable();
                        })
                    }
                });
            }

            // Enumerate doorbells
            if let Some(db) = self.doorbell_mut() {
                for i in 0..db.len() {
                    log::debug!("Doorbell register {}: {:#?}", i, db.read_volatile_at(i));
                }
            }
        }
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
