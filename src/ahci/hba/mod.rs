use core::ptr::write_volatile;

use log::debug;

use crate::interrupts::IDT;

pub mod consts;
pub mod structs;

#[allow(unused_imports)]
use {
    super::fis::{self, FisKind},
    crate::PCI_CONFIG,
    acpi::PciConfigRegions,
    alloc::{string::String, vec::Vec},
    bit::BitIndex,
    conquer_once::spin::OnceCell,
    consts::*,
    core::{
        hint::spin_loop,
        mem::size_of,
        ops::DerefMut,
        ptr::{self, write_bytes},
    },
    log::{error, info, trace},
    spin::RwLock,
    structs::*,
    syscall::io::Io,
    x86_64::{
        structures::paging::{
            mapper::MapToError, Mapper, Page, PageTableFlags, PhysFrame, Size4KiB,
        },
        PhysAddr, VirtAddr,
    },
};

// used by the `identify` method only
macro_rules! identify_class {
    ($class:ident, $range:expr, $dest:expr) => {
        let mut $class = alloc::string::String::new();
        for word in $range {
            let d = $dest[word];
            let a = ((d >> 8) as u8) as char;
            if a != '\0' {
                $class.push(a);
            }
            let b = (d as u8) as char;
            if b != '\0' {
                $class.push(b);
            }
        }
    };
}

// Reference impl: https://gitlab.redox-os.org/redox-os/drivers/-/blob/master/ahcid/src/ahci/hba.rs

// Pass all interrupt error status messages into user mode for easy debugging
pub static EIO_DEBUG: RwLock<Option<String>> = RwLock::new(None);

// Same with the enum itself
pub static EIO_STATUS: RwLock<Option<InterruptError>> = RwLock::new(None);

// Also pass the global interrupt status to a static so the IRQ handler can easily access it
pub static GLOBAL_IS: RwLock<Option<u32>> = RwLock::new(None);

impl HbaPort {
    pub fn probe(&self) -> HbaPortKind {
        if self.sata_status.readf(HBA_SATA_STATUS_PRESENT) {
            match self.signature.read() {
                HBA_SIG_ATA => HbaPortKind::SataDrive,
                HBA_SIG_ATAPI => HbaPortKind::SataPacketInterface,
                HBA_SIG_PM => HbaPortKind::PortMultiplier,
                HBA_SIG_SEMB => HbaPortKind::EnclosureManagementBridge,
                signature => HbaPortKind::Unknown(signature),
            }
        } else {
            HbaPortKind::None
        }
    }

    pub fn start(&mut self) {
        while self.command.readf(HBA_PORT_CMD_CR) {
            spin_loop();
        }

        self.command.writef(HBA_PORT_CMD_FRE | HBA_PORT_CMD_ST, true);
    }

    pub fn stop(&mut self) {
        self.command.writef(HBA_PORT_CMD_ST, false);

        while self.command.readf(HBA_PORT_CMD_FR | HBA_PORT_CMD_CR) {
            spin_loop();
        }

        self.command.writef(HBA_PORT_CMD_FRE, false);
    }

    pub fn slot(&self) -> Option<u32> {
        let slots = self.sata_active.read() | self.cmd_issue.read();

        for entry in 0..32 {
            if slots & 1 << entry == 0 {
                return Some(entry);
            }
        }
        None
    }

    pub fn init(
        &mut self,
        cmd_list: &mut [HbaCmdHeader; 32],
        tables: &mut [HbaCmdTable; 32],
        fis_base: &mut [u8; 256],
    ) {
        self.stop();

        // Populate command table
        for i in 0..32 {
            let header = &mut cmd_list[i];
            header
                .cmd_table_base
                .write(&mut tables[i] as *mut _ as usize as u64);
            header.prdt_len.write(0);
        }

        // Populate command list
        self.cli_base[0].write(cmd_list as *mut _ as usize as u32);
        self.cli_base[1].write(((cmd_list as *mut _ as usize as u64) >> 32) as u32);

        // Populate FIS registers
        self.fis_base[0].write(fis_base as *mut _ as usize as u32);
        self.fis_base[1].write(((fis_base as *mut _ as usize as u64) >> 32) as u32);

        // Retrieve and write back the interrupt status
        let interrupt_status = self.interrupt_status.read();
        self.interrupt_status.write(interrupt_status);

        // Enable interrupts: this is why I have Send and Sync impled for all these structs
        self.interrupt_enable.write(0b10111);

        // Retrieve and write back the SATA error status
        let sata_error = self.sata_err.read();
        self.sata_err.write(sata_error);

        // Disable autosuspend
        let sata_ctrl = self.sata_ctrl.read();
        self.sata_ctrl.write(sata_ctrl);

        // Power on and spin up
        self.command.writef(1 << 2 | 1 << 1, true);

        log::info!(
            "Initialized AHCI with command vector {:#x}",
            self.command.read()
        );
    }

