// SPDX-License-Identifier: GPL-3.0-or-later
// Partial port of https://github.com/Andy-Python-Programmer/aero/raw/master/src/aero_kernel/src/drivers/pci.rs

use alloc::{rc::Rc, vec};
use spin::RwLock;

use core::{
    iter::Map,
    mem::ManuallyDrop,
    sync::atomic::{AtomicUsize, Ordering},
};

use acpi::AcpiTables;
use conquer_once::spin::OnceCell;
use pcics::{
    capabilities::CapabilityKind,
    header::{self, ClassCode, InterruptPin},
    Capabilities, Header, DDR_OFFSET, ECS_OFFSET,
};
use x86_64::{
    structures::paging::{FrameAllocator, Mapper, Page, Size4KiB},
    VirtAddr,
};

use crate::{
    acpi_impl::{aml_init, aml_route, system_shutdown, KernelAcpi},
    arch::x86_64::interrupts::{self, IDT},
    get_mcfg, mcfg_brute_force,
};

use {
    crate::{ahci::util::VolatileCell, map_page},
    alloc::{alloc::Global, sync::Arc, vec::Vec},
    bit_field::BitField,
    bitflags::bitflags,
    core::{alloc::Allocator, arch::asm},
    x86_64::structures::paging::{OffsetPageTable, PageTableFlags},
};

use itertools::Itertools;
use log::*;

pub const BLOCK_BITS: usize = core::mem::size_of::<usize>() * 8;

pub static PCI_TABLE: RwLock<PciTable> = RwLock::new(PciTable::new());
pub static PCI_DRIVER_COUNT: AtomicUsize = AtomicUsize::new(0);

const fn calculate_blocks(bits: usize) -> usize {
    if bits % BLOCK_BITS == 0 {
        bits / BLOCK_BITS
    } else {
        bits / BLOCK_BITS + 1
    }
}

// Needed for compatibility
#[derive(Debug)]
pub struct Bitmap<A: Allocator> {
    bitmap: Vec<usize, A>,
}

impl<A: Allocator> Bitmap<A> {
    /// Constructs a new bitmap with `size` bits and uses `alloc`
    /// as the alloctor.
    ///
    /// ## Example
    /// ```rust
    /// use alloc::alloc::Global;
    ///
    /// let mut bitmap = Bitmap::new_in(Global, 4096);
    /// ```
    pub fn new_in(alloc: A, size: usize) -> Self {
        let bitmap_blocks = calculate_blocks(size);
        let mut bitmap = Vec::new_in(alloc);

        bitmap.resize(bitmap_blocks, 0);
        Self { bitmap }
    }

    /// Constructs a new, empty bitmap. This function does *not* perform
    /// any allocations.
    ///
    /// ## Example
    /// ```rust
    /// let bitmap = Bitmap::new();
    /// ```
    pub fn empty_in(alloc: A) -> Self {
        Self {
            bitmap: Vec::new_in(alloc),
        }
    }

    /// Sets the bit at the provided `bit_idx` to `yes` (`true` or `false`).
    ///
    /// ## Example
    /// ```rust
    /// use alloc::alloc::Global;
    ///
    /// let mut bitmap = Bitmap::new_in(Global, 4096);
    ///
    /// assert!(!bitmap.is_set(69));
    /// bitmap.set(69, true);
    /// assert!(bitmap.is_set(69));
    /// ```
    pub fn set(&mut self, bit_idx: usize, yes: bool) {
        let (block_idx, mod_bit_idx) = (bit_idx / BLOCK_BITS, bit_idx % BLOCK_BITS);

        self.bitmap
            .get_mut(block_idx)
            .map(|n| n.set_bit(mod_bit_idx, yes));
    }

