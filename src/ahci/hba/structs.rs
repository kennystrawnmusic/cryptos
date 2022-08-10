use bitflags::bitflags;
use syscall::io::Mmio;

#[repr(C, packed)]
pub struct HbaPort {
    pub cli_base: [Mmio<u32>; 2],
    pub fis_base: [Mmio<u32>; 2],
    pub interrupt_status: Mmio<u32>,
    pub interrupt_enable: Mmio<u32>,
    pub command: Mmio<u32>,
    pub _rsvd0: Mmio<u32>,
    pub task_file_data: Mmio<u32>,
    pub signature: Mmio<u32>,
    pub sata_status: Mmio<u32>,
    pub sata_ctrl: Mmio<u32>,
    pub sata_err: Mmio<SataErrorRaw>,
    pub sata_active: Mmio<u32>,
    pub cmd_issue: Mmio<u32>,
    pub notification: Mmio<u32>,
    pub fis_switch: Mmio<u32>,
    pub _rsvd1: [Mmio<u32>; 11],
    pub vendor: [Mmio<u32>; 4],
}

#[repr(C, packed)]
pub struct HbaMem {
    pub host_cap: Mmio<u32>,
    pub global_host_control: Mmio<u32>,
    pub interrupt_status: Mmio<u32>,
    pub port_impl: Mmio<u32>,
    pub version: Mmio<u32>,
    pub ccc_ctrl: Mmio<u32>,
    pub ccc_ports: Mmio<u32>,
    pub em_location: Mmio<u32>,
    pub em_ctrl: Mmio<u32>,
    pub host_cap_ext: Mmio<u32>,
    pub handoff_ctrl: Mmio<u32>,
    pub _rsvd0: [Mmio<u8>; 116],
    pub vendor: [Mmio<u8>; 96],
    pub ports: [HbaPort; 32],
}

#[repr(C, packed)]
pub struct HbaPrdtEntry {
    pub data_base: Mmio<u64>,
    pub _rsvd0: Mmio<u32>,
    pub byte_count: Mmio<u32>,
}

#[repr(C, packed)]
pub struct HbaCmdTable {
    pub fis_command: [Mmio<u8>; 64],
    pub atapi_command: [Mmio<u8>; 16],
    pub _rsvd0: [Mmio<u8>; 48],
    pub prdt_entry: [HbaPrdtEntry; 65536],
}

#[repr(C, packed)]
pub struct HbaCmdHeader {
    pub fis_len: Mmio<u8>,
    pub _pmux: Mmio<u8>,
    pub prdt_len: Mmio<u16>,
    pub _prdbc: Mmio<u32>,
    pub cmd_table_base: Mmio<u64>,
    pub _rsvd0: [Mmio<u32>; 4],
}

#[derive(Debug)]
pub enum HbaPortKind {
    None,
    Unknown(u32),
    SataDrive,
    SataPacketInterface,
    PortMultiplier,
    EnclosureManagementBridge,
}

bitflags! {
    pub struct SataErrorRaw: u32 {
        const XCHG = (1 << 26);
        const FIS_UNKNOWN = (1 << 25);
        const TRANSPORT_STATE = (1 << 24);
        const LINK_SEQ = (1 << 23);
        const HANDSHAKE = (1 << 22);
        const CRC = (1 << 21);
        const DISPARITY = (1 << 20);
        const BIT_DEC = (1 << 19);
        const COMM_WAKE = (1 << 18);
        const PHY_INTERNAL = (1 << 17);
        const PHY_RDY_CHG = (1 << 16);
        const INTERNAL = (1 << 11);
        const PROTO = (1 << 10);
        const FS_INTEG = (1 << 9);
        const MEM_INTEG = (1 << 8);
    }
}

#[derive(Clone)]
#[repr(u32)]
pub enum InterruptError {
    TaskFile,
    HostBusFatal,
    HostBusData,
    InterfaceFatal,
    InvalidSlot,
}

