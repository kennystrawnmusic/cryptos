// SPDX-License-Identifier: GPL-3.0-or-later
// Partial port of https://github.com/Andy-Python-Programmer/aero/raw/master/src/aero_kernel/src/drivers/pci.rs

use crate::apic_impl::LOCAL_APIC;

use {
    alloc::{alloc::Global, vec::Vec},
    bit_field::BitField,
    bitflags::bitflags,
    core::{alloc::Allocator, arch::asm},
    x86_64::structures::paging::OffsetPageTable,
    crate::ahci::util::{sync::Mutex, VolatileCell},
};

pub const BLOCK_BITS: usize = core::mem::size_of::<usize>() * 8;

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
    pub fn empty(alloc: A) -> Self {
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
        for (i, block) in self.bitmap.iter().enumerate() {
            let mut block_value = *block;

            if block_value == 0 {
                return Some(i * BLOCK_BITS);
            }

            let mut bit = 0;

            // Loop through the bits in the block and find
            // the first unset bit.
            while block_value.get_bit(0) {
                block_value >>= 1;
                bit += 1;
            }

            return Some((i * BLOCK_BITS) + bit);
        }

        None
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

pub struct CapabilityIter<'a> {
    offset: u32,
    header: &'a PciHeader,
}

impl<'a> CapabilityIter<'a> {
    fn new(device: &'a PciHeader, offset: u32) -> Self {
        Self {
            offset,
            header: device,
        }
    }
}

impl<'a> Iterator for CapabilityIter<'a> {
    type Item = (u32, Capability);

    fn next(&mut self) -> Option<Self::Item> {
        if self.offset == 0 {
            return None;
        }

        // Parse the capabilities linked-list.
        //
        // 15           8 7             0
        // ------------------------------
        // Next Pointer | Capability ID |
        // ------------------------------
        let id = unsafe { self.header.read::<u8>(self.offset) };
        let capability = match id {
            0x5 => Capability::Msi,
            0x11 => Capability::Msix,

            _ => Capability::Unknown,
        };

        let old_offset = self.offset;
        self.offset = unsafe { self.header.read::<u8>(self.offset + 1) };

        Some((old_offset, capability))
    }
}

#[derive(PartialEq, Debug)]
pub enum Capability {
    Msi,
    Msix,

    Unknown,
}

#[repr(C)]
struct Message {
    addr_lower: VolatileCell<u32>,
    addr_upper: VolatileCell<u32>,
    data: VolatileCell<u32>,
    mask: VolatileCell<u32>,
}

impl Message {
    fn is_masked(&self) -> bool {
        self.mask.get().get_bit(0)
    }

    fn set_masked(&self, masked: bool) {
        self.mask.set(*self.mask.get().set_bit(0, masked));
    }

    fn set(&mut self, vector: u8) {
        assert!(self.is_masked(), "msix: message is unmasked");

        let mut data = 0;
        data.set_bits(0..8, vector as u32);

        let mut addr = 0;
        addr.set_bits(12..20, unsafe { LOCAL_APIC.lock().as_ref().unwrap().id().clone() } as u32);
        addr.set_bits(20..32, 0xfee);

        self.data.set(data);
        self.addr_lower.set(addr);
        self.addr_upper.set(0);
    }
}

pub struct Msix<'a> {
    messages: &'a mut [Message],
    table: Bitmap<Global>,
}

impl<'a> Msix<'a> {
    pub fn new(header: &'a PciHeader, offset: u32) -> Self {
        let mut message_control = unsafe { header.read::<u16>(offset + 2) } as u16;

        // 31             16 15           8 7             0
        // ------------------------------------------------
        // Message Control | Next Pointer | Capability ID |
        // -----------------------------------------------
        //
        // XXX: table length is encoded as N - 1, so we add one to get N.
        let table_length = message_control.get_bits(0..11) + 1;

        let table_ptr = unsafe { header.read::<u32>(offset + 4) };
        // BAR index specifies the BAR number whose address range contains the MSI-X Table.
        let bar_index = table_ptr.get_bits(0..3) as u8;
        let bar_offset = table_ptr & !0b111;

        let bar = header
            .get_bar(bar_index)
            .expect("msix: table bar not present");

        let bar_address = match bar {
            Bar::Memory64 { address, .. } => address,
            Bar::Memory32 { address, .. } => address as u64,
            _ => unreachable!(),
        };

        // SAFETY: We have exclusive access to the BAR and the slice is in bounds.
        let messages = unsafe {
            core::slice::from_raw_parts_mut(
                (bar_address + bar_offset as u64) as *mut Message,
                table_length as usize,
            )
        };

        unsafe {
            message_control.set_bit(15, true); // enable MSI-X
            message_control.set_bit(14, false); // function mask

            header.write::<u16>(offset + 2, message_control as u32);
        }

        Self {
            messages,
            table: Bitmap::new_in(Global, table_length as usize),
        }
    }