    /// Returns weather the bit at the provided `bit_idx` is set.
    ///
    /// ## Example
    /// ```rust
    /// use alloc::alloc::Global;
    ///
    /// let bitmap = Bitmap::new_in(Global, 4096);
    /// assert!(!bitmap.is_set(69));
    /// ```
    pub fn is_set(&self, bit_idx: usize) -> bool {
        let (block_idx, mod_bit_idx) = (bit_idx / BLOCK_BITS, bit_idx % BLOCK_BITS);
        let n = self.bitmap[block_idx];

        n.get_bit(mod_bit_idx)
    }

    /// Returns the index of the first unset bit.
    ///
    /// ## Example
    /// ```rust
    /// use alloc::alloc::Global;
    ///
    /// let mut bitmap = Bitmap::new_in(Global, 4096);
    ///
    /// bitmap.set(69, true);
    /// assert_eq!(bitmap.find_first_set(), Some(0));
    /// ```
    pub fn find_first_unset(&self) -> Option<usize> {
        self.bitmap
            .iter()
            .enumerate()
            .map(|(i, block)| {
                let mut block_value = *block;

                if block_value == 0 {
                    i * BLOCK_BITS
                } else {
                    let mut bit = 0;

                    while block_value.get_bit(0) {
                        block_value >>= 1;
                        bit += 1;
                    }

                    (i * BLOCK_BITS) + bit
                }
            })
            .nth(0)
    }

    /// Returns the index of the first set bit.
    ///
    /// ## Example
    /// ```rust
    /// use alloc::alloc::Global;
    ///
    /// let mut bitmap = Bitmap::new_in(Global, 4096);
    ///
    /// bitmap.set(69, true);
    /// assert_eq!(bitmap.find_first_set(), Some(69));
    /// ```
    pub fn find_first_set(&self) -> Option<usize> {
        for (i, block) in self.bitmap.iter().enumerate() {
            let mut block_value = *block;

            if block_value != 0 {
                let mut bit = 0;

                // Loop through the bits in the block and find
                // the first set bit.
                while !block_value.get_bit(0) {
                    block_value >>= 1;
                    bit += 1;
                }

                return Some((i * BLOCK_BITS) + bit);
            }
        }

        None
    }
}

bitflags! {
    pub struct ProgramInterface: u8 {
        const PRIMARY_PCI_NATIVE   = 0b00000001;
        const PRIMARY_CAN_SWITCH   = 0b00000010;
        const SECONDARY_PCI_NATIVE = 0b00000100;
        const SECONDARY_CAN_SWITCH = 0b00001000;
        const DMA_CAPABLE          = 0b10000000;
    }
}

#[allow(clippy::missing_safety_doc)] // TODO: document
#[inline]
pub unsafe fn outb(port: u16, value: u8) {
    asm!(
       "out dx, al",
       in("dx") port,
       in("al") value,
       options(preserves_flags, nomem, nostack)
    );
}

#[allow(clippy::missing_safety_doc)] // TODO: document
#[inline]
pub unsafe fn inb(port: u16) -> u8 {
    let ret: u8;

    asm!(
        "in al, dx",
        in("dx") port,
        out("al") ret,
        options(preserves_flags, nomem, nostack)
    );

    ret
}

#[allow(clippy::missing_safety_doc)] // TODO: document
#[inline]
pub unsafe fn outw(port: u16, value: u16) {
    asm!(
        "out dx, ax",
        in("dx") port,
        in("ax") value,
        options(preserves_flags, nomem, nostack)
    );
}

#[allow(clippy::missing_safety_doc)] // TODO: document
#[inline]
pub unsafe fn outl(port: u16, value: u32) {
    asm!(
        "out dx, eax",
        in("dx") port,
        in("eax") value,
        options(preserves_flags, nomem, nostack)
    );
}

#[allow(clippy::missing_safety_doc)] // TODO: document
#[inline]
pub unsafe fn inl(port: u16) -> u32 {
    let ret: u32;

    asm!(
        "in eax, dx",
        in("dx") port,
        out("eax") ret,
        options(nomem, nostack, preserves_flags)
    );

    ret
}

