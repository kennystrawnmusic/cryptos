use alloc::{boxed::Box, collections::VecDeque, sync::Arc, vec::Vec};
use bit_field::BitField;
use bitflags::bitflags;
use conquer_once::spin::OnceCell;
use core::{
    ptr::{addr_of, addr_of_mut},
    sync::atomic::AtomicU64,
};
use x86_64::{
    structures::paging::{FrameAllocator, Mapper, Page, PageTableFlags, Size4KiB},
    VirtAddr,
};

use crate::{
    cralloc::frames::XhciMapper,
    get_phys_offset, map_page,
    pci_impl::{
        register_device_driver, DeviceKind, FOSSPciDeviceHandle, PciDevice, Vendor, PCI_TABLE,
    },
    xhci::mass_storage::UsbDeviceKind,
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
    context::{Device, Slot},
    extended_capabilities::List,
    registers::{
        doorbell::Register, operational::PortStatusAndControlRegister, Capability,
        InterrupterRegisterSet, Operational, PortRegisterSet, Runtime,
    },
    ring::trb::{
        command::{
            AddressDevice, ConfigureEndpoint, DisableSlot, EnableSlot, EvaluateContext, ForceEvent,
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
        Link, Type as TrbType,
    },
    Registers,
};

pub mod mass_storage;

pub static ROOT_LINK: OnceCell<RwLock<Link>> = OnceCell::uninit();
pub(crate) static MAPPER: RwLock<XhciMapper> = RwLock::new(XhciMapper);

pub trait TrbAnalyzer: AsRef<[u32]> + TryFrom<[u32; 4]> {
    fn new(raw: [u32; 4]) -> Self
    where
        <Self as TryFrom<[u32; 4]>>::Error: core::fmt::Debug,
    {
        Self::try_from(raw).expect("Failed to convert raw TRB to TRB")
    }
    
    fn get_type(&self) -> TrbType {
        match self.as_ref()[3].get_bits(10..=15) {
            1 => TrbType::Normal,
            2 => TrbType::SetupStage,
            3 => TrbType::DataStage,
            4 => TrbType::StatusStage,
            5 => TrbType::Isoch,
            6 => TrbType::Link,
            7 => TrbType::EventData,
            8 => TrbType::NoopTransfer,
            9 => TrbType::EnableSlot,
            10 => TrbType::DisableSlot,
            11 => TrbType::AddressDevice,
            12 => TrbType::ConfigureEndpoint,
            13 => TrbType::EvaluateContext,
            14 => TrbType::ResetEndpoint,
            15 => TrbType::StopEndpoint,
            16 => TrbType::SetTrDequeuePointer,
            17 => TrbType::ResetDevice,
            18 => TrbType::ForceEvent,
            19 => TrbType::NegotiateBandwidth,
            20 => TrbType::SetLatencyToleranceValue,
            21 => TrbType::GetPortBandwidth,
            22 => TrbType::ForceHeader,
            23 => TrbType::NoopCommand,
            24 => TrbType::GetExtendedProperty,
            25 => TrbType::SetExtendedProperty,
            32 => TrbType::TransferEvent,
            33 => TrbType::CommandCompletion,
            34 => TrbType::PortStatusChange,
            35 => TrbType::BandwidthRequest,
            36 => TrbType::Doorbell,
            37 => TrbType::HostController,
            38 => TrbType::DeviceNotification,
            39 => TrbType::MfindexWrap,
            _ => unreachable!(),
        }
    }
}

impl TrbAnalyzer for AddressDevice {}
impl TrbAnalyzer for ConfigureEndpoint {}
impl TrbAnalyzer for DisableSlot {}
impl TrbAnalyzer for EnableSlot {}
impl TrbAnalyzer for EvaluateContext {}
impl TrbAnalyzer for ForceEvent {}
impl TrbAnalyzer for ForceHeader {}
impl TrbAnalyzer for GetExtendedProperty {}
impl TrbAnalyzer for GetPortBandwidth {}
impl TrbAnalyzer for NegotiateBandwidth {}
impl TrbAnalyzer for CmdNoop {}
impl TrbAnalyzer for ResetDevice {}
impl TrbAnalyzer for ResetEndpoint {}
impl TrbAnalyzer for SetExtendedProperty {}
impl TrbAnalyzer for SetLatencyToleranceValue {}
impl TrbAnalyzer for SetTrDequeuePointer {}
impl TrbAnalyzer for StopEndpoint {}

impl TrbAnalyzer for BandwidthRequest {}
impl TrbAnalyzer for CommandCompletion {}
impl TrbAnalyzer for DeviceNotification {}
impl TrbAnalyzer for Doorbell {}
impl TrbAnalyzer for HostController {}
impl TrbAnalyzer for MfindexWrap {}
impl TrbAnalyzer for PortStatusChange {}
impl TrbAnalyzer for TransferEvent {}

impl TrbAnalyzer for DataStage {}
impl TrbAnalyzer for EventData {}
impl TrbAnalyzer for Isoch {}
impl TrbAnalyzer for TransferNoop {}
impl TrbAnalyzer for Normal {}
impl TrbAnalyzer for SetupStage {}
impl TrbAnalyzer for StatusStage {}

pub trait TrbKindMarker {}

impl TrbKindMarker for CommandKind<'_> {}
impl TrbKindMarker for EventKind<'_> {}
impl TrbKindMarker for TransferKind<'_> {}
impl<'a> TrbKindMarker for &'a mut Link {}

pub enum CommandKind<'a> {
    AddressDevice(&'a mut AddressDevice),
    ConfigureEndpoint(&'a mut ConfigureEndpoint),
    DisableSlot(&'a mut DisableSlot),
    EnableSlot(&'a mut EnableSlot),
    EvaluateContext(&'a mut EvaluateContext),
    ForceEvent(&'a mut ForceEvent),
    ForceHeader(&'a mut ForceHeader),
    GetExtendedProperty(&'a mut GetExtendedProperty),
    GetPortBandwidth(&'a mut GetPortBandwidth),
    NegotiateBandwidth(&'a mut NegotiateBandwidth),
    CmdNoop(&'a mut CmdNoop),
    ResetDevice(&'a mut ResetDevice),
    ResetEndpoint(&'a mut ResetEndpoint),
    SetExtendedProperty(&'a mut SetExtendedProperty),
    SetLatencyToleranceValue(&'a mut SetLatencyToleranceValue),
    SetTrDequeuePointer(&'a mut SetTrDequeuePointer),
    StopEndpoint(&'a mut StopEndpoint),
}

pub enum EventKind<'a> {
    BandwidthRequest(&'a mut BandwidthRequest),
    CommandCompletion(&'a mut CommandCompletion),
    DeviceNotification(&'a mut DeviceNotification),
    Doorbell(&'a mut Doorbell),
    HostController(&'a mut HostController),
    MfindexWrap(&'a mut MfindexWrap),
    PortStatusChange(&'a mut PortStatusChange),
    TransferEvent(&'a mut TransferEvent),
}

pub enum TransferKind<'a> {
    DataStage(&'a mut DataStage),
    EventData(&'a mut EventData),
    Isoch(&'a mut Isoch),
    TransferNoop(&'a mut TransferNoop),
    Normal(&'a mut Normal),
    SetupStage(&'a mut SetupStage),
    StatusStage(&'a mut StatusStage),
}

pub enum TrbKind<'a> {
    Command(CommandKind<'a>),
    Event(EventKind<'a>),
    Transfer(TransferKind<'a>),
    Link(&'a mut Link),
}

pub struct Ring<'a>(VecDeque<&'a mut TrbKind<'a>>);

pub struct XhciImpl {
    regs: Option<Registers<XhciMapper>>,
    extcaps: Option<List<XhciMapper>>,
}

macro_rules! impl_from_ref_for_kind {
    ($sub:ident, $kind:ident) => {
        impl<'a> From<&'a mut $sub> for $kind<'a> {
            fn from(sub: &'a mut $sub) -> Self {
                $kind::$sub(sub)
            }
        }
    };
}

impl_from_ref_for_kind!(AddressDevice, CommandKind);
impl_from_ref_for_kind!(ConfigureEndpoint, CommandKind);
impl_from_ref_for_kind!(DisableSlot, CommandKind);
impl_from_ref_for_kind!(EnableSlot, CommandKind);
impl_from_ref_for_kind!(EvaluateContext, CommandKind);
impl_from_ref_for_kind!(ForceEvent, CommandKind);
impl_from_ref_for_kind!(ForceHeader, CommandKind);
impl_from_ref_for_kind!(GetExtendedProperty, CommandKind);
impl_from_ref_for_kind!(GetPortBandwidth, CommandKind);
impl_from_ref_for_kind!(NegotiateBandwidth, CommandKind);
impl_from_ref_for_kind!(CmdNoop, CommandKind);
impl_from_ref_for_kind!(ResetDevice, CommandKind);
impl_from_ref_for_kind!(ResetEndpoint, CommandKind);
impl_from_ref_for_kind!(SetExtendedProperty, CommandKind);
impl_from_ref_for_kind!(SetLatencyToleranceValue, CommandKind);
impl_from_ref_for_kind!(SetTrDequeuePointer, CommandKind);
impl_from_ref_for_kind!(StopEndpoint, CommandKind);

impl_from_ref_for_kind!(BandwidthRequest, EventKind);
impl_from_ref_for_kind!(CommandCompletion, EventKind);
impl_from_ref_for_kind!(DeviceNotification, EventKind);
impl_from_ref_for_kind!(Doorbell, EventKind);
impl_from_ref_for_kind!(HostController, EventKind);
impl_from_ref_for_kind!(MfindexWrap, EventKind);
impl_from_ref_for_kind!(PortStatusChange, EventKind);
impl_from_ref_for_kind!(TransferEvent, EventKind);

impl_from_ref_for_kind!(DataStage, TransferKind);
impl_from_ref_for_kind!(EventData, TransferKind);
impl_from_ref_for_kind!(Isoch, TransferKind);
impl_from_ref_for_kind!(TransferNoop, TransferKind);
impl_from_ref_for_kind!(Normal, TransferKind);
impl_from_ref_for_kind!(SetupStage, TransferKind);
impl_from_ref_for_kind!(StatusStage, TransferKind);

macro_rules! impl_from_kind_for_trb_kind {
    ($sub:ident, $kind:ident) => {
        impl<'a> From<$sub<'a>> for TrbKind<'a> {
            fn from(sub: $sub<'a>) -> Self {
                TrbKind::$kind(sub)
            }
        }
    };
}

impl_from_kind_for_trb_kind!(CommandKind, Command);
impl_from_kind_for_trb_kind!(EventKind, Event);
impl_from_kind_for_trb_kind!(TransferKind, Transfer);

impl<'a> From<&'a mut Link> for TrbKind<'a> {
    fn from(link: &'a mut Link) -> Self {
        TrbKind::Link(link)
    }
}

impl<'a> TrbKind<'a> {
    pub fn as_inner(&'a mut self) -> &'a mut dyn TrbKindMarker {
        match self {
            TrbKind::Command(cmd) => cmd,
            TrbKind::Event(event) => event,
            TrbKind::Transfer(transfer) => transfer,
            TrbKind::Link(link) => link,
        }
    }
}

pub fn addralloc<T>() -> *mut T {
    let frame = FRAME_ALLOCATOR
        .get()
        .expect("Frame allocator not initialized")
        .write()
        .allocate_frame()
        .expect("Failed to allocate frame for command ring");

    let page = Page::<Size4KiB>::containing_address(VirtAddr::new(
        frame.start_address().as_u64() + get_phys_offset(),
    ));

    map_page!(
        frame.start_address().as_u64(),
        page.start_address().as_u64(),
        Size4KiB,
        PageTableFlags::PRESENT
            | PageTableFlags::WRITABLE
            | PageTableFlags::NO_CACHE
            | PageTableFlags::WRITE_THROUGH
    );

    page.start_address().as_u64() as *mut T
}

impl XhciImpl {
    pub fn new(header: &Header) -> Self {
        let offset_full_bar_outer = OnceCell::<usize>::uninit();
        let regs = {
            if let DeviceKind::UsbController =
                DeviceKind::new(header.class_code.base as u32, header.class_code.sub as u32)
            {
                if let HeaderType::Normal(header) = header.header_type.clone() {
                    let bar0 = header.base_addresses.orig()[0];
                    let bar1 = header.base_addresses.orig()[1];

                    // Align this properly
                    let full_bar = bar0 as u64 | ((bar1 as u64) << 32);

                    let offset_full_bar = {
                        let test =
                            Page::<Size4KiB>::containing_address(VirtAddr::new(full_bar as u64));
                        test.start_address().as_u64()
                    } as usize;
                    offset_full_bar_outer.get_or_init(move || offset_full_bar);

                    let regs = unsafe {
                        Registers::new(
                            offset_full_bar_outer.get().cloned().unwrap(),
                            MAPPER.read().clone(),
                        )
                    };
                    Some(regs)
                } else {
                    None
                }
            } else {
                None
            }
        };

        let extcaps = regs
            .as_ref()
            .map(|regs| {
                let extended_caps = unsafe {
                    List::new(
                        offset_full_bar_outer.get().cloned().unwrap(),
                        regs.capability.hccparams1.read_volatile(),
                        MAPPER.read().clone(),
                    )
                };
                extended_caps.map(|caps| caps)
            })
            .flatten();

        Self { regs, extcaps }
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
    pub fn extcaps(&self) -> Option<&List<XhciMapper>> {
        self.extcaps.as_ref().map(|caps| caps)
    }
    pub fn extcaps_mut(&mut self) -> Option<&mut List<XhciMapper>> {
        self.extcaps.as_mut().map(|caps| caps)
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
            let max_interrupts = self
                .capabilities()
                .map(|cap| cap.hcsparams1.read_volatile().number_of_interrupts())
                .expect("No interrupt vectors available");
            let config_info = self.capabilities().map(|cap| {
                cap.hccparams2
                    .read_volatile()
                    .configuration_information_capability()
            });

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

            // Enumerate runtime registers
            if let Some(rt) = self.runtime_mut() {
                log::info!(
                    "Microframe index: {:#?}",
                    rt.mfindex.read_volatile().microframe_index()
                );
            }

            // Create command ring with (4096 / 16) entries
            // All TRBs are arrays of [u32; 4] at their core
            let entries_per_page =
                Page::<Size4KiB>::SIZE as usize / core::mem::size_of::<CommandKind<'_>>();
            let cmd_ring = unsafe {
                core::slice::from_raw_parts_mut::<'static>(
                    addralloc::<CommandKind<'_>>(),
                    entries_per_page,
                )
            };

            // Use max_slots and core::slice::from_raw_parts_mut to create a slot context array
            let dev_context_array = unsafe {
                core::slice::from_raw_parts_mut::<'static>(
                    addralloc::<Device<16>>(),
                    max_slots.unwrap() as usize,
                )
            };

            // Set the DCBAAP
            self.operational_mut().map(|op| {
                op.dcbaap.update_volatile(|dcbaap| {
                    dcbaap.set(
                        dev_context_array
                            .iter()
                            .nth(0)
                            .map(|dev| dev as *const _ as u64)
                            .expect("No devices present in device context array"),
                    )
                })
            });

            // Set the command ring control register
            self.operational_mut().map(|op| {
                op.crcr.update_volatile(|crcr| {
                    crcr.set_command_ring_pointer(
                        cmd_ring
                            .iter()
                            .nth(0)
                            .map(|cmd| cmd as *const _ as u64)
                            .expect("No commands present in command ring"),
                    )
                })
            });

            // Set event ring segment table registers
            self.interrupter_register_set_mut().map(|int| {
                for i in 0..(max_interrupts as usize) {
                    // Set table size
                    int.interrupter_mut(i).erstsz.update_volatile(|erstsz| {
                        erstsz.set(unsafe { *(addralloc::<u16>()) });
                    });

                    // Set the event ring dequeue pointer
                    int.interrupter_mut(i).erdp.update_volatile(|erdp| {
                        let event_ring_dequeue = unsafe {
                            core::slice::from_raw_parts_mut::<'static>(
                                addralloc::<EventKind<'_>>(),
                                4096 / core::mem::size_of::<EventKind<'_>>(),
                            )
                        };

                        erdp.set_event_ring_dequeue_pointer(
                            event_ring_dequeue
                                .iter()
                                .nth(0)
                                .map(|event| event as *const _ as u64)
                                .expect("No commands present in command ring"),
                        )
                    });

                    // Set the event ring segment table base address
                    int.interrupter_mut(i)
                        .erstba
                        .update_volatile(|erstba| erstba.set(unsafe { *(addralloc::<u64>()) }));

                    // Set the interrupter moderation register
                    int.interrupter_mut(i).imod.update_volatile(|imod| {
                        imod.set_interrupt_moderation_interval(0);
                        imod.set_interrupt_moderation_counter(0);
                    });

                    // Set the interrupter management register
                    int.interrupter_mut(i).iman.update_volatile(|iman| {
                        iman.set_0_interrupt_pending();
                        iman.set_interrupt_enable();
                    });
                }
            });

            // Enable interrupts
            self.operational_mut().map(|op| {
                op.usbcmd.update_volatile(|cmd| {
                    cmd.set_interrupter_enable();
                })
            });

            // Set up the scratchpad buffers
            let scratchpad_buf = self
                .capabilities_mut()
                .map(|cap| {
                    let max_scratchpads =
                        if cap.hcsparams2.read_volatile().max_scratchpad_buffers() == 0 {
                            cap.hcsparams2.read_volatile().max_scratchpad_buffers() + 1
                        } else {
                            cap.hcsparams2.read_volatile().max_scratchpad_buffers()
                        };

                    unsafe {
                        core::slice::from_raw_parts_mut::<'static>(
                            addralloc::<ScratchpadEntry>(),
                            max_scratchpads as usize,
                        )
                    }
                })
                .expect("No scratchpad buffer array present");

            // Set the scratchpad buffer array address by updating the device context array
            dev_context_array[0] =
                unsafe { *(addr_of!(scratchpad_buf[0]) as u64 as *mut Device<16>) };

            // Note: because the DCBAAP is a pointer to the above, overwriting it automatically overwrites
            // what the DCBAAP points to, so no need to update the DCBAAP again

            // Start the host controller
            self.operational_mut().map(|op| {
                op.usbcmd.update_volatile(|cmd| {
                    cmd.set_run_stop();
                });

                // Wait until controller is running
                while op.usbsts.read_volatile().hc_halted() {
                    core::hint::spin_loop();
                }
            });

            // Ring doorbell
            let doorbell = self.doorbell_mut().expect("No doorbell register present");
            doorbell.update_volatile_at(0, |db| {
                db.set_doorbell_target(0);
            });

            log::info!("Successfully initialized XHCI controller");

            // Enable config info if config info capability is present
            if let Some(config_info) = config_info {
                if config_info {
                    self.operational_mut().map(|op| {
                        op.config.update_volatile(|config| {
                            config.set_configuration_information_enable();
                        })
                    });
                }
            }

            // Reset ports
            self.port_register_set_mut().map(|prs| {
                for (i, mut port) in prs.into_iter().enumerate() {
                    log::info!("Resetting port {}", i);
                    if port.portsc.port_enabled_disabled() {
                        port.portsc.set_port_reset();
                        while port.portsc.port_reset() {
                            core::hint::spin_loop();
                        }
                        // TODO: timeout
                    }
                }
            });

            self.probe::<16>();
        }
    }

    pub fn probe<const N: usize>(&mut self) -> Option<UsbDeviceKind> {
        if let Some(prs) = self.port_register_set() {
            for (i, mut port) in prs.into_iter().enumerate() {
                if port.portsc.port_power() {
                    log::info!("Probing port {}", i);
                    port.portsc.set_0_port_enabled_disabled();
                    while port.portsc.port_enabled_disabled() {
                        core::hint::spin_loop();
                    }
                    if port.portsc.current_connect_status() {
                        log::info!("Device connected to port {}", i);
                        return Some(UsbDeviceKind::from(N));
                    }
                }
            }
        }
        None
    }
}

#[repr(packed)]
pub struct ScratchpadEntry {
    pub addr_low: u32,
    pub addr_high: u32,
}

impl ScratchpadEntry {
    pub fn set_addr(&mut self, addr: u64) {
        self.addr_low = addr as u32;
        self.addr_high = (addr >> 32) as u32;
    }
}

pub(crate) static DRIVER: Once<Arc<XhciProtected>> = Once::new();

pub(crate) fn get_xhci<'a>() -> &'a Arc<XhciProtected> {
    DRIVER
        .get()
        .expect("Attempt to get XHCI controller before initializing it")
}

pub struct XhciProtected {
    inner: RwLock<XhciImpl>,
}

impl XhciProtected {
    pub fn new(header: &Header) -> Self {
        Self {
            inner: RwLock::new(XhciImpl::new(header)),
        }
    }
}

pub fn xhci_init() {
    DRIVER.call_once(|| {
        let guard = PCI_TABLE.read();
        let header = guard.headers.iter().find(|h| {
            matches!(
                DeviceKind::new(h.class_code.base as u32, h.class_code.sub as u32),
                DeviceKind::UsbController
            )
        });

        let out = header.map(|h| Arc::new(XhciProtected::new(h)));
        out.expect("XHCI device not in the table")
    });

    register_device_driver(get_xhci().clone());
}

impl FOSSPciDeviceHandle for XhciProtected {
    fn handles(&self, _: crate::pci_impl::Vendor, device_id: DeviceKind) -> bool {
        matches!(device_id, DeviceKind::UsbController)
    }

    fn start(&self, _: &mut pcics::Header) {
        self.inner.write().init();
    }
}
