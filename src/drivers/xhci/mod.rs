// SPDX-License-Identifier: GPL-3.0-or-later

// TODO: rewrite this entire driver because all the enums I'm defining are causing problems
use alloc::sync::Arc;
use bit_field::BitField;
use conquer_once::spin::OnceCell;
use core::{
    ptr::addr_of,
    sync::atomic::{AtomicUsize, Ordering},
};
use num_traits::cast::FromPrimitive;
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
    context::{Device, EndpointType, Input, InputHandler, SlotState},
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
            BandwidthRequest, CommandCompletion, CompletionCode, DeviceNotification, Doorbell,
            HostController, MfindexWrap, PortStatusChange, TransferEvent,
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
pub trait TrbAnalyzer: AsRef<[u32]> {
    fn get_type(&self) -> TrbType {
        match self.as_ref()[3].get_bits(10..=15) {
            // TODO: figure out why QEMU is giving 0 when I attempt a device probe
            0 => TrbType::Normal,
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
            _ => panic!(
                "Invalid TRB type: {:#?}",
                self.as_ref()[3].get_bits(10..=15)
            ),
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

impl TrbAnalyzer for &'static mut AddressDevice {}
impl TrbAnalyzer for &'static mut ConfigureEndpoint {}
impl TrbAnalyzer for &'static mut DisableSlot {}
impl TrbAnalyzer for &'static mut EnableSlot {}
impl TrbAnalyzer for &'static mut EvaluateContext {}
impl TrbAnalyzer for &'static mut ForceEvent {}
impl TrbAnalyzer for &'static mut ForceHeader {}
impl TrbAnalyzer for &'static mut GetExtendedProperty {}
impl TrbAnalyzer for &'static mut GetPortBandwidth {}
impl TrbAnalyzer for &'static mut NegotiateBandwidth {}
impl TrbAnalyzer for &'static mut CmdNoop {}
impl TrbAnalyzer for &'static mut ResetDevice {}
impl TrbAnalyzer for &'static mut ResetEndpoint {}
impl TrbAnalyzer for &'static mut SetExtendedProperty {}
impl TrbAnalyzer for &'static mut SetLatencyToleranceValue {}
impl TrbAnalyzer for &'static mut SetTrDequeuePointer {}
impl TrbAnalyzer for &'static mut StopEndpoint {}

impl TrbAnalyzer for &'static mut BandwidthRequest {}
impl TrbAnalyzer for &'static mut CommandCompletion {}
impl TrbAnalyzer for &'static mut DeviceNotification {}
impl TrbAnalyzer for &'static mut Doorbell {}
impl TrbAnalyzer for &'static mut HostController {}
impl TrbAnalyzer for &'static mut MfindexWrap {}
impl TrbAnalyzer for &'static mut PortStatusChange {}
impl TrbAnalyzer for &'static mut TransferEvent {}

impl TrbAnalyzer for &'static mut DataStage {}
impl TrbAnalyzer for &'static mut EventData {}
impl TrbAnalyzer for &'static mut Isoch {}
impl TrbAnalyzer for &'static mut TransferNoop {}
impl TrbAnalyzer for &'static mut Normal {}
impl TrbAnalyzer for &'static mut SetupStage {}
impl TrbAnalyzer for &'static mut StatusStage {}

#[derive(Debug)]
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

#[derive(Debug)]
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

macro_rules! impl_from_ptr_for_kind {
    ($sub:ident, $kind:ident) => {
        impl<'a> From<*mut $sub> for $kind<'a> {
            #[allow(clippy::not_unsafe_ptr_arg_deref)]
            fn from(sub: *mut $sub) -> Self {
                $kind::$sub(unsafe { &mut *sub })
            }
        }
    };
}

impl_from_ptr_for_kind!(AddressDevice, CommandKind);
impl_from_ptr_for_kind!(ConfigureEndpoint, CommandKind);
impl_from_ptr_for_kind!(DisableSlot, CommandKind);
impl_from_ptr_for_kind!(EnableSlot, CommandKind);
impl_from_ptr_for_kind!(EvaluateContext, CommandKind);
impl_from_ptr_for_kind!(ForceEvent, CommandKind);
impl_from_ptr_for_kind!(ForceHeader, CommandKind);
impl_from_ptr_for_kind!(GetExtendedProperty, CommandKind);
impl_from_ptr_for_kind!(GetPortBandwidth, CommandKind);
impl_from_ptr_for_kind!(NegotiateBandwidth, CommandKind);
impl_from_ptr_for_kind!(CmdNoop, CommandKind);
impl_from_ptr_for_kind!(ResetDevice, CommandKind);
impl_from_ptr_for_kind!(ResetEndpoint, CommandKind);
impl_from_ptr_for_kind!(SetExtendedProperty, CommandKind);
impl_from_ptr_for_kind!(SetLatencyToleranceValue, CommandKind);
impl_from_ptr_for_kind!(SetTrDequeuePointer, CommandKind);
impl_from_ptr_for_kind!(StopEndpoint, CommandKind);

impl_from_ptr_for_kind!(BandwidthRequest, EventKind);
impl_from_ptr_for_kind!(CommandCompletion, EventKind);
impl_from_ptr_for_kind!(DeviceNotification, EventKind);
impl_from_ptr_for_kind!(Doorbell, EventKind);
impl_from_ptr_for_kind!(HostController, EventKind);
impl_from_ptr_for_kind!(MfindexWrap, EventKind);
impl_from_ptr_for_kind!(PortStatusChange, EventKind);
impl_from_ptr_for_kind!(TransferEvent, EventKind);

impl_from_ptr_for_kind!(DataStage, TransferKind);
impl_from_ptr_for_kind!(EventData, TransferKind);
impl_from_ptr_for_kind!(Isoch, TransferKind);
impl_from_ptr_for_kind!(TransferNoop, TransferKind);
impl_from_ptr_for_kind!(Normal, TransferKind);
impl_from_ptr_for_kind!(SetupStage, TransferKind);
impl_from_ptr_for_kind!(StatusStage, TransferKind);

macro_rules! impl_from_ptr_for_trb_kind {
    ($sub:ident, $kind:ident) => {
        impl<'a> From<*mut $sub> for TrbKind<'a> {
            #[allow(clippy::not_unsafe_ptr_arg_deref)]
            fn from(sub: *mut $sub) -> Self {
                TrbKind::$kind(unsafe { &mut *sub }.into())
            }
        }
    };
}

impl_from_ptr_for_trb_kind!(AddressDevice, Command);
impl_from_ptr_for_trb_kind!(ConfigureEndpoint, Command);
impl_from_ptr_for_trb_kind!(DisableSlot, Command);
impl_from_ptr_for_trb_kind!(EnableSlot, Command);
impl_from_ptr_for_trb_kind!(EvaluateContext, Command);
impl_from_ptr_for_trb_kind!(ForceEvent, Command);
impl_from_ptr_for_trb_kind!(ForceHeader, Command);
impl_from_ptr_for_trb_kind!(GetExtendedProperty, Command);
impl_from_ptr_for_trb_kind!(GetPortBandwidth, Command);
impl_from_ptr_for_trb_kind!(NegotiateBandwidth, Command);
impl_from_ptr_for_trb_kind!(CmdNoop, Command);
impl_from_ptr_for_trb_kind!(ResetDevice, Command);
impl_from_ptr_for_trb_kind!(ResetEndpoint, Command);
impl_from_ptr_for_trb_kind!(SetExtendedProperty, Command);
impl_from_ptr_for_trb_kind!(SetLatencyToleranceValue, Command);
impl_from_ptr_for_trb_kind!(SetTrDequeuePointer, Command);
impl_from_ptr_for_trb_kind!(StopEndpoint, Command);

impl_from_ptr_for_trb_kind!(BandwidthRequest, Event);
impl_from_ptr_for_trb_kind!(CommandCompletion, Event);
impl_from_ptr_for_trb_kind!(DeviceNotification, Event);
impl_from_ptr_for_trb_kind!(Doorbell, Event);
impl_from_ptr_for_trb_kind!(HostController, Event);
impl_from_ptr_for_trb_kind!(MfindexWrap, Event);
impl_from_ptr_for_trb_kind!(PortStatusChange, Event);
impl_from_ptr_for_trb_kind!(TransferEvent, Event);

impl_from_ptr_for_trb_kind!(DataStage, Transfer);
impl_from_ptr_for_trb_kind!(EventData, Transfer);
impl_from_ptr_for_trb_kind!(Isoch, Transfer);
impl_from_ptr_for_trb_kind!(TransferNoop, Transfer);
impl_from_ptr_for_trb_kind!(Normal, Transfer);
impl_from_ptr_for_trb_kind!(SetupStage, Transfer);
impl_from_ptr_for_trb_kind!(StatusStage, Transfer);

impl<'a> CommandKind<'a> {
    pub fn as_inner(&'a self) -> &'a dyn TrbAnalyzer {
        match self {
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
        }
    }

    pub fn as_ptr(&self) -> *mut dyn TrbAnalyzer {
        let self_ptr = self as *const Self as *mut Self;
        unsafe { &*self_ptr }.as_inner() as *const _ as *mut _
    }

    // Using raw pointers on purpose to enable exactly this
    #[allow(clippy::mut_from_ref)]
    pub fn as_inner_mut(&'a self) -> &'a mut dyn TrbAnalyzer {
        unsafe { &mut *(self.as_ptr()) }
    }

    pub fn cycle_bit(&self) -> bool {
        match self {
            CommandKind::AddressDevice(cmd) => cmd.cycle_bit(),
            CommandKind::ConfigureEndpoint(cmd) => cmd.cycle_bit(),
            CommandKind::DisableSlot(cmd) => cmd.cycle_bit(),
            CommandKind::EnableSlot(cmd) => cmd.cycle_bit(),
            CommandKind::EvaluateContext(cmd) => cmd.cycle_bit(),
            CommandKind::ForceEvent(cmd) => cmd.cycle_bit(),
            CommandKind::ForceHeader(cmd) => cmd.cycle_bit(),
            CommandKind::GetExtendedProperty(cmd) => cmd.cycle_bit(),
            CommandKind::GetPortBandwidth(cmd) => cmd.cycle_bit(),
            CommandKind::NegotiateBandwidth(cmd) => cmd.cycle_bit(),
            CommandKind::CmdNoop(cmd) => cmd.cycle_bit(),
            CommandKind::ResetDevice(cmd) => cmd.cycle_bit(),
            CommandKind::ResetEndpoint(cmd) => cmd.cycle_bit(),
            CommandKind::SetExtendedProperty(cmd) => cmd.cycle_bit(),
            CommandKind::SetLatencyToleranceValue(cmd) => cmd.cycle_bit(),
            CommandKind::SetTrDequeuePointer(cmd) => cmd.cycle_bit(),
            CommandKind::StopEndpoint(cmd) => cmd.cycle_bit(),
        }
    }
}

impl<'a> EventKind<'a> {
    pub fn as_inner(&'a self) -> &'a dyn TrbAnalyzer {
        match self {
            EventKind::BandwidthRequest(evt) => *evt,
            EventKind::CommandCompletion(evt) => *evt,
            EventKind::DeviceNotification(evt) => *evt,
            EventKind::Doorbell(evt) => *evt,
            EventKind::HostController(evt) => *evt,
            EventKind::MfindexWrap(evt) => *evt,
            EventKind::PortStatusChange(evt) => *evt,
            EventKind::TransferEvent(evt) => *evt,
        }
    }

    pub fn as_ptr(&self) -> *mut dyn TrbAnalyzer {
        let self_ptr = self as *const Self as *mut Self;
        unsafe { &*self_ptr }.as_inner() as *const _ as *mut _
    }

    // Using raw pointers on purpose to enable exactly this
    #[allow(clippy::mut_from_ref)]
    pub fn as_inner_mut(&'a self) -> &'a mut dyn TrbAnalyzer {
        unsafe { &mut *(self.as_ptr()) }
    }

    pub fn cycle_bit(&self) -> bool {
        match self {
            EventKind::BandwidthRequest(evt) => evt.cycle_bit(),
            EventKind::CommandCompletion(evt) => evt.cycle_bit(),
            EventKind::DeviceNotification(evt) => evt.cycle_bit(),
            EventKind::Doorbell(evt) => evt.cycle_bit(),
            EventKind::HostController(evt) => evt.cycle_bit(),
            EventKind::MfindexWrap(evt) => evt.cycle_bit(),
            EventKind::PortStatusChange(evt) => evt.cycle_bit(),
            EventKind::TransferEvent(evt) => evt.cycle_bit(),
        }
    }
}

impl<'a> TransferKind<'a> {
    pub fn as_inner(&'a self) -> &'a dyn TrbAnalyzer {
        match self {
            TransferKind::DataStage(tr) => *tr,
            TransferKind::EventData(tr) => *tr,
            TransferKind::Isoch(tr) => *tr,
            TransferKind::TransferNoop(tr) => *tr,
            TransferKind::Normal(tr) => *tr,
            TransferKind::SetupStage(tr) => *tr,
            TransferKind::StatusStage(tr) => *tr,
        }
    }

    pub fn as_ptr(&self) -> *mut dyn TrbAnalyzer {
        let self_ptr = self as *const Self as *mut Self;
        unsafe { &*self_ptr }.as_inner() as *const _ as *mut _
    }

    // Using raw pointers on purpose to enable exactly this
    #[allow(clippy::mut_from_ref)]
    pub fn as_inner_mut(&'a self) -> &'a mut dyn TrbAnalyzer {
        unsafe { &mut *(self.as_ptr()) }
    }

    pub fn cycle_bit(&self) -> bool {
        match self {
            TransferKind::DataStage(tr) => tr.cycle_bit(),
            TransferKind::EventData(tr) => tr.cycle_bit(),
            TransferKind::Isoch(tr) => tr.cycle_bit(),
            TransferKind::TransferNoop(tr) => tr.cycle_bit(),
            TransferKind::Normal(tr) => tr.cycle_bit(),
            TransferKind::SetupStage(tr) => tr.cycle_bit(),
            TransferKind::StatusStage(tr) => tr.cycle_bit(),
        }
    }
}

impl<'a> TrbKind<'a> {
    pub fn as_inner(&'a self) -> &'a dyn TrbAnalyzer {
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

    pub fn as_ptr(&'a self) -> *mut dyn TrbAnalyzer {
        let self_ptr = self as *const Self as *mut Self;
        unsafe { &*self_ptr }.as_inner() as *const _ as *mut _
    }

    // Using raw pointers on purpose to enable exactly this
    #[allow(clippy::mut_from_ref)]
    pub fn as_inner_mut(&'a self) -> &'a mut dyn TrbAnalyzer {
        unsafe { &mut *(self.as_ptr()) }
    }

    pub fn cycle_bit(&self) -> bool {
        match self {
            TrbKind::Command(cmd) => cmd.cycle_bit(),
            TrbKind::Event(evt) => evt.cycle_bit(),
            TrbKind::Transfer(tr) => tr.cycle_bit(),
            TrbKind::Link(l) => l.cycle_bit(),
        }
    }
}

impl From<*mut dyn TrbAnalyzer> for TrbKind<'_> {
    // cannot be implemented any other way
    #[allow(clippy::not_unsafe_ptr_arg_deref)]
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

impl<'a> Clone for CommandKind<'a> {
    fn clone(&self) -> Self {
        match self {
            CommandKind::AddressDevice(_) => {
                Self::AddressDevice(unsafe { &mut *(addralloc::<AddressDevice>()) })
            }
            CommandKind::ConfigureEndpoint(_) => {
                Self::ConfigureEndpoint(unsafe { &mut *(addralloc::<ConfigureEndpoint>()) })
            }
            CommandKind::DisableSlot(_) => {
                Self::DisableSlot(unsafe { &mut *(addralloc::<DisableSlot>()) })
            }
            CommandKind::EnableSlot(_) => {
                Self::EnableSlot(unsafe { &mut *(addralloc::<EnableSlot>()) })
            }
            CommandKind::EvaluateContext(_) => {
                Self::EvaluateContext(unsafe { &mut *(addralloc::<EvaluateContext>()) })
            }
            CommandKind::ForceEvent(_) => {
                Self::ForceEvent(unsafe { &mut *(addralloc::<ForceEvent>()) })
            }
            CommandKind::ForceHeader(_) => {
                Self::ForceHeader(unsafe { &mut *(addralloc::<ForceHeader>()) })
            }
            CommandKind::GetExtendedProperty(_) => {
                Self::GetExtendedProperty(unsafe { &mut *(addralloc::<GetExtendedProperty>()) })
            }
            CommandKind::GetPortBandwidth(_) => {
                Self::GetPortBandwidth(unsafe { &mut *(addralloc::<GetPortBandwidth>()) })
            }
            CommandKind::NegotiateBandwidth(_) => {
                Self::NegotiateBandwidth(unsafe { &mut *(addralloc::<NegotiateBandwidth>()) })
            }
            CommandKind::CmdNoop(_) => Self::CmdNoop(unsafe { &mut *(addralloc::<CmdNoop>()) }),
            CommandKind::ResetDevice(_) => {
                Self::ResetDevice(unsafe { &mut *(addralloc::<ResetDevice>()) })
            }
            CommandKind::ResetEndpoint(_) => {
                Self::ResetEndpoint(unsafe { &mut *(addralloc::<ResetEndpoint>()) })
            }
            CommandKind::SetExtendedProperty(_) => {
                Self::SetExtendedProperty(unsafe { &mut *(addralloc::<SetExtendedProperty>()) })
            }
            CommandKind::SetLatencyToleranceValue(_) => Self::SetLatencyToleranceValue(unsafe {
                &mut *(addralloc::<SetLatencyToleranceValue>())
            }),
            CommandKind::SetTrDequeuePointer(_) => {
                Self::SetTrDequeuePointer(unsafe { &mut *(addralloc::<SetTrDequeuePointer>()) })
            }
            CommandKind::StopEndpoint(_) => {
                Self::StopEndpoint(unsafe { &mut *(addralloc::<StopEndpoint>()) })
            }
        }
    }
}

impl<'a> Clone for EventKind<'a> {
    fn clone(&self) -> Self {
        match self {
            EventKind::BandwidthRequest(_) => {
                Self::BandwidthRequest(unsafe { &mut *(addralloc::<BandwidthRequest>()) })
            }
            EventKind::CommandCompletion(_) => {
                Self::CommandCompletion(unsafe { &mut *(addralloc::<CommandCompletion>()) })
            }
            EventKind::DeviceNotification(_) => {
                Self::DeviceNotification(unsafe { &mut *(addralloc::<DeviceNotification>()) })
            }
            EventKind::Doorbell(_) => Self::Doorbell(unsafe { &mut *(addralloc::<Doorbell>()) }),
            EventKind::HostController(_) => {
                Self::HostController(unsafe { &mut *(addralloc::<HostController>()) })
            }
            EventKind::MfindexWrap(_) => {
                Self::MfindexWrap(unsafe { &mut *(addralloc::<MfindexWrap>()) })
            }
            EventKind::PortStatusChange(_) => {
                Self::PortStatusChange(unsafe { &mut *(addralloc::<PortStatusChange>()) })
            }
            EventKind::TransferEvent(_) => {
                Self::TransferEvent(unsafe { &mut *(addralloc::<TransferEvent>()) })
            }
        }
    }
}

impl<'a> Clone for TransferKind<'a> {
    fn clone(&self) -> Self {
        match self {
            TransferKind::DataStage(_) => {
                Self::DataStage(unsafe { &mut *(addralloc::<DataStage>()) })
            }
            TransferKind::EventData(_) => {
                Self::EventData(unsafe { &mut *(addralloc::<EventData>()) })
            }
            TransferKind::Isoch(_) => Self::Isoch(unsafe { &mut *(addralloc::<Isoch>()) }),
            TransferKind::TransferNoop(_) => {
                Self::TransferNoop(unsafe { &mut *(addralloc::<TransferNoop>()) })
            }
            TransferKind::Normal(_) => Self::Normal(unsafe { &mut *(addralloc::<Normal>()) }),
            TransferKind::SetupStage(_) => {
                Self::SetupStage(unsafe { &mut *(addralloc::<SetupStage>()) })
            }
            TransferKind::StatusStage(_) => {
                Self::StatusStage(unsafe { &mut *(addralloc::<StatusStage>()) })
            }
        }
    }
}

impl<'a> Clone for TrbKind<'a> {
    fn clone(&self) -> Self {
        match self {
            Self::Command(cmd) => Self::Command(cmd.clone()),
            Self::Event(evt) => Self::Event(evt.clone()),
            Self::Transfer(tr) => Self::Transfer(tr.clone()),
            Self::Link(_) => Self::Link(unsafe { &mut *(addralloc::<Link>()) }),
        }
    }
}

// Needed for ensuring proper synchronization of indices
static CMD_RING_IDX: AtomicUsize = AtomicUsize::new(0);
static EVENT_RING_IDX: AtomicUsize = AtomicUsize::new(0);

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

            // Read in the max number of slots, ports, and interrupts
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

            // Read the configuration information capability
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
                    log::debug!("Resetting port {}", i);
                    if port.portsc.port_enabled_disabled() {
                        port.portsc.set_port_reset();
                        while port.portsc.port_reset() {
                            core::hint::spin_loop();
                        }
                    }
                }
                log::info!("XHCI: Ports successfully reset");
            });

            // Debug
            self.probe::<16>();
        }
    }

    pub fn probe<const N: usize>(&mut self) -> Option<UsbDeviceKind> {
        // borrow checker
        let me = self as *mut Self;

        if let Some(prs) = self.port_register_set() {
            for (i, port) in prs.into_iter().enumerate() {
                if port.portsc.port_power() {
                    log::debug!("Probing port {}", i);
                    unsafe { &mut *me }.negotiate_bandwidth(i as u8);
                    unsafe { &mut *me }.enable_port_slot(i as u8);
                    while !port.portsc.port_enabled_disabled() {
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

    pub fn next_command_completion_request(
        &mut self,
        cycle: bool,
        slot: u8,
    ) -> (usize, EventKind<'_>) {
        let me = self as *mut Self;
        let mut event_ring = self.event_ring_dequeue.iter().cloned().enumerate();

        event_ring
            .find(|(_, evt)| matches!(evt, EventKind::CommandCompletion(_)))
            .unwrap_or_else(|| {
                let me = unsafe { &mut *me };

                let new_evt = {
                    let new_inner = &mut CommandCompletion::new();

                    new_inner.slot_id().set_bits(0.., slot);

                    if cycle {
                        new_inner.set_cycle_bit();
                    }

                    EventKind::from(new_inner as *mut _)
                };

                me.event_ring_dequeue[EVENT_RING_IDX.load(Ordering::SeqCst)] = new_evt;

                let out = (
                    EVENT_RING_IDX.load(Ordering::SeqCst),
                    me.event_ring_dequeue[EVENT_RING_IDX.load(Ordering::SeqCst)].clone(),
                );

                EVENT_RING_IDX.fetch_add(1, Ordering::SeqCst);
                out
            })
    }

    pub fn next_in_cmd_ring(&mut self) -> (usize, CommandKind<'_>) {
        let mut cmd_ring_iter = self.cmd_ring.iter().cloned().enumerate();
        let out = cmd_ring_iter
            .nth(CMD_RING_IDX.load(Ordering::SeqCst))
            .unwrap_or_else(move || {
                CMD_RING_IDX.store(0, Ordering::SeqCst);
                cmd_ring_iter
                    .nth(CMD_RING_IDX.load(Ordering::SeqCst))
                    .unwrap()
            });

        CMD_RING_IDX.fetch_add(1, Ordering::SeqCst);
        out
    }

    pub fn next_in_event_ring(&mut self) -> (usize, EventKind<'_>) {
        let mut event_ring_iter = self.event_ring_dequeue.iter().cloned().enumerate();
        let out = event_ring_iter
            .nth(EVENT_RING_IDX.load(Ordering::SeqCst))
            .unwrap_or_else(move || {
                EVENT_RING_IDX.store(0, Ordering::SeqCst);
                event_ring_iter
                    .nth(EVENT_RING_IDX.load(Ordering::SeqCst))
                    .unwrap()
            });

        EVENT_RING_IDX.fetch_add(1, Ordering::SeqCst);
        out
    }

    pub fn exec_cmd<F: FnOnce(&mut CommandKind<'_>, bool)>(
        &mut self,
        slot: u8,
        to_execute: F,
    ) -> (EventKind, CommandKind) {
        // borrow checker
        let cmd_ring = unsafe { &mut *(self.cmd_ring as *mut [CommandKind<'_>]) };

        // borrow checker
        let cmd_ptr = cmd_ring
            .get_mut(slot as usize)
            .expect("Slot number must be between 0 and 255") as *mut _;

        // Clear "Event Handler Busy" bit if set
        if let Some(ints) = self.interrupter_register_set_mut() {
            ints.interrupter_mut(0).erdp.update_volatile(|erdp| {
                erdp.clear_event_handler_busy();
            })
        };

        let (idx, cycle) = {
            let (idx, cmd) = self.next_in_cmd_ring();
            (idx, cmd.cycle_bit())
        };

        let trb = &mut cmd_ring[idx];
        to_execute(unsafe { &mut *cmd_ptr }, cycle);

        // Ring doorbell to initiate command execution
        if let Some(db) = self.doorbell_mut() {
            db.update_volatile_at(slot as usize, |db| {
                db.set_doorbell_target(0);
            });
        }

        // Spinloop until command completes
        while {
            let (_, evt) = self.next_command_completion_request(cycle, slot);
            if let EventKind::CommandCompletion(evt) = evt {
                let inner = trb.as_inner();
                if evt.command_trb_pointer() == inner.get_type() as u64 {
                    true
                } else {
                    log::warn!(
                        "Unexpected command TRB pointer: {:#?}",
                        evt.command_trb_pointer()
                    );
                    false
                }
            } else {
                log::warn!("Not a command completion TRB");
                false
            }
        } {
            core::hint::spin_loop();
        }

        let (_, evt) = self.next_in_event_ring();
        (evt.clone(), trb.clone())
    }

    pub fn negotiate_bandwidth(&mut self, slot: u8) {
        let (evt, _) = self.exec_cmd(slot, |cmd, _| {
            *cmd = CommandKind::from(
                (&mut {
                    let mut nb = NegotiateBandwidth::new();
                    nb.set_cycle_bit();
                    nb.set_slot_id(slot);
                    nb
                }) as *mut _,
            );
        });

        if let EventKind::BandwidthRequest(br) = evt {
            if let Ok(cc) = br.completion_code() {
                if cc == CompletionCode::Invalid {
                    log::warn!("Invalid completion code received");
                }
            }
            log::info!("Bandwidth request: {:#?}", br);
        } else {
            log::warn!("Unexpected TRB type: {:?}", evt);
        }
    }

    pub fn enable_port_slot(&mut self, slot: u8) {
        let (evt, _) = self.exec_cmd(slot, |cmd, _| {
            *cmd = CommandKind::from((&mut EnableSlot::new()) as *mut _);
        });

        let evt_status = if let EventKind::CommandCompletion(cc) = evt {
            Some(cc.completion_code().unwrap())
        } else {
            log::warn!("Unexpected TRB type: {:?}", evt);
            None
        };

        if let Some(CompletionCode::Success) = evt_status {
            log::info!("Slot {} successfully enabled", slot);
        } else if let Some(evt_status) = evt_status {
            log::warn!(
                "Error attempting to enable slot {}: {:#?}",
                slot,
                evt_status
            );
        } else {
            log::warn!("Incorrect event type received");
        }
    }

    pub fn disable_port_slot(&mut self, slot: u8) {
        self.exec_cmd(slot, |cmd, _| {
            *cmd = CommandKind::from((&mut DisableSlot::new()) as *mut _);
        });

        log::info!("Slot {} successfully disabled", slot);
    }

    pub fn slot_state(&mut self, slot: u8) -> Option<SlotState> {
        let mut slot_state = None;
        self.exec_cmd(slot, |cmd, _| {
            *cmd = CommandKind::from((&mut EvaluateContext::new()) as *mut _);
        });

        if let Some(EventKind::CommandCompletion(evt)) =
            self.event_ring_dequeue.get_mut(slot as usize)
        {
            if evt.slot_id() == slot {
                slot_state = Some(SlotState::from_u32(evt.completion_code().unwrap() as u32));
            }
        }

        slot_state.flatten()
    }

    pub fn address_device<const N: usize>(
        &mut self,
        mut input_ctx: Input<N>,
        idx: usize,
        slot: u8,
    ) -> &'static mut [EventKind<'static>] {
        // borrow checker
        let input_ptr = (&mut input_ctx) as *mut Input<N>;
        let me = self as *mut Self;

        input_ctx.control_mut().set_add_context_flag(0);
        input_ctx.control_mut().set_add_context_flag(1);

        let slot_ctx = input_ctx.device_mut().slot_mut();
        let ctx_entries = 1u8;

        slot_ctx.clear_multi_tt();
        slot_ctx.clear_hub();
        slot_ctx.set_context_entries(ctx_entries);

        let max_exit_latency = 0u16;
        let root_hub_port_num = (idx + 1) as u8;
        let port_count = 0u8;

        slot_ctx.set_max_exit_latency(max_exit_latency);
        slot_ctx.set_root_hub_port_number(root_hub_port_num);
        slot_ctx.set_number_of_ports(port_count);

        let parent_hub_slot_id = 0u8;
        let parent_port_num = 0u8;
        let ttt = 0u8;
        let interrupter = 0u16;

        slot_ctx.set_parent_hub_slot_id(parent_hub_slot_id);
        slot_ctx.set_parent_port_number(parent_port_num);
        slot_ctx.set_tt_think_time(ttt);
        slot_ctx.set_interrupter_target(interrupter);

        let endpoint_ctx = unsafe { &mut *input_ptr }.device_mut().endpoint_mut(0);

        let max_errors = 3u8;
        let endpoint_type = 4u8;
        let max_packet_size = match self.lookup_psie(slot) {
            0 => 8,
            1 => 64,
            2 => 64,
            3 => 512,
            _ => unreachable!(),
        };

        let _host_init_disable = 0u8; // TODO
        let max_burst_size = 0u8; // TODO

        assert_eq!(max_errors & 0b11, max_errors);

        let tr = self.transfer_ring.iter().map(|tr| tr.as_inner());

        endpoint_ctx.set_tr_dequeue_pointer(addr_of!(tr) as u64);
        endpoint_ctx.set_max_packet_size(max_packet_size);
        endpoint_ctx.set_max_burst_size(max_burst_size);
        endpoint_ctx.set_error_count(max_errors);
        endpoint_ctx.set_endpoint_type(EndpointType::from_u8(endpoint_type).unwrap());

        let (evt, _) = unsafe { &mut *me }.exec_cmd(slot, |cmd, _| {
            *cmd = CommandKind::from((&mut AddressDevice::new()) as *mut _);
            if let CommandKind::AddressDevice(cmd) = cmd {
                cmd.set_input_context_pointer(addr_of!(input_ctx) as u64);
            }
        });

        let out = alloc::vec![evt];
        out.leak::<'static>()
    }

    pub fn lookup_psie(&mut self, port: u8) -> u8 {
        let mut out = 0u8;
        self.port_register_set_mut().map(|prs| {
            prs.update_volatile_at(port as usize, |port| {
                out = port.portsc.port_speed().get_bits(4..5);
            });
        });
        out
    }

    pub fn handle_event(
        name: &str,
        cmd: CommandKind<'_>,
        evt: EventKind<'_>,
    ) -> syscall::Result<()> {
        let mut out = Ok(());
        if let EventKind::CommandCompletion(cc) = evt {
            if let Ok(code) = cc.completion_code() {
                if code != CompletionCode::Success {
                    log::error!("{}: Command failed with code {:?}", name, code);
                    out = Err(syscall::Error::new(syscall::EIO));
                } else {
                    log::debug!("{}: Command {:#?} completed successfully", name, cmd);
                }
            } else {
                log::error!(
                    "{}: Command {:#?} failed with unknown/reserved code {:#?}",
                    name,
                    cmd,
                    cc.completion_code().unwrap_err()
                );
                out = Err(syscall::Error::new(syscall::EIO));
            }
        } else {
            log::warn!("Not a command completion TRB");
        };
        out
    }
}

pub enum ControlFlow {
    Continue,
    Break,
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
