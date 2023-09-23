// SPDX-License-Identifier: GPL-3.0-or-later

use core::sync::atomic::{AtomicBool, AtomicU64, AtomicU8, AtomicUsize};

use alloc::{
    sync::{Arc, Weak},
    vec::Vec,
};
use conquer_once::spin::{Once, OnceCell};
use spin::RwLock;

use crate::fs::hmfs::{Entry, FileData};

use self::signal::Signal;

pub mod signal;

// Context status
#[derive(Clone, Debug)]
pub enum State {
    Runnable,
    Blocked,
    Zombie,
    AwaitingIo,
    Stopped(u64),
    Exited(u64),
    Invalid(u8),
}

impl From<(u8, u64)> for State {
    fn from(value: (u8, u64)) -> Self {
        match value.0 {
            0 => Self::Runnable,
            1 => Self::Blocked,
            2 => Self::Zombie,
            3 => Self::AwaitingIo,
            4 => Self::Stopped(value.1),
            5 => Self::Exited(value.1),
            _ => Self::Invalid(value.0),
        }
    }
}

#[allow(dead_code)] // not finished
pub(crate) static PTABLE: RwLock<Vec<Arc<RwLock<Process>>>> = RwLock::new(Vec::new());
pub(crate) static PTABLE_IDX: AtomicUsize = AtomicUsize::new(0);

#[allow(unused)] // not finished
pub struct Process {
    self_reference: Weak<Process>,
    state: (AtomicU8, AtomicU64),

    pid: usize,
    tid: usize,

    sid: AtomicU64,
    gid: AtomicU64,

    parent: RwLock<Option<Arc<Process>>>,

    sleep: AtomicU64,
    signal_received: Signal,

    io_pending: AtomicBool,

    open_files: Arc<Vec<FileData>>,
    message_queue: !, // TODO: properly implement this

    pwd: RwLock<Option<Entry>>,
    exit_status: OnceCell<u64>,

    parent_term: !, // TODO: properly implement this
    systrace: AtomicBool,
}

impl Process {
    pub fn new(_data: FileData) -> Self {
        todo!()
    }

    pub fn run(&self) -> syscall::Result<usize> {
        todo!()
    }

    pub fn kill(&self) {
        todo!();
    }
}

unsafe impl Send for Process {}
unsafe impl Sync for Process {}
