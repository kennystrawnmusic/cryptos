// SPDX-License-Identifier: GPL-3.0-or-later
use alloc::sync::Arc;
use bit_field::BitField;
use conquer_once::spin::OnceCell;
use core::ptr::addr_of;
use x86_64::{
    structures::paging::{Page, Size4KiB},
    VirtAddr,
};

use crate::{
    common::addralloc,
    common::XhciMapper,
    pci_impl::{register_device_driver, DeviceKind, FOSSPciDeviceHandle, PCI_TABLE},
    xhci::mass_storage::UsbDeviceKind,
};
use pcics::{header::HeaderType, Header};
use spin::{Once, RwLock};
use xhci::{
    accessor::array::ReadWrite,
    context::Device,
    extended_capabilities::List,
    registers::{
        doorbell::Register, Capability, InterrupterRegisterSet, Operational, PortRegisterSet,
        Runtime,
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

/// Helper trait for parsing the specific TRBs we're dealing with
trait TrbAnalyzer: AsRef<[u32]> {
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

impl TrbAnalyzer for Link {}

impl<'a> TrbAnalyzer for &'a mut AddressDevice {}
impl<'a> TrbAnalyzer for &'a mut ConfigureEndpoint {}
impl<'a> TrbAnalyzer for &'a mut DisableSlot {}
impl<'a> TrbAnalyzer for &'a mut EnableSlot {}
impl<'a> TrbAnalyzer for &'a mut EvaluateContext {}
impl<'a> TrbAnalyzer for &'a mut ForceEvent {}
impl<'a> TrbAnalyzer for &'a mut ForceHeader {}
impl<'a> TrbAnalyzer for &'a mut GetExtendedProperty {}
impl<'a> TrbAnalyzer for &'a mut GetPortBandwidth {}
impl<'a> TrbAnalyzer for &'a mut NegotiateBandwidth {}
impl<'a> TrbAnalyzer for &'a mut CmdNoop {}
impl<'a> TrbAnalyzer for &'a mut ResetDevice {}
impl<'a> TrbAnalyzer for &'a mut ResetEndpoint {}
impl<'a> TrbAnalyzer for &'a mut SetExtendedProperty {}
impl<'a> TrbAnalyzer for &'a mut SetLatencyToleranceValue {}
impl<'a> TrbAnalyzer for &'a mut SetTrDequeuePointer {}
impl<'a> TrbAnalyzer for &'a mut StopEndpoint {}

impl<'a> TrbAnalyzer for &'a mut BandwidthRequest {}
impl<'a> TrbAnalyzer for &'a mut CommandCompletion {}
impl<'a> TrbAnalyzer for &'a mut DeviceNotification {}
impl<'a> TrbAnalyzer for &'a mut Doorbell {}
impl<'a> TrbAnalyzer for &'a mut HostController {}
impl<'a> TrbAnalyzer for &'a mut MfindexWrap {}
impl<'a> TrbAnalyzer for &'a mut PortStatusChange {}
impl<'a> TrbAnalyzer for &'a mut TransferEvent {}

impl<'a> TrbAnalyzer for &'a mut DataStage {}
impl<'a> TrbAnalyzer for &'a mut EventData {}
impl<'a> TrbAnalyzer for &'a mut Isoch {}
impl<'a> TrbAnalyzer for &'a mut TransferNoop {}
impl<'a> TrbAnalyzer for &'a mut Normal {}
impl<'a> TrbAnalyzer for &'a mut SetupStage {}
impl<'a> TrbAnalyzer for &'a mut StatusStage {}

impl<'a> TrbAnalyzer for &'a mut Link {}

enum CommandKind<'a> {
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

enum EventKind<'a> {
    BandwidthRequest(&'a mut BandwidthRequest),
    CommandCompletion(&'a mut CommandCompletion),
    DeviceNotification(&'a mut DeviceNotification),
    Doorbell(&'a mut Doorbell),
    HostController(&'a mut HostController),
    MfindexWrap(&'a mut MfindexWrap),
    PortStatusChange(&'a mut PortStatusChange),
    TransferEvent(&'a mut TransferEvent),
}

enum TransferKind<'a> {
    DataStage(&'a mut DataStage),
    EventData(&'a mut EventData),
    Isoch(&'a mut Isoch),
    TransferNoop(&'a mut TransferNoop),
    Normal(&'a mut Normal),
    SetupStage(&'a mut SetupStage),
    StatusStage(&'a mut StatusStage),
}

enum TrbKind<'a> {
    Command(CommandKind<'a>),
    Event(EventKind<'a>),
    Transfer(TransferKind<'a>),
    Link(&'a mut Link),
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

macro_rules! impl_from_ref_for_trb_kind {
    ($sub:ident, $kind:ident) => {
        impl<'a> From<&'a mut $sub> for TrbKind<'a> {
            fn from(sub: &'a mut $sub) -> Self {
                TrbKind::$kind(sub.into())
            }
        }
    };
}

impl_from_ref_for_trb_kind!(AddressDevice, Command);
impl_from_ref_for_trb_kind!(ConfigureEndpoint, Command);
impl_from_ref_for_trb_kind!(DisableSlot, Command);
impl_from_ref_for_trb_kind!(EnableSlot, Command);
impl_from_ref_for_trb_kind!(EvaluateContext, Command);
impl_from_ref_for_trb_kind!(ForceEvent, Command);
impl_from_ref_for_trb_kind!(ForceHeader, Command);
impl_from_ref_for_trb_kind!(GetExtendedProperty, Command);
impl_from_ref_for_trb_kind!(GetPortBandwidth, Command);
impl_from_ref_for_trb_kind!(NegotiateBandwidth, Command);
impl_from_ref_for_trb_kind!(CmdNoop, Command);
impl_from_ref_for_trb_kind!(ResetDevice, Command);
impl_from_ref_for_trb_kind!(ResetEndpoint, Command);
impl_from_ref_for_trb_kind!(SetExtendedProperty, Command);
impl_from_ref_for_trb_kind!(SetLatencyToleranceValue, Command);
impl_from_ref_for_trb_kind!(SetTrDequeuePointer, Command);
impl_from_ref_for_trb_kind!(StopEndpoint, Command);

impl_from_ref_for_trb_kind!(BandwidthRequest, Event);
impl_from_ref_for_trb_kind!(CommandCompletion, Event);
impl_from_ref_for_trb_kind!(DeviceNotification, Event);
impl_from_ref_for_trb_kind!(Doorbell, Event);
impl_from_ref_for_trb_kind!(HostController, Event);
impl_from_ref_for_trb_kind!(MfindexWrap, Event);
impl_from_ref_for_trb_kind!(PortStatusChange, Event);
impl_from_ref_for_trb_kind!(TransferEvent, Event);

impl_from_ref_for_trb_kind!(DataStage, Transfer);
impl_from_ref_for_trb_kind!(EventData, Transfer);
impl_from_ref_for_trb_kind!(Isoch, Transfer);
impl_from_ref_for_trb_kind!(TransferNoop, Transfer);
impl_from_ref_for_trb_kind!(Normal, Transfer);
impl_from_ref_for_trb_kind!(SetupStage, Transfer);
impl_from_ref_for_trb_kind!(StatusStage, Transfer);

impl<'a> TrbKind<'a> {
    #[allow(dead_code)] // not finished
    pub fn as_inner(&'a mut self) -> &'a mut dyn TrbAnalyzer {
        match self {
            TrbKind::Command(cmd) => match cmd {
                CommandKind::AddressDevice(cmd) => *cmd,
                CommandKind::ConfigureEndpoint(cmd) => *cmd,
                CommandKind::DisableSlot(cmd) => *cmd,
                CommandKind::EnableSlot(cmd) => *cmd,
                CommandKind::EvaluateContext(cmd) => *cmd,
                CommandKind::ForceEvent(cmd) => *cmd,
                CommandKind::ForceHeader(cmd) => *cmd,
                CommandKind::GetExtendedProperty(cmd) => *cmd,
                CommandKind::GetPortBandwidth(cmd) => *cmd,
                CommandKind::NegotiateBandwidth(cmd) => *cmd,
                CommandKind::CmdNoop(cmd) => *cmd,
                CommandKind::ResetDevice(cmd) => *cmd,
                CommandKind::ResetEndpoint(cmd) => *cmd,
                CommandKind::SetExtendedProperty(cmd) => *cmd,
                CommandKind::SetLatencyToleranceValue(cmd) => *cmd,
                CommandKind::SetTrDequeuePointer(cmd) => *cmd,
                CommandKind::StopEndpoint(cmd) => *cmd,
            },
            TrbKind::Event(evt) => match evt {
                EventKind::BandwidthRequest(evt) => *evt,
                EventKind::CommandCompletion(evt) => *evt,
                EventKind::DeviceNotification(evt) => *evt,
                EventKind::Doorbell(evt) => *evt,
                EventKind::HostController(evt) => *evt,
                EventKind::MfindexWrap(evt) => *evt,
                EventKind::PortStatusChange(evt) => *evt,
                EventKind::TransferEvent(evt) => *evt,
            },
            TrbKind::Transfer(tr) => match tr {
                TransferKind::DataStage(tr) => *tr,
                TransferKind::EventData(tr) => *tr,
                TransferKind::Isoch(tr) => *tr,
                TransferKind::TransferNoop(tr) => *tr,
                TransferKind::Normal(tr) => *tr,
                TransferKind::SetupStage(tr) => *tr,
                TransferKind::StatusStage(tr) => *tr,
            },
            TrbKind::Link(l) => *l,
        }
    }
}

impl From<*mut dyn TrbAnalyzer> for TrbKind<'_> {
    fn from(value: *mut dyn TrbAnalyzer) -> Self {
        match unsafe { &*(value) }.get_type() {
            TrbType::Normal => TrbKind::from(unsafe { &mut *(value as *mut Normal) }),
            TrbType::SetupStage => TrbKind::from(unsafe { &mut *(value as *mut SetupStage) }),
            TrbType::DataStage => TrbKind::from(unsafe { &mut *(value as *mut DataStage) }),
            TrbType::StatusStage => TrbKind::from(unsafe { &mut *(value as *mut StatusStage) }),
            TrbType::Isoch => TrbKind::from(unsafe { &mut *(value as *mut Isoch) }),
            TrbType::Link => TrbKind::from(unsafe { &mut *(value as *mut Link) }),
            TrbType::EventData => TrbKind::from(unsafe { &mut *(value as *mut EventData) }),
            TrbType::NoopTransfer => TrbKind::from(unsafe { &mut *(value as *mut TransferNoop) }),
            TrbType::EnableSlot => TrbKind::from(unsafe { &mut *(value as *mut EnableSlot) }),
            TrbType::DisableSlot => TrbKind::from(unsafe { &mut *(value as *mut DisableSlot) }),
            TrbType::AddressDevice => TrbKind::from(unsafe { &mut *(value as *mut AddressDevice) }),
            TrbType::ConfigureEndpoint => {
                TrbKind::from(unsafe { &mut *(value as *mut ConfigureEndpoint) })
            }
            TrbType::EvaluateContext => {
                TrbKind::from(unsafe { &mut *(value as *mut EvaluateContext) })
            }
            TrbType::ResetEndpoint => TrbKind::from(unsafe { &mut *(value as *mut ResetEndpoint) }),
            TrbType::StopEndpoint => TrbKind::from(unsafe { &mut *(value as *mut StopEndpoint) }),
            TrbType::SetTrDequeuePointer => {
                TrbKind::from(unsafe { &mut *(value as *mut SetTrDequeuePointer) })
            }
            TrbType::ResetDevice => TrbKind::from(unsafe { &mut *(value as *mut ResetDevice) }),
            TrbType::ForceEvent => TrbKind::from(unsafe { &mut *(value as *mut ForceEvent) }),
            TrbType::NegotiateBandwidth => {
                TrbKind::from(unsafe { &mut *(value as *mut NegotiateBandwidth) })
            }
            TrbType::SetLatencyToleranceValue => {
                TrbKind::from(unsafe { &mut *(value as *mut SetLatencyToleranceValue) })
            }
            TrbType::GetPortBandwidth => {
                TrbKind::from(unsafe { &mut *(value as *mut GetPortBandwidth) })
            }
            TrbType::ForceHeader => TrbKind::from(unsafe { &mut *(value as *mut ForceHeader) }),
            TrbType::NoopCommand => TrbKind::from(unsafe { &mut *(value as *mut CmdNoop) }),
            TrbType::GetExtendedProperty => {
                TrbKind::from(unsafe { &mut *(value as *mut GetExtendedProperty) })
            }
            TrbType::SetExtendedProperty => {
                TrbKind::from(unsafe { &mut *(value as *mut SetExtendedProperty) })
            }
            TrbType::TransferEvent => TrbKind::from(unsafe { &mut *(value as *mut TransferEvent) }),
            TrbType::CommandCompletion => {
                TrbKind::from(unsafe { &mut *(value as *mut CommandCompletion) })
            }
            TrbType::PortStatusChange => {
                TrbKind::from(unsafe { &mut *(value as *mut PortStatusChange) })
            }
            TrbType::BandwidthRequest => {
                TrbKind::from(unsafe { &mut *(value as *mut BandwidthRequest) })
            }
            TrbType::Doorbell => TrbKind::from(unsafe { &mut *(value as *mut Doorbell) }),
            TrbType::HostController => {
                TrbKind::from(unsafe { &mut *(value as *mut HostController) })
            }
            TrbType::DeviceNotification => {
                TrbKind::from(unsafe { &mut *(value as *mut DeviceNotification) })
            }
            TrbType::MfindexWrap => TrbKind::from(unsafe { &mut *(value as *mut MfindexWrap) }),
        }
    }
}

pub struct XhciImpl {
    regs: Option<Registers<XhciMapper>>,
    extcaps: Option<List<XhciMapper>>,
    cmd_ring: &'static mut [CommandKind<'static>],
    event_ring_dequeue: &'static mut [EventKind<'static>],
    transfer_ring: &'static mut [TransferKind<'static>],
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
                        let test = Page::<Size4KiB>::containing_address(VirtAddr::new(full_bar));
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

        let extcaps = regs.as_ref().and_then(|regs| {
            let extended_caps = unsafe {
                List::new(
                    offset_full_bar_outer.get().cloned().unwrap(),
                    regs.capability.hccparams1.read_volatile(),
                    MAPPER.read().clone(),
                )
            };
            extended_caps
        });

        Self {
            regs,
            extcaps,
            cmd_ring: unsafe {
                core::slice::from_raw_parts_mut::<'static>(
                    addralloc::<CommandKind<'_>>(),
                    Page::<Size4KiB>::SIZE as usize / core::mem::size_of::<CommandKind<'_>>(),
                )
            },
            event_ring_dequeue: unsafe {
                core::slice::from_raw_parts_mut::<'static>(
                    addralloc::<EventKind<'_>>(),
                    Page::<Size4KiB>::SIZE as usize / core::mem::size_of::<EventKind<'_>>(),
                )
            },
            transfer_ring: unsafe {
                core::slice::from_raw_parts_mut::<'static>(
                    addralloc::<TransferKind<'_>>(),
                    Page::<Size4KiB>::SIZE as usize / core::mem::size_of::<TransferKind<'_>>(),
                )
            },
        }
    }
    pub fn capabilities_mut(&mut self) -> Option<&mut Capability<XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &mut *((&mut self.regs) as *mut Option<Registers<XhciMapper>>) }
            .as_mut()
            .map(|regs| unsafe { &mut (*(regs as *mut Registers<XhciMapper>)).capability })
    }
    pub fn doorbell_mut(&mut self) -> Option<&mut ReadWrite<Register, XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &mut *((&mut self.regs) as *mut Option<Registers<XhciMapper>>) }
            .as_mut()
            .map(|regs| unsafe { &mut (*(regs as *mut Registers<XhciMapper>)).doorbell })
    }
    pub fn operational_mut(&mut self) -> Option<&mut Operational<XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &mut *((&mut self.regs) as *mut Option<Registers<XhciMapper>>) }
            .as_mut()
            .map(|regs| unsafe { &mut (*(regs as *mut Registers<XhciMapper>)).operational })
    }
    pub fn port_register_set_mut(&mut self) -> Option<&mut ReadWrite<PortRegisterSet, XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &mut *((&mut self.regs) as *mut Option<Registers<XhciMapper>>) }
            .as_mut()
            .map(|regs| unsafe { &mut (*(regs as *mut Registers<XhciMapper>)).port_register_set })
    }
    pub fn runtime_mut(&mut self) -> Option<&mut Runtime<XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &mut *((&mut self.regs) as *mut Option<Registers<XhciMapper>>) }
            .as_mut()
            .map(|regs| unsafe { &mut (*(regs as *mut Registers<XhciMapper>)).runtime })
    }
    pub fn interrupter_register_set_mut(
        &mut self,
    ) -> Option<&mut InterrupterRegisterSet<XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &mut *((&mut self.regs) as *mut Option<Registers<XhciMapper>>) }
            .as_mut()
            .map(|regs| unsafe {
                &mut (*(regs as *mut Registers<XhciMapper>)).interrupter_register_set
            })
    }
    pub fn capabilities(&self) -> Option<&Capability<XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &*((&self.regs) as *const Option<Registers<XhciMapper>>) }
            .as_ref()
            .map(|regs| unsafe { &(*(regs as *const Registers<XhciMapper>)).capability })
    }
    pub fn doorbell(&self) -> Option<&ReadWrite<Register, XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &*((&self.regs) as *const Option<Registers<XhciMapper>>) }
            .as_ref()
            .map(|regs| unsafe { &(*(regs as *const Registers<XhciMapper>)).doorbell })
    }
    pub fn operational(&self) -> Option<&Operational<XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &*((&self.regs) as *const Option<Registers<XhciMapper>>) }
            .as_ref()
            .map(|regs| unsafe { &(*(regs as *const Registers<XhciMapper>)).operational })
    }
    pub fn port_register_set(&self) -> Option<&ReadWrite<PortRegisterSet, XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &*((&self.regs) as *const Option<Registers<XhciMapper>>) }
            .as_ref()
            .map(|regs| unsafe { &(*(regs as *const Registers<XhciMapper>)).port_register_set })
    }
    pub fn runtime(&self) -> Option<&Runtime<XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &*((&self.regs) as *const Option<Registers<XhciMapper>>) }
            .as_ref()
            .map(|regs| unsafe { &(*(regs as *const Registers<XhciMapper>)).runtime })
    }
    pub fn interrupter_register_set(&self) -> Option<&InterrupterRegisterSet<XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &*((&self.regs) as *const Option<Registers<XhciMapper>>) }
            .as_ref()
            .map(|regs| unsafe {
                &(*(regs as *const Registers<XhciMapper>)).interrupter_register_set
            })
    }
    pub fn extcaps(&self) -> Option<&List<XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { *(&(self.extcaps.as_ref()) as *const Option<&List<XhciMapper>>) }
    }
    pub fn extcaps_mut(&mut self) -> Option<&mut List<XhciMapper>> {
        // Borrow checker throws a hissy fit when raw pointers aren't used here
        unsafe { &mut *((&mut self.extcaps) as *mut Option<List<XhciMapper>>) }.as_mut()
    }
    pub fn init(&mut self) {
        // borrow checker
        let cmd_ring_addr = self.cmd_ring.first().unwrap() as *const CommandKind<'_> as u64;
        let erdp_raw = self.event_ring_dequeue.first().unwrap() as *const EventKind<'_> as u64;

        // will need this later
        let _transfer_ring_ptr = self.transfer_ring as *mut [TransferKind<'_>];

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
                if let Some(op) = self.operational_mut() {
                    op.config.update_volatile(|config| {
                        config.set_max_device_slots_enabled(slots);
                    })
                }
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

            // Use max_slots and core::slice::from_raw_parts_mut to create a slot context array
            let dev_context_array = unsafe {
                core::slice::from_raw_parts_mut::<'static>(
                    addralloc::<Device<16>>(),
                    max_slots.unwrap() as usize,
                )
            };

            // Set the DCBAAP
            if let Some(op) = self.operational_mut() {
                op.dcbaap.update_volatile(|dcbaap| {
                    dcbaap.set(
                        dev_context_array
                            .first()
                            .map(|dev| dev as *const _ as u64)
                            .expect("No devices present in device context array"),
                    )
                })
            }

            // Set the command ring control register
            if let Some(op) = self.operational_mut() {
                op.crcr
                    .update_volatile(|crcr| crcr.set_command_ring_pointer(cmd_ring_addr))
            }

            // Set event ring segment table registers
            self.interrupter_register_set_mut().map(|int| {
                for i in 0..(max_interrupts as usize) {
                    // Set table size
                    int.interrupter_mut(i).erstsz.update_volatile(|erstsz| {
                        erstsz.set(unsafe { *(addralloc::<u16>()) });
                    });

                    // Set the event ring dequeue pointer
                    int.interrupter_mut(i).erdp.update_volatile(|erdp| {
                        erdp.set_event_ring_dequeue_pointer(erdp_raw);
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
            if let Some(op) = self.operational_mut() {
                op.usbcmd.update_volatile(|cmd| {
                    cmd.set_interrupter_enable();
                })
            }

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
                unsafe { *(addr_of!(scratchpad_buf[0]) as u64 as *mut Device<_>) };

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
                    if let Some(op) = self.operational_mut() {
                        op.config.update_volatile(|config| {
                            config.set_configuration_information_enable();
                        })
                    }
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
                    }
                }
                log::info!("Ports successfully reset");
            });

            // Debug
            self.probe::<16>();
        }
    }

    pub fn probe<const N: usize>(&mut self) -> Option<UsbDeviceKind> {
        if let Some(prs) = self.port_register_set() {
            for (i, mut port) in prs.into_iter().enumerate() {
                if port.portsc.port_power() {
                    log::debug!("Probing port {}", i);
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
