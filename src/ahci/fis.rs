use alloc::vec::Vec;
use syscall::io::Mmio;

#[repr(u8)]
pub enum FisKind {
    Host2Dev = 0x27,
    Dev2Host = 0x34,
    DmaInit = 0x39,
    DmaSetup = 0x41,
    Data = 0x46,
    Bist = 0x58,
    PioSetup = 0x5f,
    DevBits = 0xa1,
}

#[repr(C, packed)]
pub struct RegHost2Dev {
    pub kind: Mmio<u8>,
    pub pmux: Mmio<u8>,
    pub cmd: Mmio<u8>,
    pub feat_low: Mmio<u8>,
    pub lba0: Mmio<u8>,
    pub lba1: Mmio<u8>,
    pub lba2: Mmio<u8>,
    pub dev: Mmio<u8>,
    pub lba3: Mmio<u8>,
    pub lba4: Mmio<u8>,
    pub lba5: Mmio<u8>,
    pub feat_high: Mmio<u8>,
    pub count_low: Mmio<u8>,
    pub count_high: Mmio<u8>,
    pub isochronous: Mmio<u8>,
    pub ctrl: Mmio<u8>,
    pub _rsvd0: [Mmio<u8>; 4],
}

#[repr(C, packed)]
pub struct RegDev2Host {
    pub kind: Mmio<u8>,
    pub pmux: Mmio<u8>,
    pub status: Mmio<u8>,
    pub err: Mmio<u8>,
    pub lba0: Mmio<u8>,
    pub lba1: Mmio<u8>,
    pub lba2: Mmio<u8>,
    pub dev: Mmio<u8>,
    pub lba3: Mmio<u8>,
    pub lba4: Mmio<u8>,
    pub lba5: Mmio<u8>,
    pub _rsvd0: Mmio<u8>,
    pub count_low: Mmio<u8>,
    pub count_high: Mmio<u8>,
    pub _rsvd1: [Mmio<u8>; 6],
}

#[repr(C, packed)]
pub struct Data {
    pub kind: Mmio<u8>,
    pub pmux: Mmio<u8>,
    pub _rsvd0: [Mmio<u8>; 2],
    pub payload: [Mmio<u8>; 252],
}

#[repr(C, packed)]
pub struct PioSetup {
    pub kind: Mmio<u8>,
    pub pmux: Mmio<u8>,
    pub status: Mmio<u8>,
    pub err: Mmio<u8>,
    pub lba0: Mmio<u8>,
    pub lba1: Mmio<u8>,
    pub lba2: Mmio<u8>,
    pub dev: Mmio<u8>,
    pub lba3: Mmio<u8>,
    pub lba4: Mmio<u8>,
    pub lba5: Mmio<u8>,
    pub _rsvd0: Mmio<u8>,
    pub count_low: Mmio<u8>,
    pub count_high: Mmio<u8>,
    pub _rsvd1: Mmio<u8>,
    pub err_val: Mmio<u8>,
    pub transfer_count: Mmio<u16>,
    pub _rsvd4: [Mmio<u8>; 2],
}

#[repr(C, packed)]
pub struct DmaSetup {
    pub kind: Mmio<u8>,
    pub pmux: Mmio<u8>,
    pub _rsvd0: [Mmio<u8>; 2],
    pub buf_id: Mmio<u64>,
    pub _rsvd1: Mmio<u32>,
    pub offset: Mmio<u32>,
    pub count: Mmio<u32>,
    pub _rsvd2: Mmio<u32>,
}

// allow use in statics; can't be accessed from IRQ handler otherwise
unsafe impl Send for FisKind {}
unsafe impl Sync for FisKind {}
unsafe impl Send for RegHost2Dev {}
unsafe impl Sync for RegHost2Dev {}
unsafe impl Send for RegDev2Host {}
unsafe impl Sync for RegDev2Host {}
unsafe impl Send for Data {}
unsafe impl Sync for Data {}
unsafe impl Send for PioSetup {}
unsafe impl Sync for PioSetup {}
unsafe impl Send for DmaSetup {}
unsafe impl Sync for DmaSetup {}
