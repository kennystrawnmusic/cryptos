#![allow(dead_code)]
use crate::{
    acpi_impl::{KernelAcpi, UserAcpi},
    USER_ACPI,
};

// work in progress!
use super::Scheme;
use core::{
    cmp::min,
    ptr::addr_of,
    sync::atomic::{AtomicBool, AtomicU64, Ordering},
};

use acpi::{AcpiTables, AmlTable};
use alloc::{collections::BTreeMap, vec::Vec};
use log::error;
use spin::{Mutex, Once, RwLock};
use syscall::{
    Error, EventFlags, EACCES, EBADF, EBADFD, EINVAL, EISDIR, ENOENT, EROFS, MODE_CHR, MODE_DIR,
    MODE_FILE, O_ACCMODE, O_CREAT, O_DIRECTORY, O_EXCL, O_RDONLY, O_STAT, O_SYMLINK, SEEK_CUR,
    SEEK_END, SEEK_SET,
};
use x86_64::VirtAddr;

pub struct AcpiScheme;
pub(crate) enum HandleKind {
    TopLevel,
    RootTable,
    ShutdownPipe,
}

pub(crate) struct Handle {
    offset: u64,
    kind: HandleKind,
    stat: AtomicBool,
}

pub(crate) static HANDLES: RwLock<BTreeMap<u64, Handle>> = RwLock::new(BTreeMap::new());
pub(crate) static NEXT: AtomicU64 = AtomicU64::new(0);

pub(crate) static DATA: Once<UserAcpi> = Once::new();

pub(crate) const SIGNATURE: &[u8] = b"rxsdt\nkstop\n";

pub(crate) static WAIT_FLAG: AtomicBool = AtomicBool::new(false);

pub(crate) static SCHID: AtomicU64 = AtomicU64::new(0);

pub(crate) fn acpi_len() -> u64 {
    if let Some(tables) = DATA.get() {
        let data = unsafe {
            let tblptr = addr_of!(tables) as *const u8;

            let raw = core::slice::from_raw_parts(tblptr, core::mem::size_of::<UserAcpi>());
            raw.to_vec()
        };
        data.len() as u64
    } else {
        panic!("ACPI tables not present");
    }
}

impl AcpiScheme {
    pub fn new(id: u64) -> Self {
        let mut data_init = false;
        let mut id_init = false;

        if let Some(user_acpi) = USER_ACPI.get() {
            DATA.call_once(|| {
                data_init = true;
                id_init = true;

                SCHID.store(id, Ordering::SeqCst);
                user_acpi.clone()
            });
        }

        if !data_init || !id_init {
            error!("Scheme initializer called multiple times");
        }

        Self
    }
}

impl Scheme for AcpiScheme {
    fn open(&self, path: &str, flags: usize, uid: u32, _gid: u32) -> syscall::Result<usize> {
        let path = path.trim_start_matches('/');

        if uid != 0 {
            return Err(Error::new(EACCES));
        }

        if flags & O_CREAT == O_CREAT {
            return Err(Error::new(EROFS));
        }

        if flags & O_EXCL == O_EXCL || flags & O_SYMLINK == O_SYMLINK {
            return Err(Error::new(EINVAL));
        }

        if flags & O_ACCMODE != O_RDONLY && flags & O_STAT != O_STAT {
            return Err(Error::new(EROFS));
        }

        let handle_kind = match path {
            "" => {
                if flags & O_DIRECTORY != O_DIRECTORY && flags & O_STAT != O_STAT {
                    return Err(Error::new(EISDIR));
                }

                HandleKind::TopLevel
            }
            "rxsdt" => {
                if flags & O_DIRECTORY != O_DIRECTORY && flags & O_STAT != O_STAT {
                    return Err(Error::new(EISDIR));
                }

                HandleKind::RootTable
            }
            "kstop" => {
                if flags & O_DIRECTORY != O_DIRECTORY && flags & O_STAT != O_STAT {
                    return Err(Error::new(EISDIR));
                }

                HandleKind::ShutdownPipe
            }
            _ => return Err(Error::new(ENOENT)),
        };

        let fd = NEXT.fetch_add(1, Ordering::Relaxed);

        let mut handle_guard = HANDLES.write();
        let stat = AtomicBool::new(flags & O_STAT == O_STAT);

        let _ = handle_guard.insert(
            fd,
            Handle {
                offset: 0,
                kind: handle_kind,
                stat,
            },
        );

        Ok(fd as usize)
    }