#[repr(u32)]
pub enum SataError {
    Exchanged,
    FisKindUnknown,
    TransportState,
    LinkSequence,
    Handshake,
    Crc,
    Disparity,
    BitDecode,
    CommWake,
    PhyInternal,
    PhyRdyChange,
    Internal,
    Protocol,
    FsIntegrity,
    MemIntegrity,
}

// allow use in statics; can't be accessed from IRQ handler otherwise
unsafe impl Send for HbaPort {}
unsafe impl Sync for HbaPort {}
unsafe impl Send for HbaMem {}
unsafe impl Sync for HbaMem {}
unsafe impl Send for HbaPrdtEntry {}
unsafe impl Sync for HbaPrdtEntry {}
unsafe impl Send for HbaCmdTable {}
unsafe impl Sync for HbaCmdTable {}
unsafe impl Send for HbaCmdHeader {}
unsafe impl Sync for HbaCmdHeader {}
unsafe impl Send for HbaPortKind {}
unsafe impl Sync for HbaPortKind {}
unsafe impl Send for SataErrorRaw {}
unsafe impl Sync for SataErrorRaw {}
unsafe impl Send for SataError {}
unsafe impl Sync for SataError {}
unsafe impl Send for InterruptError {}
unsafe impl Sync for InterruptError {}

/// Macro for matching the specific error created by the internal HBA functions and converting it to something POSIX-compliant
#[macro_export]
macro_rules! refactor_hba_int_err {
    ($obj:expr) => {
        if let Err(e) = $obj {
            match e {
                $crate::ahci::hba::structs::InterruptError::InvalidSlot => {
                    *$crate::ahci::hba::EIO_DEBUG.write() =
                        Some(alloc::string::String::from("Slot entry value must be between 0 and 32"));
                    *$crate::ahci::hba::EIO_STATUS.write() = Some($crate::ahci::hba::structs::InterruptError::InvalidSlot.clone());
                    return Err(syscall::Error::new(syscall::EIO));
                }
                $crate::ahci::hba::structs::InterruptError::TaskFile => {
                    *$crate::ahci::hba::EIO_DEBUG.write() = Some(alloc::string::String::from("Task file error"));
                    *$crate::ahci::hba::EIO_STATUS.write() = Some($crate::ahci::hba::structs::InterruptError::TaskFile.clone());
                    return Err(syscall::Error::new(syscall::EIO));
                }
                $crate::ahci::hba::structs::InterruptError::HostBusFatal => {
                    *$crate::ahci::hba::EIO_DEBUG.write() = Some(alloc::string::String::from("Host bus encountered an error (i.e. null pointer) from which it could not recover"));
                    *$crate::ahci::hba::EIO_STATUS.write() = Some($crate::ahci::hba::structs::InterruptError::HostBusFatal.clone());
                    return Err(syscall::Error::new(syscall::EIO));
                }
                $crate::ahci::hba::structs::InterruptError::HostBusData => {
                    *$crate::ahci::hba::EIO_DEBUG.write() = Some(alloc::string::String::from(
                        "Attempted write has been performed using invalid or corrupt data",
                    ));
                    *$crate::ahci::hba::EIO_STATUS.write() = Some($crate::ahci::hba::structs::InterruptError::HostBusData.clone());
                    return Err(syscall::Error::new(syscall::EIO));
                }
                $crate::ahci::hba::structs::InterruptError::InterfaceFatal => {
                    *$crate::ahci::hba::EIO_DEBUG.write() = Some(alloc::string::String::from(
                        "SATA interface encountered an error that it couldn't recover from",
                    ));
                    *$crate::ahci::hba::EIO_STATUS.write() = Some($crate::ahci::hba::structs::InterruptError::InterfaceFatal.clone());
                    return Err(syscall::Error::new(syscall::EIO));
                }
            }
        }
    };
}
