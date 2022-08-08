// TODO: document these
// Reference: https://gitlab.redox-os.org/redox-os/drivers/-/blob/master/ahcid/src/ahci/hba.rs

pub const DMA_ATA_CMD_READ: u8 = 0x25;
pub const DMA_ATA_CMD_WRITE: u8 = 0x35;
pub const ID_ATA_CMD: u8 = 0xec;
pub const ID_ATA_PACKET: u8 = 0xa1;
pub const CMD_ATA_PACKET: u8 = 0xa0;
pub const ATA_DEV_BUSY: u8 = 0x80;
pub const ATA_DEV_REQUEST: u8 = 0x08;

pub const HBA_PORT_CMD_CR: u32 = 1 << 15;
pub const HBA_PORT_CMD_FR: u32 = 1 << 14;
pub const HBA_PORT_CMD_FRE: u32 = 1 << 4;
pub const HBA_PORT_CMD_ST: u32 = 1;
pub const HBA_PORT_IS_ERR: u32 = 1 << 30 | 1 << 29 | 1 << 28 | 1 << 27;
pub const HBA_SATA_STATUS_PRESENT: u32 = 0x3;
pub const HBA_SIG_ATA: u32 = 0x0000_0101;
pub const HBA_SIG_ATAPI: u32 = 0xeb14_0101;
pub const HBA_SIG_PM: u32 = 0x9669_0101;
pub const HBA_SIG_SEMB: u32 = 0xc33c_0101;

pub const SCSI_READ_CAP: u8 = 0x25;
pub const SCSI_READ10: u8 = 0x28;
pub const SCSI_WRITE10: u8 = 0x2a;

// Real hardware testers with MCFG access, please add to this
pub const KNOWN_PCI_CONFIG_BASE_ADDRS: [u64; 3] = [
    0xb000_0000, // MSI
    0xe000_0000, // ASUS
    0xf800_0000, // Lenovo
];