    pub fn sata_start<F>(
        &mut self,
        cmd_list: &mut [HbaCmdHeader; 32],
        tables: &mut [HbaCmdTable; 32],
        callback: F,
    ) -> Option<u32>
    where
        F: FnOnce(
            &mut HbaCmdHeader,
            &mut fis::RegHost2Dev,
            &mut [HbaPrdtEntry; 65536],
            &mut [Mmio<u8>; 16],
        ),
    {
        self.interrupt_status.write(u32::MAX);
        if let Some(s) = self.slot() {
            {
                let header = &mut cmd_list[s as usize];
                header
                    .fis_len
                    .write(((size_of::<fis::RegHost2Dev>)() / size_of::<u32>()) as u8);

                let mut table = &mut tables[s as usize];
                unsafe {
                    write_bytes(
                        table.deref_mut() as *mut HbaCmdTable as *mut u8,
                        0,
                        size_of::<HbaCmdTable>(),
                    );
                }

                let fis_command =
                    unsafe { &mut *(table.fis_command.as_mut_ptr() as *mut fis::RegHost2Dev) };
                fis_command.kind.write(FisKind::Host2Dev as u8);

                let prdt_entry = unsafe { &mut *(&mut table.prdt_entry as *mut _) };
                let atapi_command = unsafe { &mut *(&mut table.atapi_command as *mut _) };

                callback(header, fis_command, prdt_entry, atapi_command)
            }
            while self
                .task_file_data
                .readf((ATA_DEV_BUSY | ATA_DEV_REQUEST) as u32)
            {
                spin_loop();
            }
            self.cmd_issue.writef(1 << s, true);

            // Could see why the Redox team wanted to remove their implementation's start() method:
            // this is the only place where it's ever used
            while self.command.readf(HBA_PORT_CMD_CR) {
                spin_loop();
            }
            self.command
                .writef(HBA_PORT_CMD_FRE | HBA_PORT_CMD_ST, true);

            Some(s)
        } else {
            None
        }
    }

    pub fn sata_running(&self, slot: u32) -> bool {
        (self.cmd_issue.readf(1 << slot) || self.task_file_data.readf(0x80))
            && self.interrupt_status.read() & HBA_PORT_IS_ERR == 0
    }

    pub fn sata_stop(&mut self, slot: u32) -> Result<(), InterruptError> {
        while self.sata_running(slot) {
            spin_loop();
        }
        self.stop();

        let err_status = self.interrupt_status.read() & HBA_PORT_IS_ERR;

        if err_status != 0 {
            // Match the error bits to their respective InterruptError enum entries
            const TFE: u32 = 1 << 30;
            const HBFE: u32 = 1 << 29;
            const HBDE: u32 = 1 << 28;
            const IFE: u32 = 1 << 27;

            match err_status {
                TFE => Err(InterruptError::TaskFile),
                HBFE => Err(InterruptError::HostBusFatal),
                HBDE => Err(InterruptError::HostBusData),
                IFE => Err(InterruptError::InterfaceFatal),
                _ => unreachable!("only have 4 error bits to choose from here"),
            }
        } else {
            Ok(())
        }
    }

