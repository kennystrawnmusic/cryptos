#![allow(dead_code)]

use core::mem::MaybeUninit;

use alloc::vec::Vec;
use syscall::Io;

use {
    super::{
        hba::{
            consts::{SCSI_READ10, SCSI_READ_CAP, SCSI_WRITE10},
            structs::{HbaCmdHeader, HbaCmdTable, HbaPort},
        },
        Disk,
    },
    crate::refactor_hba_int_err,
    byteorder::{BigEndian, ByteOrder},
    core::ptr::copy,
    syscall::error::{Error, Result, EROFS},
};

pub struct SataPacketInterface {
    id: usize,
    port: &'static mut HbaPort,
    len: u64,
    cmd_list: [HbaCmdHeader; 32],
    tables: [HbaCmdTable; 32],
    _fis_base: [u8; 256],
    buffer: [u8; 256 * 512],
}

impl SataPacketInterface {
    pub fn new(id: usize, port: &'static mut HbaPort) -> Result<Self> {
        let mut cmd_list_new: [_; 32] = (0..32)
            .map(|_| HbaCmdHeader::zeroed())
            .collect::<Vec<_>>()
            .try_into()
            .unwrap_or_else(|_| unreachable!());

        let mut tables_new: [_; 32] = (0..32)
            .map(|_| HbaCmdTable::zeroed())
            .collect::<Vec<_>>()
            .try_into()
            .unwrap_or_else(|_| unreachable!());

        let mut fis_base_new: [u8; 256] = (0..256)
            .map(|_| unsafe { MaybeUninit::zeroed().assume_init() })
            .collect::<Vec<_>>()
            .try_into()
            .unwrap_or_else(|_| unreachable!());
        let mut buffer_new: [u8; 256 * 512] = (0..256 * 512)
            .map(|_| unsafe { MaybeUninit::zeroed().assume_init() })
            .collect::<Vec<_>>()
            .try_into()
            .unwrap_or_else(|_| unreachable!());

        port.init(&mut cmd_list_new, &mut tables_new, &mut fis_base_new);

        let len = port.identify(&mut cmd_list_new, &mut tables_new).unwrap_or(0);

        Ok(SataPacketInterface {
            id,
            port,
            len,
            cmd_list: cmd_list_new,
            tables: tables_new,
            _fis_base: fis_base_new,
            buffer: buffer_new,
        })
    }
    pub fn read_cap(&mut self) -> Result<[u32; 2]> {
        let mut command = [0; 16];
        command[0] = SCSI_READ_CAP;

        refactor_hba_int_err!(self.port.satapi_dma(
            &command,
            8,
            &mut self.cmd_list,
            &mut self.tables,
            &mut self.buffer
        ));

        let count = BigEndian::read_u32(&self.buffer[0..4]) + 1;
        let blklen = BigEndian::read_u32(&self.buffer[4..8]);

        Ok([count, blklen])
    }
}

impl Disk for SataPacketInterface {
    fn id(&self) -> usize {
        self.id
    }

    fn size(&mut self) -> u64 {
        match self.read_cap() {
            Ok([count, blklen]) => (count as u64) * (blklen as u64),
            Err(_) => 0,
        }
    }

    fn read(&mut self, block: u64, buffer: &mut [u8]) -> syscall::Result<Option<usize>> {
        let sector_count = buffer.len() as u32 / self.blklen()?;

        fn read10_cmd(blk: u32, count: u16) -> [u8; 16] {
            let mut command = [0; 16];
            command[0] = SCSI_READ10;

            BigEndian::write_u32(&mut command[2..6], blk as u32);
            BigEndian::write_u16(&mut command[7..9], count as u16);

            command
        }

        let mut sector = 0;
        let len = (256 * 512) / self.blklen()?;
        let buffer_size = len * self.blklen()?;

        while sector_count - sector >= len {
            let command = read10_cmd(block as u32 + sector, (sector_count - sector) as u16);

            refactor_hba_int_err!(self.port.satapi_dma(
                &command,
                buffer_size,
                &mut self.cmd_list,
                &mut self.tables,
                &mut self.buffer
            ));

            unsafe {
                copy(
                    self.buffer.as_ptr(),
                    buffer
                        .as_mut_ptr()
                        .offset(sector as isize * self.blklen()? as isize),
                    buffer_size as usize,
                );
            }
            sector += self.blklen()?;
        }

        if sector < sector_count {
            let command = read10_cmd(block as u32 + sector, len as u16);

            refactor_hba_int_err!(self.port.satapi_dma(
                &command,
                buffer_size,
                &mut self.cmd_list,
                &mut self.tables,
                &mut self.buffer
            ));

            unsafe {
                copy(
                    self.buffer.as_mut_ptr(),
                    buffer
                        .as_mut_ptr()
                        .offset(sector as isize * self.blklen()? as isize),
                    buffer_size as usize,
                );
            }

            sector += sector_count - sector;
        }

        Ok(Some((sector * self.blklen()?) as usize))
    }

    fn write(&mut self, block: u64, buffer: &mut [u8]) -> syscall::Result<Option<usize>> {
        // TODO: figure out how to refactor this as a macro without pissing off the compiler

        let sector_count = buffer.len() as u32 / self.blklen()?;

        fn write10_cmd(blk: u32, count: u16) -> [u8; 16] {
            let mut command = [0; 16];
            command[0] = SCSI_WRITE10;

            BigEndian::write_u32(&mut command[2..6], blk as u32);
            BigEndian::write_u16(&mut command[7..9], count as u16);

            command
        }

        let mut sector = 0;
        let len = (256 * 512) / self.blklen()?;
        let buffer_size = len * self.blklen()?;

        while sector_count - sector >= len {
            let command = write10_cmd(block as u32 + sector, (sector_count - sector) as u16);

            refactor_hba_int_err!(self.port.satapi_dma(
                &command,
                buffer_size,
                &mut self.cmd_list,
                &mut self.tables,
                &mut self.buffer
            ));

            unsafe {
                copy(
                    self.buffer.as_ptr(),
                    buffer
                        .as_mut_ptr()
                        .offset(sector as isize * self.blklen()? as isize),
                    buffer_size as usize,
                );
            }
            sector += self.blklen()?;
        }

        if sector < sector_count {
            let command = write10_cmd(block as u32 + sector, len as u16);

            refactor_hba_int_err!(self.port.satapi_dma(
                &command,
                buffer_size,
                &mut self.cmd_list,
                &mut self.tables,
                &mut self.buffer
            ));

            unsafe {
                copy(
                    self.buffer.as_mut_ptr(),
                    buffer
                        .as_mut_ptr()
                        .offset(sector as isize * self.blklen()? as isize),
                    buffer_size as usize,
                );
            }

            sector += sector_count - sector;
        }

        Ok(Some((sector * self.blklen()?) as usize))
    }

    fn blklen(&mut self) -> syscall::Result<u32> {
        Ok(self.read_cap()?[1])
    }

    fn write_interrupt_status(&mut self, status: u32) {
        self.port.interrupt_status.write(status);
    }

    fn read_interrupt_status(&mut self) -> u32 {
        self.port.interrupt_status.read()
    }
}

unsafe impl Send for SataPacketInterface {}
unsafe impl Sync for SataPacketInterface {}