#[allow(clippy::missing_safety_doc)] // TODO: document
#[inline]
pub unsafe fn inw(port: u16) -> u16 {
    let ret: u16;

    asm!(
        "in ax, dx",
        out("ax") ret,
        in("dx") port,
        options(nomem, nostack, preserves_flags)
    );

    ret
}

// const PCI_CONFIG_ADDRESS_PORT: u16 = 0xCF8;
// const PCI_CONFIG_DATA_PORT: u16 = 0xCFC;

#[derive(Debug, PartialEq)]
pub enum Vendor {
    Intel,
    AMD,
    NVIDIA,
    Qemu,
    Broadcom,
    Epson,
    IBM,
    Acer,
    Dell,
    Toshiba,
    HP,
    Asus,
    Hitachi,
    Motorola,
    Apple,
    LG,
    Oracle,
    Adobe,
    DLink,
    Linksys,
    Samsung,
    RedHat,
    Google,
    ATT,
    Qualcomm,
    Lenovo,
    Sapphire,
    Seagate,
    Patriot,
    MSI,
    Ralink,
    TpLink,
    Hauppauge,
    Unknown(u32),
}

impl Vendor {
    pub fn new(id: u32) -> Self {
        match id {
            0x8086 | 0x34ba => Self::Intel,
            0x1002 | 0x1022 => Self::AMD,
            0x10DE | 0x12d2 => Self::NVIDIA,
            0x1234 => Self::Qemu,
            0x1000 | 0x1166 | 0x14e4 | 0x166d | 0x173b | 0x182f | 0xfeda => Self::Broadcom,
            0x1008 => Self::Epson,
            0x1014 => Self::IBM,
            0x1025 | 0x107b => Self::Acer,
            0x1028 | 0x1120 => Self::Dell,
            0x102f | 0x1179 | 0x11e7 | 0x13d7 => Self::Toshiba,
            0x103c | 0x11c0 | 0x1590 | 0xa259 | 0xa25b => Self::HP,
            0x1043 | 0x807d | 0xf043 => Self::Asus,
            0x1020 | 0x1037 | 0x1054 | 0x1250 | 0x1367 | 0x1388 | 0x158c => Self::Hitachi,
            0x1057 | 0x11b7 | 0x1507 | 0x19d1 | 0xc0de => Self::Motorola,
            0x106b => Self::Apple,
            0x107c | 0x122b | 0x1854 => Self::LG,
            0x108e => Self::Oracle,
            0x1173 => Self::Adobe,
            0x07d1 | 0x1186 => Self::DLink,
            0x1737 => Self::Linksys,
            0x1099 | 0x10c3 | 0x11e2 | 0x1249 | 0x144d | 0x167d => Self::Samsung,
            0x1af4 | 0x1b36 | 0x6900 => Self::RedHat,
            0x1ae0 => Self::Google,
            0x18a3 => Self::ATT,
            0x168c | 0x17cb | 0x1969 | 0x5143 => Self::Qualcomm,
            0x17aa | 0x1d49 => Self::Lenovo,
            0x0721 | 0x174b | 0x1da2 => Self::Sapphire,
            0x1bb1 => Self::Seagate,
            0x137e => Self::Patriot,
            0x1462 => Self::MSI,
            0x1804 | 0x1814 => Self::Ralink,
            0x7470 => Self::TpLink,
            0x0070 | 0x0270 | 0x13eb => Self::Hauppauge,
            _ => Self::Unknown(id),
        }
    }

    pub fn is_valid(&self) -> bool {
        match self {
            Self::Unknown(id) => *id != 0xFFFF,
            _ => true,
        }
    }
}

#[derive(Debug, PartialEq)]
pub enum DeviceKind {
    Unknown,

    /*
     * Base Class 0x00 - Devices that predate Class Codes
     */
    LegacyVgaCompatible,
    LegacyNotVgaCompatible,

