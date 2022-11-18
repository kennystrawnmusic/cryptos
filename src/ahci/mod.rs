#![allow(unused_imports)]
#![allow(unused_variables)]

use core::{fmt::Debug, ptr::addr_of};

use x86_64::{
    structures::paging::{Mapper, Page, PageTableFlags, Size2MiB, Size4KiB, Size1GiB},
    VirtAddr,
};

use crate::map_page;

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
///
/// Has added methods for getting and setting the IS bits for easy IRQ handling
pub trait Disk {
    fn id(&self) -> usize;
    fn size(&mut self) -> u64;
    fn read(&mut self, block: u64, buffer: &mut [u8]) -> syscall::Result<Option<usize>>;
    fn write(&mut self, block: u64, buffer: &mut [u8]) -> syscall::Result<Option<usize>>;
    fn blklen(&mut self) -> syscall::Result<u32>;
    fn read_interrupt_status(&mut self) -> u32;
    fn write_interrupt_status(&mut self, status: u32);
}

pub fn all_disks(base: usize) -> (&'static mut HbaMem, Vec<Box<dyn Disk + Send + Sync>>) {
    let mem = unsafe { &mut *(base as *mut HbaMem) };
    mem.init();

    let port_impl = mem.port_impl.read();

    let overflow_test = Page::<Size4KiB>::containing_address(VirtAddr::new(0xfffffff720));
    let overflow_virt = overflow_test.start_address().as_u64();

    map_page!(
        0xfffffff720,
        overflow_virt,
        Size4KiB,
        PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::NO_CACHE
    );

    let disks = (0..mem.ports.len())
        .filter(|&i| port_impl & 1 << i as i32 == 1 << i as i32)
        .filter_map(|i| {
            let p = unsafe { &mut *(mem.ports.as_mut_ptr().add(i)) };
            let kind = p.probe();
            info!("Port {:#?}: {:#x?}", i, kind);

            let disk: Option<Box<dyn Disk + Send + Sync>> = match kind {
                HbaPortKind::SataDrive => match SataDisk::new(i, p) {
                    Ok(disk) => {
                        info!("Found disk with type {:#?}", kind);
                        Some(Box::new(disk))
                    }
                    Err(e) => {
                        error!("Failed to initialize the given SATA disk: {:#?}", e);
                        None
                    }
                },
                HbaPortKind::SataPacketInterface => match SataPacketInterface::new(i, p) {
                    Ok(disk) => {
                        info!("Found disk with type {:#?}", kind);
                        Some(Box::new(disk))
                    }
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