    fn fstat(&self, id: usize, stat: &mut syscall::Stat) -> syscall::Result<usize> {
        let handles = HANDLES.read();
        let handle = handles.get(&(id as u64)).ok_or(Error::new(EBADF))?;

        match handle.kind {
            HandleKind::RootTable => {
                let data = unsafe {
                    let tables = DATA.get().ok_or(Error::new(EBADFD))?;
                    let tblptr = addr_of!(tables) as *const u8;

                    let raw = core::slice::from_raw_parts(tblptr, core::mem::size_of::<UserAcpi>());
                    raw.to_vec()
                };

                stat.st_mode = MODE_FILE;
                stat.st_size = data.len().try_into().unwrap_or(u64::MAX);
            }
            HandleKind::TopLevel => {
                stat.st_mode = MODE_DIR;
                stat.st_size = SIGNATURE.len().try_into().unwrap_or(u64::MAX);
            }
            HandleKind::ShutdownPipe => {
                stat.st_mode = MODE_CHR;
                stat.st_size = 1;
            }
        }

        Ok(0)
    }

    fn close(&self, id: usize) -> syscall::Result<usize> {
        if HANDLES.write().remove(&(id as u64)).is_none() {
            return Err(Error::new(EBADF));
        }
        Ok(0)
    }

    fn write(&self, _id: usize, _buf: &[u8]) -> syscall::Result<usize> {
        Err(Error::new(EBADF))
    }

    fn seek(&self, id: usize, pos: isize, whence: usize) -> syscall::Result<isize> {
        let mut handles = HANDLES.write();
        let handle = handles.get_mut(&(id as u64)).ok_or(Error::new(EBADF))?;

        if handle.stat.load(Ordering::SeqCst) {
            return Err(Error::new(EBADF));
        }

        let flen = match handle.kind {
            HandleKind::TopLevel => SIGNATURE.len(),
            HandleKind::RootTable => acpi_len() as usize,
            HandleKind::ShutdownPipe => 1,
        };

        let offset = match whence {
            SEEK_SET => pos as u64,
            SEEK_CUR => {
                if pos < 0 {
                    handle
                        .offset
                        .checked_sub((-pos) as u64)
                        .ok_or(Error::new(EINVAL))?
                } else {
                    handle.offset.saturating_add(pos as u64)
                }
            }
            SEEK_END => {
                if pos < 0 {
                    (flen as u64)
                        .checked_sub((-pos) as u64)
                        .ok_or(Error::new(EINVAL))?
                } else {
                    flen as u64
                }
            }
            _ => return Err(Error::new(EINVAL)),
        };

        handle.offset = offset;

        Ok(offset as isize)
    }

    fn fevent(
        &self,
        id: usize,
        _flags: syscall::EventFlags,
    ) -> syscall::Result<syscall::EventFlags> {
        let handles = HANDLES.read();
        let handle = handles.get(&(id as u64)).ok_or(Error::new(EBADF))?;

        if handle.stat.load(Ordering::SeqCst) {
            return Err(Error::new(EBADF));
        }

        Ok(EventFlags::empty())
    }

    fn read(&self, id: usize, buf: &mut [u8]) -> syscall::Result<usize> {
        let mut handles = HANDLES.write();
        let handle = handles.get_mut(&(id as u64)).ok_or(Error::new(EBADF))?;

        let data = match handle.kind {
            HandleKind::TopLevel => SIGNATURE.to_vec(),
            HandleKind::RootTable => unsafe {
                let tables = DATA.get().ok_or(Error::new(EBADFD))?;
                let tblptr = addr_of!(tables) as *const u8;

                let raw = core::slice::from_raw_parts(tblptr, core::mem::size_of::<UserAcpi>());
                raw.to_vec()
            },
            HandleKind::ShutdownPipe => {
                let dest_char = match buf.first_mut() {
                    Some(dest) => {
                        if handle.offset >= 1 {
                            return Ok(0);
                        } else {
                            dest
                        }
                    }
                    None => return Ok(0),
                };

                loop {
                    let guard = WAIT_FLAG.load(Ordering::SeqCst);

                    if guard {
                        break;
                    } // TODO: wait conditions
                }

                *dest_char = 0x42;
                handle.offset = 1;
                return Ok(1);
            }
        };

        let src_offset = min(handle.offset, data.len() as u64);
        let src = data
            .get((src_offset as usize)..)
            .expect("Data payload too short: must be at least `data.len()` bytes in length");

        let to_cp = min(buf.len() as u64, src.len() as u64);

        buf[..(to_cp as usize)].copy_from_slice(&src[..(to_cp as usize)]);
        handle.offset += to_cp;

        Ok(to_cp as usize)
    }
}