    /*
     * Base Class 0x01 - Mass Storage Controllers
     */
    ScsiBusController,
    IdeController,
    FloppyController,
    IpiBusController,
    RaidController,
    AtaController,
    SataController,
    SasController,
    NvmeController,
    OtherMassStorageController,

    /*
     * Base Class 0x02 - Network Controllers
     */
    EthernetController,
    TokenRingController,
    FddiController,
    AtmController,
    IsdnController,
    PicmgController,
    OtherNetworkController,

    /*
     * Base Class 0x03 - Display Controllers
     */
    VgaCompatibleController,
    XgaController,
    ThreeDController,
    OtherDisplayController,

    /*
     * Base Class 0x04 - Multimedia Devices
     */
    VideoDevice,
    AudioDevice,
    TelephonyDevice,
    OtherMultimediaDevice,

    /*
     * Base Class 0x05 - Memory Controllers
     */
    RamController,
    FlashController,
    OtherMemoryController,

    /*
     * Base Class 0x06 - Bridge Devices
     */
    HostBridge,
    IsaBridge,
    EisaBridge,
    McaBridge,
    PciPciBridge,
    PcmciaBridge,
    NuBusBridge,
    CardBusBridge,
    RacewayBridge,
    SemiTransparentPciPciBridge,
    InfinibandPciHostBridge,
    OtherBridgeDevice,

    /*
     * Base Class 0x07 - Simple Communications Controllers
     */
    SerialController,
    ParallelPort,
    MultiportSerialController,
    Modem,
    GpibController,
    SmartCard,
    OtherCommunicationsDevice,

    /*
     * Base Class 0x08 - Generic System Peripherals
     */
    InterruptController,
    DmaController,
    SystemTimer,
    RtcController,
    GenericPciHotPlugController,
    SdHostController,
    OtherSystemPeripheral,

    /*
     * Base Class 0x09 - Input Devices
     */
    KeyboardController,
    Digitizer,
    MouseController,
    ScannerController,
    GameportController,
    OtherInputController,

    /*
     * Base Class 0x0a - Docking Stations
     */
    GenericDockingStation,
    OtherDockingStation,

    /*
     * Base Class 0x0b - Processors
     */
    Processor386,
    Processor486,
    ProcessorPentium,
    ProcessorAlpha,
    ProcessorPowerPc,
    ProcessorMips,
    CoProcessor,

    /*
     * Base Class 0x0c - Serial Bus Controllers
     */
    FirewireController,
    AccessBusController,
    SsaBusController,
    UsbController,
    FibreChannelController,
    SmBusController,
    InfiniBandController,
    IpmiController,
    SercosController,
    CanBusController,

    /*
     * Base Class 0x0d - Wireless Controllers
     */
    IrdaController,
    ConsumerIrController,
    RfController,
    BluetoothController,
    BroadbandController,
    Ethernet5GHzController,
    Ethernet24GHzController,
    OtherWirelessController,

    /*
     * Base Class 0x0e - Intelligent IO Controllers
     */
    IntelligentIoController,

    /*
     * Base Class 0x0f - Satellite Communications Controllers
     */
    TvSatelliteCommunicationsController,
    AudioSatelliteCommunicationsController,
    VoiceSatelliteCommunicationsController,
    DataSatelliteCommunicationsController,

    /*
     * Base Class 0x10 - Encryption and Decryption Controllers
     */
    NetworkCryptionController,
    EntertainmentCryptionController,
    OtherCryptionController,

    /*
     * Base Class 0x11 - Data Acquisition and Signal Processing Controllers
     */
    DpioModule,
    PerformanceCounter,
    CommunicationsSynchronizationController,
    ManagementCard,
    OtherSignalProcessingController,
}

