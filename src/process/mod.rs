// SPDX-License-Identifier: GPL-3.0-or-later

use core::{
    intrinsics::abort,
    ops::{Generator, GeneratorState},
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
use syscall::{Error, EBADF};

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
    state: State,

    pid: usize,
    tid: usize,

    sid: AtomicU64,
    gid: AtomicU64,

    parent: RwLock<Option<Arc<Process<'a>>>>,

    sleep: AtomicU64,
    signal_received: Signal,

    io_pending: AtomicBool,

    open_files: Arc<Vec<FileData>>,
    pwd: RwLock<Option<Entry<'a>>>,

    exit_status: OnceCell<u64>,
    systrace: AtomicBool,

    main_loop: fn() -> (),
}

impl<'a> Process<'a> {
    pub fn new(data: FileData, main_loop: fn() -> ()) -> Self {
        let mut open_files = Vec::new();
        open_files.push(data);

        Self {
            self_reference: Weak::new(),
            state: State::Runnable,
            pid: PTABLE.read().len(),
            tid: PTABLE.read().len(),
            sid: AtomicU64::new(0),
            gid: AtomicU64::new(0),
            parent: RwLock::new(None),
            sleep: AtomicU64::new(0),
            signal_received: Signal::Success,
            io_pending: AtomicBool::new(false),
            open_files: Arc::new(open_files),
            pwd: RwLock::new(None),
            exit_status: OnceCell::<u64>::uninit(),
            systrace: AtomicBool::new(false),
            main_loop,
        }
    }

    pub fn run(&mut self) -> syscall::Result<usize> {
        // Generators make the process of implementing full preemptive multitasking fairly straightforward
        let mut main = || {
            match self.state {
                // Run the process's main() function
                State::Runnable => (self.main_loop)(),

                // Yield until changed to Runnable
                State::Blocked => yield (),
                State::AwaitingIo => yield (),
                State::Stopped(_) => yield (),

                // Check exit status, then return an error containing it if nonzero
                State::Exited(status) => {
                    self.exit_status.get_or_init(move || status);
                    let status = self.exit_status.get().cloned().unwrap();

                    if status == 0 {
                        return Ok(());
                    } else {
                        return Err(Error::new(status as i32));
                    }
                }

                // All invalid states are erroneous
                State::Invalid(_) => return Err(Error::new(EBADF)),

                // Zombie process slair
                State::Zombie => self.kill(Signal::SIGKILL),
            }
            Ok(())
        };

        loop {
            match Pin::new(&mut main).resume(()) {
                GeneratorState::Yielded(_) => continue,
                GeneratorState::Complete(status) => {
                    match status {
                        Ok(()) => Ok(()),
                        Err(code) => Err(code),
                    }?;
                    break;
                }
            };
        }

        Ok(0)
    }

    pub fn exit(&mut self, code: u64) -> ! {
        self.state = State::Exited(code);
        abort();
    }

    pub fn kill(&mut self, signal: Signal) {
        self.signal_received = signal;
    }
}

unsafe impl<'a> Send for Process<'a> {}
unsafe impl<'a> Sync for Process<'a> {}
