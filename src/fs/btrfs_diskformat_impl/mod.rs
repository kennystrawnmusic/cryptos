use core::sync::atomic::{AtomicU64, Ordering};

use crate::drivers::ahci::get_ahci;
use alloc::boxed::Box;
use btrfs_diskformat::{constants::PRIMARY_SUPERBLOCK_ADDR, *};
use zerocopy::{U32, U64};

// Define your driver struct
struct BtrfsDriver {
    dev_id: AtomicU64,
}

impl BtrfsDriver {
    // code won't be dead for long
    #[allow(dead_code)]
    pub fn read_superblock(&self, _device: &mut DevItem) -> syscall::Result<SuperBlock> {
        // Read the superblock from the device using the btrfs-diskformat crate
        let mut superblock = unsafe { core::mem::zeroed::<SuperBlock>() };
        let block_sz = core::mem::size_of::<SuperBlock>();

        let _slice = unsafe {
            core::slice::from_raw_parts_mut(&mut superblock as *mut _ as *mut u8, block_sz)
        };

        // TODO: use crate::drivers::ahci to read superblock from device

        Ok(superblock)
    }
    // code won't be dead for long
    #[allow(dead_code)]
    pub fn find_superblock_on_ahci_disk(&self, disk: usize) -> Result<DevItem, &'static str> {
        // Use already-existing AHCI driver to find superblock location at offset 0x10000
        let buffer = unsafe { core::slice::from_raw_parts_mut(Box::into_raw(Box::new(0u8)), 4096) };

        if let Ok(port) = get_ahci().write().port_mut(disk) {
            if let Some(_) = port.read(PRIMARY_SUPERBLOCK_ADDR as usize, buffer) {
                Ok(DevItem {
                    devid: U64::new(self.dev_id.fetch_add(1, Ordering::SeqCst)),
                    total_bytes: U64::new(port.identify().unwrap_or_else(|| 0u64)),
                    bytes_used: U64::new(0), // TODO: use AHCI, XHCI, and planned NVMe drivers to detect this
                    io_align: U32::new(0), // TODO: use AHCI, XHCI, and planned NVMe drivers to detect this
                    io_width: U32::new(0), // TODO: use AHCI, XHCI, and planned NVMe drivers to detect this
                    sector_size: U32::new((port.identify().unwrap_or_else(|| 0u64) % 512) as u32),
                    r#type: U64::new(0), // TODO: use AHCI, XHCI, and planned NVMe drivers to detect this
                    generation: U64::new(0), // TODO: use AHCI, XHCI, and planned NVMe drivers to detect this
                    start_offset: U64::new(0), // TODO: use AHCI, XHCI, and planned NVMe drivers to detect this
                    dev_group: U32::new(0), // TODO: use AHCI, XHCI, and planned NVMe drivers to detect this
                    seek_speed: 0, // TODO: use AHCI, XHCI, and planned NVMe drivers to detect this
                    bandwith: 0,   // TODO: use AHCI, XHCI, and planned NVMe drivers to detect this
                    uuid: [0; 16], // TODO: use AHCI, XHCI, and planned NVMe drivers to detect this
                    fsid: [0; 16], // TODO: use AHCI, XHCI, and planned NVMe drivers to detect this
                })
            } else {
                Err("Failed to read superblock")
            }
        } else {
            Err("Failed to read superblock")
        }
    }
}