impl DeviceKind {
    pub fn new(base_class: u32, sub_class: u32) -> Self {
        match (base_class, sub_class) {
            (0x00, 0x00) => DeviceKind::LegacyNotVgaCompatible,
            (0x00, 0x01) => DeviceKind::LegacyVgaCompatible,

            (0x01, 0x00) => DeviceKind::ScsiBusController,
            (0x01, 0x01) => DeviceKind::IdeController,
            (0x01, 0x02) => DeviceKind::FloppyController,
            (0x01, 0x03) => DeviceKind::IpiBusController,
            (0x01, 0x04) => DeviceKind::RaidController,
            (0x01, 0x05) => DeviceKind::AtaController,
            (0x01, 0x06) => DeviceKind::SataController,
            (0x01, 0x07) => DeviceKind::SasController,
            (0x01, 0x08) => DeviceKind::NvmeController,
            (0x01, 0x80) => DeviceKind::OtherMassStorageController,

            (0x02, 0x00) => DeviceKind::EthernetController,
            (0x02, 0x01) => DeviceKind::TokenRingController,
            (0x02, 0x02) => DeviceKind::FddiController,
            (0x02, 0x03) => DeviceKind::AtmController,
            (0x02, 0x04) => DeviceKind::IsdnController,
            (0x02, 0x06) => DeviceKind::PicmgController,
            (0x02, 0x80) => DeviceKind::OtherNetworkController,

            (0x03, 0x00) => DeviceKind::VgaCompatibleController,
            (0x03, 0x01) => DeviceKind::XgaController,
            (0x03, 0x02) => DeviceKind::ThreeDController,
            (0x03, 0x80) => DeviceKind::OtherDisplayController,

            (0x04, 0x00) => DeviceKind::VideoDevice,
            (0x04, 0x01) => DeviceKind::AudioDevice,
            (0x04, 0x02) => DeviceKind::TelephonyDevice,
            (0x04, 0x03) => DeviceKind::OtherMultimediaDevice,

            (0x05, 0x00) => DeviceKind::RamController,
            (0x05, 0x01) => DeviceKind::FlashController,
            (0x05, 0x02) => DeviceKind::OtherMemoryController,

            (0x06, 0x00) => DeviceKind::HostBridge,
            (0x06, 0x01) => DeviceKind::IsaBridge,
            (0x06, 0x02) => DeviceKind::EisaBridge,
            (0x06, 0x03) => DeviceKind::McaBridge,
            (0x06, 0x04) => DeviceKind::PciPciBridge,
            (0x06, 0x05) => DeviceKind::PcmciaBridge,
            (0x06, 0x06) => DeviceKind::NuBusBridge,
            (0x06, 0x07) => DeviceKind::CardBusBridge,
            (0x06, 0x08) => DeviceKind::RacewayBridge,
            (0x06, 0x09) => DeviceKind::SemiTransparentPciPciBridge,
            (0x06, 0x0a) => DeviceKind::InfinibandPciHostBridge,
            (0x06, 0x80) => DeviceKind::OtherBridgeDevice,

            (0x07, 0x00) => DeviceKind::SerialController,
            (0x07, 0x01) => DeviceKind::ParallelPort,
            (0x07, 0x02) => DeviceKind::MultiportSerialController,
            (0x07, 0x03) => DeviceKind::Modem,
            (0x07, 0x04) => DeviceKind::GpibController,
            (0x07, 0x05) => DeviceKind::SmartCard,
            (0x07, 0x80) => DeviceKind::OtherCommunicationsDevice,

            (0x08, 0x00) => DeviceKind::InterruptController,
            (0x08, 0x01) => DeviceKind::DmaController,
            (0x08, 0x02) => DeviceKind::SystemTimer,
            (0x08, 0x03) => DeviceKind::RtcController,
            (0x08, 0x04) => DeviceKind::GenericPciHotPlugController,
            (0x08, 0x05) => DeviceKind::SdHostController,
            (0x08, 0x80) => DeviceKind::OtherSystemPeripheral,

            (0x09, 0x00) => DeviceKind::KeyboardController,
            (0x09, 0x01) => DeviceKind::Digitizer,
            (0x09, 0x02) => DeviceKind::MouseController,
            (0x09, 0x03) => DeviceKind::ScannerController,
            (0x09, 0x04) => DeviceKind::GameportController,
            (0x09, 0x80) => DeviceKind::OtherInputController,

            (0x0a, 0x00) => DeviceKind::GenericDockingStation,
            (0x0a, 0x80) => DeviceKind::OtherDockingStation,

            (0x0b, 0x00) => DeviceKind::Processor386,
            (0x0b, 0x01) => DeviceKind::Processor486,
            (0x0b, 0x02) => DeviceKind::ProcessorPentium,
            (0x0b, 0x10) => DeviceKind::ProcessorAlpha,
            (0x0b, 0x20) => DeviceKind::ProcessorPowerPc,
            (0x0b, 0x30) => DeviceKind::ProcessorMips,
            (0x0b, 0x40) => DeviceKind::CoProcessor,

            (0x0c, 0x00) => DeviceKind::FirewireController,
            (0x0c, 0x01) => DeviceKind::AccessBusController,
            (0x0c, 0x02) => DeviceKind::SsaBusController,
            (0x0c, 0x03) => DeviceKind::UsbController,
            (0x0c, 0x04) => DeviceKind::FibreChannelController,
            (0x0c, 0x05) => DeviceKind::SmBusController,
            (0x0c, 0x06) => DeviceKind::InfiniBandController,
            (0x0c, 0x07) => DeviceKind::IpmiController,
            (0x0c, 0x08) => DeviceKind::SercosController,
            (0x0c, 0x09) => DeviceKind::CanBusController,

            (0x0d, 0x00) => DeviceKind::IrdaController,
            (0x0d, 0x01) => DeviceKind::ConsumerIrController,
            (0x0d, 0x10) => DeviceKind::RfController,
            (0x0d, 0x11) => DeviceKind::BluetoothController,
            (0x0d, 0x12) => DeviceKind::BroadbandController,
            (0x0d, 0x20) => DeviceKind::Ethernet5GHzController,
            (0x0d, 0x21) => DeviceKind::Ethernet24GHzController,
            (0x0d, 0x80) => DeviceKind::OtherWirelessController,

            (0x0e, 0x00) => DeviceKind::IntelligentIoController,

            (0x0f, 0x00) => DeviceKind::TvSatelliteCommunicationsController,
            (0x0f, 0x01) => DeviceKind::AudioSatelliteCommunicationsController,
            (0x0f, 0x02) => DeviceKind::VoiceSatelliteCommunicationsController,
            (0x0f, 0x03) => DeviceKind::DataSatelliteCommunicationsController,

            (0x10, 0x00) => DeviceKind::NetworkCryptionController,
            (0x10, 0x10) => DeviceKind::EntertainmentCryptionController,
            (0x10, 0x80) => DeviceKind::OtherCryptionController,

            (0x11, 0x00) => DeviceKind::DpioModule,
            (0x11, 0x01) => DeviceKind::PerformanceCounter,
            (0x11, 0x10) => DeviceKind::CommunicationsSynchronizationController,
            (0x11, 0x20) => DeviceKind::ManagementCard,
            (0x11, 0x80) => DeviceKind::OtherSignalProcessingController,

            _ => DeviceKind::Unknown,
        }
    }
}

