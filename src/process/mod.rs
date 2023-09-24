// SPDX-License-Identifier: GPL-3.0-or-later

use core::{
    ops::Generator,
    pin::Pin,
    sync::atomic::{AtomicBool, AtomicU64, AtomicU8, AtomicUsize},
};

use alloc::{
    boxed::Box,
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
pub struct Process<'a> {
    self_reference: Weak<Process<'a>>,
    state: (AtomicU8, AtomicU64),

    pid: usize,
    tid: usize,

    sid: AtomicU64,
    gid: AtomicU64,

    parent: RwLock<Option<Arc<Process<'a>>>>,

    sleep: AtomicU64,
    signal_received: Signal,

    io_pending: AtomicBool,

    open_files: Arc<Vec<FileData>>,
    message_queue: !, // TODO: properly implement this

    pwd: RwLock<Option<Entry<'a>>>,
    exit_status: OnceCell<u64>,

    parent_term: !, // TODO: properly implement this
    systrace: AtomicBool,

    main_loop: Pin<Box<dyn Generator<Yield = u64, Return = ()>>>,
}

impl<'a> Process<'a> {
    pub fn new(_data: FileData) -> Self {
        let _main = |builder: (u64, Signal)| {
            let mut exit_status = builder.0;
            let signal_received = builder.1;

            loop {
                if builder.0 != exit_status || builder.1 != signal_received {
                    exit_status = u64::from(builder.1);
                    yield exit_status;

                    // TODO: more parameters
                    break;
                }
            }
        };
        todo!()
    }

    pub fn run(&mut self) -> syscall::Result<usize> {
        todo!()
    }

    pub fn kill(&mut self, _signal: Signal) {
        todo!();
    }
}

unsafe impl<'a> Send for Process<'a> {}
unsafe impl<'a> Sync for Process<'a> {}
