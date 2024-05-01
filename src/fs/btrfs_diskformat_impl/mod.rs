use alloc::boxed::Box;
use btrfs_diskformat::{constants::PRIMARY_SUPERBLOCK_ADDR, *};
use crate::{ahci::{AhciPort, AtaCommand, DmaRequest, HbaMemory, HbaPort}, drivers::ahci::get_ahci};

// Define your driver struct
struct BtrfsDriver {
    // Add your driver-specific fields here
}

impl BtrfsDriver {
    // Implement your driver-specific methods here
    // For example:
    pub fn read_superblock(&self, device: &mut DevItem) -> Result<SuperBlock> {
        // Read the superblock from the device using the btrfs-diskformat crate
        let mut superblock = unsafe { core::mem::zeroed::<SuperBlock>() };
        let block_sz = core::mem::size_of::<SuperBlock>();

        let slice = unsafe {
            core::slice::from_raw_parts_mut(&mut superblock as *mut _ as *mut u8, block_sz)
        };

        // TODO: use crate::drivers::ahci to read superblock from device
        
        Ok(superblock)
    }

    pub fn find_superblock_on_ahci_disk(&self, controller: AhciPort, disk: usize) -> Result<DevItem, &'static str> {
        // Use already-existing AHCI driver to find superblock location at offset 0x10000
        let port = get_ahci().read().port_mut(disk)?;
        let mut buffer = unsafe { core::slice::from_raw_parts_mut(port as *mut u8, 4096) };

        if let Some(sts) = port.read(PRIMARY_SUPERBLOCK_ADDR, buffer) {
            if sts {
                Ok(DevItem {
                    devid: todo!(),
                    total_bytes: todo!(),
                    bytes_used: todo!(),
                    io_align: todo!(),
                    io_width: todo!(),
                    sector_size: todo!(),
                    r#type: todo!(),
                    generation: todo!(),
                    start_offset: todo!(),
                    dev_group: todo!(),
                    seek_speed: todo!(),
                    bandwith: todo!(),
                    uuid: todo!(),
                    fsid: todo!(),
                })
            } else {
                Err("Failed to read superblock")
            }
        } else {
            Err("Failed to read superblock")
        }
    }
}