/// Device handle for open source drivers
///
/// Proprietary drivers must use `redox_syscall` instead, since usermode isn't beholden to GPLv3 the way kernel mode is
pub trait FOSSPciDeviceHandle: Send + Sync {
    fn handles(&self, vendor_id: Vendor, device_id: DeviceKind) -> bool;
    fn start(&self, header: &mut pcics::Header);
}

pub struct PciDevice {
    pub handle: Arc<dyn FOSSPciDeviceHandle>,
}

pub struct PciTable {
    pub devices: Vec<PciDevice>,
    pub raw_headers: Vec<[u8; 64]>,
    pub headers: Vec<Header>,
}

impl PciTable {
    const fn new() -> Self {
        Self {
            devices: Vec::new(),
            raw_headers: Vec::new(),
            headers: Vec::new(),
        }
    }

    pub fn register_headers(&mut self, raw: [u8; 64], header: Header) {
        self.raw_headers.push(raw);
        self.headers.push(header);
    }
}

pub fn register_device_driver(handle: Arc<dyn FOSSPciDeviceHandle>) {
    PCI_TABLE.write().devices.push(PciDevice { handle });
    unsafe {
        *(PCI_DRIVER_COUNT.as_ptr()) = PCI_TABLE.read().devices.len();
    }
}

