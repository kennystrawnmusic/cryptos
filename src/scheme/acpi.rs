#![allow(dead_code)] // work in progress!
use core::sync::atomic::{AtomicBool, AtomicU64, Ordering};
use super::Scheme;

use alloc::{collections::BTreeMap, vec::Vec};
use spin::{RwLock, Once};
use x86_64::VirtAddr;
use syscall::{Error, EACCES, O_CREAT, EROFS, O_EXCL, O_SYMLINK, EINVAL, O_ACCMODE, O_RDONLY, O_STAT, O_DIRECTORY, EISDIR, ENOENT};

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

pub(crate) static DATA: Once<Vec<u8>> = Once::new();

pub(crate) const SIGNATURE: &[u8] = b"rxsdt\nkstop\n";

pub(crate) static WAIT_FLAG: AtomicBool = AtomicBool::new(false);

pub(crate) static SCHID: AtomicU64 = AtomicU64::new(0);

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
            _ => return Err(Error::new(ENOENT))
        };

        let fd = NEXT.fetch_add(1, Ordering::Relaxed);

        let mut handle_guard = HANDLES.write();
        let stat = AtomicBool::new(flags & O_STAT == O_STAT);

        let _ = handle_guard.insert(fd, Handle {
            offset: 0,
            kind: handle_kind,
            stat,
        });

        Ok(fd as usize)

    }

    fn chmod(&self, _path: &str, _mode: u16, _uid: u32, _gid: u32) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::ENOENT))
    }

    fn rmdir(&self, _path: &str, _uid: u32, _gid: u32) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::ENOENT))
    }

    fn unlink(&self, _path: &str, _uid: u32, _gid: u32) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::ENOENT))
    }

    fn dup(&self, _old_id: usize, _buf: &[u8]) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn read(&self, _id: usize, _buf: &mut [u8]) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn write(&self, _id: usize, _buf: &[u8]) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn seek(&self, _id: usize, _pos: isize, _whence: usize) -> syscall::Result<isize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn fchmod(&self, _id: usize, _mode: u16) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn fchown(&self, _id: usize, _uid: u32, _gid: u32) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn fcntl(&self, _id: usize, _cmd: usize, _arg: usize) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn fevent(&self, _id: usize, _flags: syscall::EventFlags) -> syscall::Result<syscall::EventFlags> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn fmap_old(&self, _id: usize, _map: &syscall::OldMap) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn fmap(&self, id: usize, map: &syscall::Map) -> syscall::Result<usize> {
        if map.flags.contains(syscall::MapFlags::MAP_FIXED) {
            return Err(syscall::Error::new(syscall::EINVAL));
        }
        self.fmap_old(id, &syscall::OldMap {
            offset: map.offset,
            size: map.size,
            flags: map.flags,
        })
    }

    fn funmap_old(&self, _address: usize) -> syscall::Result<usize> {
        Ok(0)
    }

    fn funmap(&self, _address: usize, _length: usize) -> syscall::Result<usize> {
        Ok(0)
    }

    fn fpath(&self, _id: usize, _buf: &mut [u8]) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn frename(&self, _id: usize, _path: &str, _uid: u32, _gid: u32) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn fstat(&self, _id: usize, _stat: &mut syscall::Stat) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn fstatvfs(&self, _id: usize, _stat: &mut syscall::StatVfs) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn fsync(&self, _id: usize) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn ftruncate(&self, _id: usize, _len: usize) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn futimens(&self, _id: usize, _times: &[syscall::TimeSpec]) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }

    fn close(&self, _id: usize) -> syscall::Result<usize> {
        Err(syscall::Error::new(syscall::EBADF))
    }
}