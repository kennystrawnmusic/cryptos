#![allow(unused_imports)]
#![allow(unused_variables)]

use core::fmt::Debug;

pub mod fis;
pub mod hba;
pub mod sata;
pub mod satapi;

use {
    self::{
        hba::structs::{HbaMem, HbaPortKind},
        sata::SataDisk,
        satapi::SataPacketInterface,
    },
    alloc::{boxed::Box, vec::Vec},
    log::{error, info},
    syscall::io::Io,
};

/// Refactor/rewrite of Redox's Disk trait
pub trait Disk {
    fn id(&self) -> usize;
    fn size(&mut self) -> u64;
    fn read(&mut self, block: u64, buffer: &mut [u8]) -> syscall::Result<Option<usize>>;
    fn write(&mut self, block: u64, buffer: &mut [u8]) -> syscall::Result<Option<usize>>;
    fn blklen(&mut self) -> syscall::Result<u32>;
}

pub fn all_disks(base: usize) -> (&'static mut HbaMem, Vec<Box<dyn Disk>>) {
    let mem = unsafe { &mut *(base as *mut HbaMem) };
    mem.init();

    let port_impl = mem.port_impl.read();

    let disks = (0..mem.ports.len())
        .filter(|&i| port_impl & 1 << i as i32 == 1 << i as i32)
        .filter_map(|i| {
            let p = unsafe { &mut *(mem.ports.as_mut_ptr().add(i)) };
            let kind = p.probe();
            info!("{:#?}: {:x?}", i, kind);

            let disk: Option<Box<dyn Disk>> = match kind {
                HbaPortKind::SataDrive => match SataDisk::new(i, p) {
                    Ok(disk) => {
                        info!("Found disk with type {:#?}", kind);
                        Some(Box::new(disk))
                    },
                    Err(e) => {
                        error!("Failed to initialize the given SATA disk: {:#?}", e);
                        None
                    }
                },
                HbaPortKind::SataPacketInterface => match SataPacketInterface::new(i, p) {
                    Ok(disk) => {
                        info!("Found disk with type {:#?}", kind);
                        Some(Box::new(disk))
                    },
                    Err(e) => {
                        error!("Failed to initialize the given ATAPI disk: {:#?}", e);
                        None
                    }
                },
                _ => None,
            };
            disk
        })
        .collect::<Vec<_>>();
    (mem, disks)
}