/// Lookup and initialize all PCI devices.
pub fn init(tables: &AcpiTables<KernelAcpi>) {
    // Check if the MCFG table is avaliable.
    if get_mcfg().is_some() {
        // Initialize AML table only once, not multiple times
        aml_init(tables);
        /*
         * Use the brute force method to go through each possible bus,
         * device, function ID and check if we have a driver for it. If a driver
         * for the PCI device is found then initialize it.
         */
        for dev in mcfg_brute_force() {
            let test_page = Page::<Size4KiB>::containing_address(VirtAddr::new(dev));

            let virt = test_page.start_address().as_u64() + crate::get_phys_offset();

            map_page!(
                dev,
                virt,
                Size4KiB,
                PageTableFlags::PRESENT
                    | PageTableFlags::WRITABLE
                    | PageTableFlags::NO_CACHE
                    | PageTableFlags::WRITE_THROUGH
            );

            let raw_header = unsafe { *(virt as *const [u8; 256]) }; // ECS offset needs to be accounted for

            // borrow checker
            let raw_clone = raw_header;

            let mut header = Header::try_from(raw_header.as_slice()).unwrap();

            // borrow checker
            let header_clone = header.clone();

            PCI_TABLE
                .write()
                .register_headers(*raw_clone.split_array_ref::<64>().0, header_clone);

            if let DeviceKind::Unknown =
                DeviceKind::new(header.class_code.base as u32, header.class_code.sub as u32)
            {
                continue; // don't print unknown devices
            } else {
                info!(
                    "PCI device {:x?}:{:x?} (device={:?}, vendor={:?}) with capabilities pointer {:#x?}",
                    header.vendor_id,
                    header.device_id,
                    DeviceKind::new(header.class_code.base as u32, header.class_code.sub as u32),
                    Vendor::new(header.vendor_id as u32),
                    header.capabilities_pointer
                );
            }

            // borrow checker
            let raw_clone_2 = raw_header.clone();
            let header_clone_2 = Header::try_from(raw_clone_2.as_slice()).unwrap();

            debug!("Interrupt pin: {:#?}", header.interrupt_pin);

            let caps = if header.capabilities_pointer != 0 {
                Some(
                    Capabilities::new(&raw_clone_2[DDR_OFFSET..ECS_OFFSET], &header_clone_2)
                        .map(|cap| cap.ok()),
                )
            } else {
                None
            };

            let msix = if let Some(caps) = caps {
                Some(
                    caps.flatten()
                        .find(|cap| matches!(cap.kind, CapabilityKind::MsiX(_))),
                )
            } else {
                None
            };

            if let Some(msix) = msix {
                info!("MSI-X: {:#?}", msix.map(|m| m.kind));
            }

            for driver in &mut PCI_TABLE.write().devices {
                // can't declare these earlier than this without pissing off the borrow checker

                if driver.handle.handles(
                    Vendor::new(header.vendor_id as u32),
                    DeviceKind::new(header.class_code.base as u32, header.class_code.sub as u32),
                ) {
                    driver.handle.start(&mut header);
                    unsafe {
                        *(PCI_DRIVER_COUNT.as_ptr()) = PCI_TABLE.read().devices.len();
                    }
                }
            }
        }
    } else {
        panic!("MCFG table not present");
    }
}