    pub fn set(&mut self, vector: u8) -> usize {
        let msix_vector = self
            .table
            .find_first_unset()
            .expect("msix: no free vectors");

        self.table.set(msix_vector, true);

        let message = &mut self.messages[msix_vector];
        message.set(vector);
        message.set_masked(false);

        msix_vector
    }
}

#[derive(Clone, Copy, Debug)]
pub enum Bar {
    Memory32 {
        address: u32,
        size: u32,
        prefetchable: bool,
    },

    Memory64 {
        address: u64,
        size: u64,
        prefetchable: bool,
    },

    IO(u32),
}

#[inline]
pub unsafe fn outb(port: u16, value: u8) {
    asm!(
       "out dx, al",
       in("dx") port,
       in("al") value,
       options(preserves_flags, nomem, nostack)
    );
}

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

#[inline]
pub unsafe fn outw(port: u16, value: u16) {
    asm!(
        "out dx, ax",
        in("dx") port,
        in("ax") value,
        options(preserves_flags, nomem, nostack)
    );
}

#[inline]
pub unsafe fn outl(port: u16, value: u32) {
    asm!(
        "out dx, eax",
        in("dx") port,
        in("eax") value,
        options(preserves_flags, nomem, nostack)
    );
}

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

const PCI_CONFIG_ADDRESS_PORT: u16 = 0xCF8;
const PCI_CONFIG_DATA_PORT: u16 = 0xCFC;

#[derive(Debug, PartialEq)]
pub enum Vendor {
    Intel,
    AMD,
    NVIDIA,
    Qemu,
    Unknown(u32),
}