    unsafe fn id(
        &mut self,
        command: u8,
        command_list: &mut [HbaCmdHeader; 32],
        tables: &mut [HbaCmdTable; 32],
    ) -> Option<u64> {
        let mut dest: [u16; 256] = [0; 256];

        let slot = self.sata_start(
            command_list,
            tables,
            |header, fis_command, entries, _ata_command| {
                header.prdt_len.write(1);

                let entry = &mut entries[0];
                entry.data_base.write(&mut dest as *mut _ as usize as u64);
                entry.byte_count.write(512 | 1);

                fis_command.pmux.write(1 << 7);
                fis_command.cmd.write(command);
                fis_command.dev.write(0);
                fis_command.count_low.write(1);
                fis_command.count_high.write(0);
            },
        )?;

        match self.sata_stop(slot) {
            Ok(()) => {
                // Clean up any previous errors that may have been pushed to the statics
                if EIO_DEBUG.read().is_some() {
                    *EIO_DEBUG.write() = None;
                }
                if EIO_STATUS.read().is_some() {
                    *EIO_STATUS.write() = None;
                }

                // here's why we needed that macro: leaves more room in the code for proper error handling
                identify_class!(serial, 10..20, dest);
                identify_class!(firmware, 23..27, dest);
                identify_class!(model, 27..47, dest);

                let mut sectors = (dest[100] as u64)
                    | ((dest[101] as u64) << 16)
                    | ((dest[102] as u64) << 32)
                    | ((dest[103] as u64) << 48);

                let lba_bits = if sectors == 0 {
                    sectors = (dest[60] as u64) | ((dest[61] as u64) << 16);
                    28
                } else {
                    48
                };

                info!("Serial identifier: {:#?}", serial);
                info!("Firmware identifier: {:#?}", firmware);
                info!("Model identifier: {:#?}", model);
                info!("{:#?}-bit LBA", lba_bits);
                info!("Size: {:#?} MB", sectors / 2048);

                Some(sectors * 512)
            }
            Err(e) => match e {
                InterruptError::TaskFile => {
                    *EIO_DEBUG.write() = Some(String::from("Task file error"));
                    *EIO_STATUS.write() = Some(InterruptError::TaskFile.clone());
                    None
                }
                InterruptError::HostBusFatal => {
                    *EIO_DEBUG.write() = Some(String::from("Host bus encountered an error (i.e. null pointer) from which it could not recover"));
                    *EIO_STATUS.write() = Some(InterruptError::HostBusFatal.clone());
                    None
                }
                InterruptError::HostBusData => {
                    *EIO_DEBUG.write() = Some(String::from(
                        "Attempted write has been performed using invalid or corrupt data",
                    ));
                    *EIO_STATUS.write() = Some(InterruptError::HostBusData.clone());
                    None
                }
                InterruptError::InterfaceFatal => {
                    *EIO_DEBUG.write() = Some(String::from(
                        "SATA interface encountered an error that it couldn't recover from",
                    ));
                    *EIO_STATUS.write() = Some(InterruptError::InterfaceFatal.clone());
                    None
                }
                _ => unreachable!(),
            },
        }
    }

    pub fn identify(
        &mut self,
        command_list: &mut [HbaCmdHeader; 32],
        tables: &mut [HbaCmdTable; 32],
    ) -> Option<u64> {
        unsafe { self.id(ID_ATA_CMD, command_list, tables) }
    }

    pub fn identify_packet(
        &mut self,
        command_list: &mut [HbaCmdHeader; 32],
        tables: &mut [HbaCmdTable; 32],
    ) -> Option<u64> {
        unsafe { self.id(ID_ATA_PACKET, command_list, tables) }
    }

