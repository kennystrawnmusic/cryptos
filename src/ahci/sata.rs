use syscall::Io;

use {
    super::{
        hba::structs::{HbaCmdHeader, HbaCmdTable, HbaPort},
        Disk,
    },
    crate::refactor_hba_int_err,
    core::ptr::copy,
    syscall::io::Dma,
};

pub enum BufferKind<'a> {
    Read(&'a mut [u8]),
    Write(&'a [u8]),
}

pub struct Request {
    addr: usize,
    sector_count: usize,
    sector: usize,
    is_running: Option<(u32, usize)>,
}

pub struct SataDisk {
    id: usize,
    port: &'static mut HbaPort,
    len: u64,
    request: Option<Request>,
    cmd_list: Dma<[HbaCmdHeader; 32]>,
    tables: [Dma<HbaCmdTable>; 32],
    _fis_base: Dma<[u8; 256]>,
    buffer: Dma<[u8; 256 * 512]>,
}

// Reference impl: https://gitlab.redox-os.org/redox-os/drivers/-/blob/a38dfb32315a48c069802c300c3c760852771602/ahcid/src/ahci/disk_ata.rs

impl SataDisk {
    pub fn new(id: usize, port: &'static mut HbaPort) -> syscall::Result<Self> {
        let mut cmd_list = unsafe { Dma::zeroed()?.assume_init() };

        let mut tables = [
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
            unsafe { Dma::zeroed()?.assume_init() },
        ];

        let mut fis_base = unsafe { Dma::zeroed()?.assume_init() };
        let buffer = unsafe { Dma::zeroed()?.assume_init() };

        port.init(&mut cmd_list, &mut tables, &mut fis_base);

        let len = port.identify(&mut cmd_list, &mut tables).unwrap_or(0);

        Ok(SataDisk {
            id,
            port,
            len,
            request: None,
            cmd_list,
            tables,
            _fis_base: fis_base,
            buffer,
        })
    }

    pub fn request(&mut self, block: u64, mut kind: BufferKind) -> syscall::Result<Option<usize>> {
        let (write, addr, sectors) = match kind {
            BufferKind::Read(ref buffer) => (false, buffer.as_ptr() as usize, buffer.len() / 512),
            BufferKind::Write(ref buffer) => (true, buffer.as_ptr() as usize, buffer.len() / 512),
        };

        let mut request = match self.request.take() {
            Some(request) => {
                if addr == request.addr && sectors == request.sector_count {
                    request
                } else {
                    // Wait for another request to finish
                    self.request = Some(request);
                    return Ok(None);
                }
            }
            None => Request {
                addr,
                sector_count: sectors,
                sector: 0,
                is_running: None,
            },
        };

        if let Some(running) = request.is_running.take() {
            refactor_hba_int_err!(self.port.sata_stop(running.0));

            if let BufferKind::Read(ref mut buffer) = kind {
                unsafe {
                    copy(
                        buffer.as_ptr().add(request.sector * 512),
                        self.buffer.as_mut_ptr(),
                        running.1 * 512,
                    )
                };
            }

            request.sector += running.1;
        }

        if request.sector < request.sector_count {
            // New request
            let sectors = {
                if request.sector_count - request.sector >= 255 {
                    255
                } else {
                    request.sector_count - request.sector
                }
            };

            if let BufferKind::Write(ref buffer) = kind {
                unsafe {
                    copy(
                        buffer.as_ptr().add(request.sector * 512),
                        self.buffer.as_mut_ptr(),
                        sectors * 512,
                    );
                }
            }

            if let Some(slot) = self.port.sata_dma(
                block + request.sector as u64,
                sectors,
                write,
                &mut self.cmd_list,
                &mut self.tables,
                &mut self.buffer,
            ) {
                request.is_running = Some((slot, sectors));
            }

            self.request = Some(request);
            Ok(None)
        } else {
            Ok(Some(request.sector * 512))
        }
    }
}

impl Disk for SataDisk {
    fn id(&self) -> usize {
        self.id
    }

    fn size(&mut self) -> u64 {
        self.len
    }

    fn read(&mut self, block: u64, buffer: &mut [u8]) -> syscall::Result<Option<usize>> {
        self.request(block, BufferKind::Read(buffer))
    }

    fn write(&mut self, block: u64, buffer: &mut [u8]) -> syscall::Result<Option<usize>> {
        self.request(block, BufferKind::Write(buffer))
    }

    fn blklen(&mut self) -> syscall::Result<u32> {
        Ok(512)
    }

    fn write_interrupt_status(&mut self, status: u32) {
        self.port.interrupt_status.write(status);
    }

    fn read_interrupt_status(&mut self) -> u32 {
        self.port.interrupt_status.read()
    }
}

unsafe impl Send for SataDisk {}
unsafe impl Sync for SataDisk {}