impl Vendor {
    pub fn new(id: u32) -> Self {
        match id {
            0x8086 => Self::Intel,
            0x1022 => Self::AMD,
            0x10DE => Self::NVIDIA,
            0x1234 => Self::Qemu,
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
pub struct PciHeader(u32);

impl PciHeader {
    pub fn new(bus: u8, device: u8, function: u8) -> Self {
        let mut result: u32 = 0;

        result.set_bits(0..3, function as u32);
        result.set_bits(3..8, device as u32);
        result.set_bits(8..16, bus as u32);
        result.set_bits(16..32, 0);

        Self(result)
    }

    pub fn bus(&self) -> u8 {
        self.0.get_bits(8..16) as u8
    }

    pub fn device(&self) -> u8 {
        self.0.get_bits(3..8) as u8
    }

    pub fn function(&self) -> u8 {
        self.0.get_bits(0..3) as u8
    }

    pub unsafe fn read<T>(&self, offset: u32) -> u32 {
        let bus = self.bus() as u32;
        let device = self.device() as u32;
        let func = self.function() as u32;
        let address = (bus << 16) | (device << 11) | (func << 8) | (offset & 0xFC) | 0x80000000;

        outl(PCI_CONFIG_ADDRESS_PORT, address);

        match core::mem::size_of::<T>() {
            1 => inb(PCI_CONFIG_DATA_PORT) as u32, // u8
            2 => inw(PCI_CONFIG_DATA_PORT) as u32, // u16
            4 => inl(PCI_CONFIG_DATA_PORT),        // u32
            width => unreachable!("unknown PCI read width: `{}`", width),
        }
    }

    unsafe fn write<T>(&self, offset: u32, value: u32) {
        let bus = self.bus() as u32;
        let device = self.device() as u32;
        let func = self.function() as u32;
        let address = (bus << 16) | (device << 11) | (func << 8) | (offset & 0xFC) | 0x80000000;

        outl(PCI_CONFIG_ADDRESS_PORT, address);

        match core::mem::size_of::<T>() {
            1 => outb(PCI_CONFIG_DATA_PORT, value as u8), // u8
            2 => outw(PCI_CONFIG_DATA_PORT, value as u16), // u16
            4 => outl(PCI_CONFIG_DATA_PORT, value),       // u32
            width => unreachable!("unknown PCI write width: `{}`", width),
        }
    }

    /// Enables response to memory accesses on the primary interface that address a device
    /// that resides behind the bridge in both the memory mapped I/O and prefetchable memory
    /// ranges or targets a location within the bridge itself.
    pub fn enable_mmio(&self) {
        // Read the Command Register from the device's PCI Configuration Space, set bit 1
        // (MMIO bit) and write the modified Command Register.
        let command = unsafe { self.read::<u16>(0x04) };

        unsafe { self.write::<u16>(0x04, command | (1 << 1)) }
    }

    /// Enable the bridge to operate as a master on the primary interface for memory and I/O
    /// transactions forwarded from the secondary interface. This allows the PCI device to perform
    /// DMA.
    pub fn enable_bus_mastering(&self) {
        // Read the Command Register from the device's PCI Configuration Space, set bit 2
        // (bus mastering bit) and write the modified Command Register. Note that some BISOs do
        // enable bus mastering by default.
        let command = unsafe { self.read::<u16>(0x04) };

        unsafe { self.write::<u16>(0x04, command | (1 << 2)) }
    }

    /// Returns the value stored in the PCI vendor ID register which is used to identify
    /// the manufacturer of the PCI device.
    pub fn get_vendor(&self) -> Vendor {
        unsafe { Vendor::new(self.read::<u16>(0x00)) }
    }

    pub unsafe fn get_device(&self) -> DeviceType {
        let id = self.read::<u32>(0x08);

        DeviceType::new(id.get_bits(24..32), id.get_bits(16..24))
    }

    pub fn has_multiple_functions(&self) -> bool {
        unsafe { self.read::<u32>(0x0c) }.get_bit(23)
    }

    /// Returnes the value stored in the PCI header type register which is used to
    /// indicate layout for bytes,of the device’s configuration space.
    pub fn get_header_type(&self) -> u8 {
        unsafe { self.read::<u8>(0x0E) as u8 & 0b01111111 }
    }

    pub fn capabilities(&self) -> CapabilityIter {
        let offset = unsafe { self.read::<u8>(0x34) };
        CapabilityIter::new(self, offset)
    }

    pub fn msix(&self) -> Option<Msix> {
        self.capabilities()
            .find(|(_, e)| *e == Capability::Msix)
            .map(|(offset, _)| Msix::new(self, offset))
    }

    /// Returns the value stored in the bar of the provided slot. Returns [`None`] if the
    /// bar is empty.
    pub fn get_bar(&self, bar: u8) -> Option<Bar> {
        debug_assert!(self.get_header_type() == 0); // Ensure header type == 0
        debug_assert!(bar <= 5); // Make sure the bar is valid.

        let offset = 0x10 + (bar as u16) * 4;
        let bar = unsafe { self.read::<u32>(offset.into()) };

        // bit 0:true  - the BAR is in memory
        // bit 0:false - the BAR is in I/O
        if !bar.get_bit(0) {
            let prefetchable = bar.get_bit(3);
            let address = bar.get_bits(4..32) << 4;

            let size = unsafe {
                self.write::<u32>(offset.into(), 0xffffffff);
                let mut readback = self.read::<u32>(offset.into());
                self.write::<u32>(offset.into(), address);

                // If the entire readback value is zero, the BAR is not implemented, so we
                // return `None`.
                if readback == 0x0 {
                    return None;
                }

                readback.set_bits(0..4, 0);
                1 << readback.trailing_zeros()
            };

            match bar.get_bits(1..3) {
                0b00 => Some(Bar::Memory32 {
                    address,
                    size,
                    prefetchable,
                }),

                0b10 => {
                    let address = {
                        let mut address = address as u64;

                        // Get the upper 32 bits of the address.
                        address.set_bits(
                            32..64,
                            unsafe { self.read::<u32>((offset + 4).into()) }.into(),
                        );

                        address
                    };

                    Some(Bar::Memory64 {
                        address,
                        size: size as u64,
                        prefetchable,
                    })
                }

                _ => None,
            }
        } else {
            Some(Bar::IO(bar.get_bits(2..32)))
        }
    }

    // NOTE: The Base Address registers are optional registers used to map internal
    // (device-specific) registers into Memory or I/O Spaces. Refer to the PCI Local Bus
    // Specification for a detailed discussion of base address registers.

    pub fn base_address0(&self) -> u32 {
        unsafe { self.read::<u32>(0x10) }
    }

    pub fn base_address1(&self) -> u32 {
        unsafe { self.read::<u32>(0x14) }
    }

    pub fn base_address2(&self) -> u32 {
        unsafe { self.read::<u32>(0x18) }
    }

    pub fn base_address3(&self) -> u32 {
        unsafe { self.read::<u32>(0x1C) }
    }

    pub fn base_address4(&self) -> u32 {
        unsafe { self.read::<u32>(0x20) }
    }

    pub fn program_interface(&self) -> ProgramInterface {
        let bits = unsafe { self.read::<u8>(0x09) };
        ProgramInterface::from_bits_truncate(bits as u8)
    }
}

#[derive(Debug, PartialEq)]
pub enum DeviceType {
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

impl DeviceType {
    pub fn new(base_class: u32, sub_class: u32) -> Self {
        match (base_class, sub_class) {
            (0x00, 0x00) => DeviceType::LegacyNotVgaCompatible,
            (0x00, 0x01) => DeviceType::LegacyVgaCompatible,

            (0x01, 0x00) => DeviceType::ScsiBusController,
            (0x01, 0x01) => DeviceType::IdeController,
            (0x01, 0x02) => DeviceType::FloppyController,
            (0x01, 0x03) => DeviceType::IpiBusController,
            (0x01, 0x04) => DeviceType::RaidController,
            (0x01, 0x05) => DeviceType::AtaController,
            (0x01, 0x06) => DeviceType::SataController,
            (0x01, 0x07) => DeviceType::SasController,
            (0x01, 0x08) => DeviceType::NvmeController,
            (0x01, 0x80) => DeviceType::OtherMassStorageController,

            (0x02, 0x00) => DeviceType::EthernetController,
            (0x02, 0x01) => DeviceType::TokenRingController,
            (0x02, 0x02) => DeviceType::FddiController,
            (0x02, 0x03) => DeviceType::AtmController,
            (0x02, 0x04) => DeviceType::IsdnController,
            (0x02, 0x06) => DeviceType::PicmgController,
            (0x02, 0x80) => DeviceType::OtherNetworkController,

            (0x03, 0x00) => DeviceType::VgaCompatibleController,
            (0x03, 0x01) => DeviceType::XgaController,
            (0x03, 0x02) => DeviceType::ThreeDController,
            (0x03, 0x80) => DeviceType::OtherDisplayController,

            (0x04, 0x00) => DeviceType::VideoDevice,
            (0x04, 0x01) => DeviceType::AudioDevice,
            (0x04, 0x02) => DeviceType::TelephonyDevice,
            (0x04, 0x03) => DeviceType::OtherMultimediaDevice,

            (0x05, 0x00) => DeviceType::RamController,
            (0x05, 0x01) => DeviceType::FlashController,
            (0x05, 0x02) => DeviceType::OtherMemoryController,

            (0x06, 0x00) => DeviceType::HostBridge,
            (0x06, 0x01) => DeviceType::IsaBridge,
            (0x06, 0x02) => DeviceType::EisaBridge,
            (0x06, 0x03) => DeviceType::McaBridge,
            (0x06, 0x04) => DeviceType::PciPciBridge,
            (0x06, 0x05) => DeviceType::PcmciaBridge,
            (0x06, 0x06) => DeviceType::NuBusBridge,
            (0x06, 0x07) => DeviceType::CardBusBridge,
            (0x06, 0x08) => DeviceType::RacewayBridge,
            (0x06, 0x09) => DeviceType::SemiTransparentPciPciBridge,
            (0x06, 0x0a) => DeviceType::InfinibandPciHostBridge,
            (0x06, 0x80) => DeviceType::OtherBridgeDevice,

            (0x07, 0x00) => DeviceType::SerialController,
            (0x07, 0x01) => DeviceType::ParallelPort,
            (0x07, 0x02) => DeviceType::MultiportSerialController,
            (0x07, 0x03) => DeviceType::Modem,
            (0x07, 0x04) => DeviceType::GpibController,
            (0x07, 0x05) => DeviceType::SmartCard,
            (0x07, 0x80) => DeviceType::OtherCommunicationsDevice,

            (0x08, 0x00) => DeviceType::InterruptController,
            (0x08, 0x01) => DeviceType::DmaController,
            (0x08, 0x02) => DeviceType::SystemTimer,
            (0x08, 0x03) => DeviceType::RtcController,
            (0x08, 0x04) => DeviceType::GenericPciHotPlugController,
            (0x08, 0x05) => DeviceType::SdHostController,
            (0x08, 0x80) => DeviceType::OtherSystemPeripheral,

            (0x09, 0x00) => DeviceType::KeyboardController,
            (0x09, 0x01) => DeviceType::Digitizer,
            (0x09, 0x02) => DeviceType::MouseController,
            (0x09, 0x03) => DeviceType::ScannerController,
            (0x09, 0x04) => DeviceType::GameportController,
            (0x09, 0x80) => DeviceType::OtherInputController,

            (0x0a, 0x00) => DeviceType::GenericDockingStation,
            (0x0a, 0x80) => DeviceType::OtherDockingStation,

            (0x0b, 0x00) => DeviceType::Processor386,
            (0x0b, 0x01) => DeviceType::Processor486,
            (0x0b, 0x02) => DeviceType::ProcessorPentium,
            (0x0b, 0x10) => DeviceType::ProcessorAlpha,
            (0x0b, 0x20) => DeviceType::ProcessorPowerPc,
            (0x0b, 0x30) => DeviceType::ProcessorMips,
            (0x0b, 0x40) => DeviceType::CoProcessor,

            (0x0c, 0x00) => DeviceType::FirewireController,
            (0x0c, 0x01) => DeviceType::AccessBusController,
            (0x0c, 0x02) => DeviceType::SsaBusController,
            (0x0c, 0x03) => DeviceType::UsbController,
            (0x0c, 0x04) => DeviceType::FibreChannelController,
            (0x0c, 0x05) => DeviceType::SmBusController,
            (0x0c, 0x06) => DeviceType::InfiniBandController,
            (0x0c, 0x07) => DeviceType::IpmiController,
            (0x0c, 0x08) => DeviceType::SercosController,
            (0x0c, 0x09) => DeviceType::CanBusController,

            (0x0d, 0x00) => DeviceType::IrdaController,
            (0x0d, 0x01) => DeviceType::ConsumerIrController,
            (0x0d, 0x10) => DeviceType::RfController,
            (0x0d, 0x11) => DeviceType::BluetoothController,
            (0x0d, 0x12) => DeviceType::BroadbandController,
            (0x0d, 0x20) => DeviceType::Ethernet5GHzController,
            (0x0d, 0x21) => DeviceType::Ethernet24GHzController,
            (0x0d, 0x80) => DeviceType::OtherWirelessController,

            (0x0e, 0x00) => DeviceType::IntelligentIoController,

            (0x0f, 0x00) => DeviceType::TvSatelliteCommunicationsController,
            (0x0f, 0x01) => DeviceType::AudioSatelliteCommunicationsController,
            (0x0f, 0x02) => DeviceType::VoiceSatelliteCommunicationsController,
            (0x0f, 0x03) => DeviceType::DataSatelliteCommunicationsController,

            (0x10, 0x00) => DeviceType::NetworkCryptionController,
            (0x10, 0x10) => DeviceType::EntertainmentCryptionController,
            (0x10, 0x80) => DeviceType::OtherCryptionController,

            (0x11, 0x00) => DeviceType::DpioModule,
            (0x11, 0x01) => DeviceType::PerformanceCounter,
            (0x11, 0x10) => DeviceType::CommunicationsSynchronizationController,
            (0x11, 0x20) => DeviceType::ManagementCard,
            (0x11, 0x80) => DeviceType::OtherSignalProcessingController,

            _ => DeviceType::Unknown,
        }
    }
}

pub trait PciDeviceHandle: Send + Sync {
    fn handles(&self, vendor_id: Vendor, device_id: DeviceType) -> bool;
    fn start(&self, header: &PciHeader, offset_table: &mut OffsetPageTable);
}