    pub fn sata_dma(
        &mut self,
        block: u64,
        sectors: usize,
        write: bool,
        cmd_list: &mut [HbaCmdHeader; 32],
        tables: &mut [HbaCmdTable; 32],
        buffer: &mut [u8; 256 * 512],
    ) -> Option<u32> {
        log::trace!(
            "AHCI control address: {:#x}",
            (self as *mut HbaPort) as usize
        );
        log::trace!("DMA block address: {:#x}", block);
        log::trace!("Sector count: {:#?}", sectors);
        log::trace!("Is write command? {:#?}", write);

        // Doing this a better way than by asserting: actually print something legible without panicking
        if sectors == 0 {
            error!("Must specify at least one sector");
            return None;
        } else if sectors > 256 {
            error!("Sector count too large");
            return None;
        }

        self.sata_start(
            cmd_list,
            tables,
            |header, fis_cmd, prdt_entries, _ata_command| {
                if write {
                    let fis_len = header.fis_len.read();
                    header.fis_len.write(fis_len | 1 << 7 | 1 << 6);
                }

                header.prdt_len.write(1);

                let prdt_entry = &mut prdt_entries[0];
                prdt_entry.data_base.write(buffer as *mut _ as usize as u64);
                prdt_entry.byte_count.write(((sectors * 512) as u32) | 1);

                fis_cmd.pmux.write(1 << 7);

                if write {
                    fis_cmd.cmd.write(DMA_ATA_CMD_WRITE);
                } else {
                    fis_cmd.cmd.write(DMA_ATA_CMD_READ);
                }

                fis_cmd.lba0.write(block as u8);
                fis_cmd.lba1.write((block >> 8) as u8);
                fis_cmd.lba2.write((block >> 16) as u8);

                fis_cmd.dev.write(1 << 6);

                fis_cmd.lba3.write((block >> 24) as u8);
                fis_cmd.lba4.write((block > 32) as u8);
                fis_cmd.lba5.write((block >> 40) as u8);

                fis_cmd.count_low.write(sectors as u8);
                fis_cmd.count_high.write((sectors >> 8) as u8);
            },
        )
    }
    pub fn satapi_dma(
        &mut self,
        command: &[u8; 16],
        len: u32,
        list_base: &mut [HbaCmdHeader; 32],
        tables: &mut [HbaCmdTable; 32],
        buffer: &mut [u8; 256 * 512],
    ) -> Result<(), InterruptError> {
        let slot = self
            .sata_start(
                list_base,
                tables,
                |header, fis_cmd, prdt_entries, ata_command| {
                    let fis_len = header.fis_len.read();
                    header.fis_len.write(fis_len | 1 << 5);

                    header.prdt_len.write(1);

                    let prdt_entry = &mut prdt_entries[0];
                    prdt_entry.data_base.write(buffer as *mut _ as usize as u64);
                    prdt_entry.byte_count.write(len - 1);

                    fis_cmd.pmux.write(1 << 7);
                    fis_cmd.cmd.write(0);
                    fis_cmd.dev.write(0);
                    fis_cmd.lba1.write(0);
                    fis_cmd.lba2.write(0);
                    fis_cmd.feat_low.write(1);
                    fis_cmd.feat_high.write(0);

                    unsafe {
                        write_volatile(ata_command.as_mut_ptr() as *mut [u8; 16], *command);
                    }
                },
            ) // only need the InvalidSlot variant for this one case, but still need it anyway to satisfy the compiler
            .ok_or(InterruptError::InvalidSlot)?;
        match self.sata_stop(slot) {
            // TODO: find a better way to do this
            Ok(()) => Ok(()),
            Err(e) => match e {
                InterruptError::TaskFile => Err(InterruptError::TaskFile),
                InterruptError::HostBusFatal => Err(InterruptError::HostBusFatal),
                InterruptError::HostBusData => Err(InterruptError::HostBusData),
                InterruptError::InterfaceFatal => Err(InterruptError::InterfaceFatal),
                _ => unreachable!(),
            },
        }
    }
}

impl HbaMem {
    pub fn init(&mut self) {
        self.global_host_control.write(1 << 31 | 1 << 1);

        info!("Initializing memory space for disk access");
        info!("Base host capability pointer: {:#x}", self.host_cap.read());
        info!(
            "Global host control pointer: {:#x}",
            self.global_host_control.read()
        );
        info!("Interrupt status: {:#x}", self.interrupt_status.read());
        *GLOBAL_IS.write() = Some(self.interrupt_status.read().clone());

        info!("Port implementation pointer: {:#x}", self.port_impl.read());

        info!("Version: {:#x}", self.version.read());
        info!(
            "Extended host capability pointer: {:#x}",
            self.host_cap_ext.read()
        );
        info!(
            "BIOS/OS handoff controller pointer: {:#x}",
            self.handoff_ctrl.read()
        );

        // Write back the value from the interrupt handler to satisfy the controller
        self.interrupt_status.write(GLOBAL_IS.read().unwrap());
    }
}
