// SPDX-License-Identifier: GPL-3.0-or-later

use core::{
    any::{Any, TypeId},
    ops::Coroutine,
    pin::Pin,
    sync::atomic::{AtomicBool, AtomicU64, AtomicUsize},
};

use crate::common::RwLock;
use alloc::{
    boxed::Box,
    collections::BTreeMap,
    sync::{Arc, Weak},
    vec::Vec,
};
use conquer_once::spin::OnceCell;
use syscall::{Error, EBADF};
use xmas_elf::ElfFile;

use crate::{
    fs::hmfs::{Entry, FileData},
    int_like,
};

pub use self::signal::Signal;
pub mod signal;

use signal::abort;

int_like!(Tid, AtomicTid, usize, AtomicUsize);
int_like!(Pid, AtomicPid, usize, AtomicUsize);
int_like!(Sid, AtomicSid, u64, AtomicU64);
int_like!(Gid, AtomicGid, u64, AtomicU64);

/// State that the context is left in
#[derive(Copy, Clone, Debug, Eq, PartialEq)]
pub enum State {
    /// Ready to run
    Runnable,

    /// Preempted
    Blocked,

    /// Trying to kill but won't die
    Zombie,

    /// Waiting for approval to access MMIO ports
    AwaitingIo,

    /// Paused
    Stopped(u64),

    /// Finished
    Exited(u64),

    /// error!
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

/// Marker trait for main loop return types
trait MainRet: Any + Send {}

impl MainRet for () {}
impl MainRet for syscall::Result<()> {}

pub(crate) static PTABLE: RwLock<BTreeMap<usize, Arc<RwLock<Process>>>> =
    RwLock::new(BTreeMap::new());

pub(crate) static PTABLE_IDX: AtomicUsize = AtomicUsize::new(0);

/// Process object
///
/// Uses `core::ops::Coroutine` behind the scenes for easy preemption
#[allow(unused)] // not finished
pub struct Process<'a> {
    self_reference: Weak<Process<'a>>,
    state: State,

    pid: AtomicPid,
    tid: AtomicTid,

    sid: AtomicSid,
    gid: AtomicGid,

    parent: RwLock<Option<Arc<Process<'a>>>>,

    sleep: AtomicU64,
    signal_received: Signal,

    io_pending: AtomicBool,
    executable: OnceCell<ElfFile<'a>>,

    open_files: Arc<RwLock<Option<Vec<FileData>>>>,
    pwd: RwLock<Option<Entry<'a>>>,

    exit_status: OnceCell<u64>,
    systrace: AtomicBool,

    res: syscall::Result<usize>,
    main: fn() -> Box<dyn Any>,
}

impl Process<'static> {
    /// Inserts this process into the PTABLE
    pub fn register(mut self) {
        self.block(); // make sure this is the case before proceeding
        self.queue();

        PTABLE
            .write()
            .insert(PTABLE.read().len() - 1, Arc::new(RwLock::new(self)));
    }
}

impl<'a> Process<'a> {
    fn new(data: Option<FileData>, main: fn() -> Box<dyn Any>) -> Self {
        let open_files = data.map(|data| alloc::vec![data]);

        // necessary for cleanup
        let global_id = PTABLE.read().len() - 1;

        Self {
            self_reference: Weak::new(),
            state: State::Blocked, // don't make process Runnable until it's actually ready to be run
            pid: AtomicPid::new(Pid::new(global_id)),
            tid: AtomicTid::new(Tid::new(global_id)),
            sid: AtomicSid::new(Sid::new(global_id as u64)),
            gid: AtomicGid::new(Gid::new(global_id as u64)),
            parent: RwLock::new(None),
            sleep: AtomicU64::new(global_id as u64),
            signal_received: Signal::Success,
            io_pending: AtomicBool::new(false),
            executable: OnceCell::uninit(),
            open_files: Arc::new(RwLock::new(open_files)),
            pwd: RwLock::new(None),
            exit_status: OnceCell::<u64>::uninit(),
            systrace: AtomicBool::new(false),
            res: Ok(0), // this will change when the process runs
            main,
        }
    }

    /// Creates a new process using and automatically adds it to `PTABLE`
    pub fn create(exec: ElfFile<'static>) {
        Process::<'static>::from(exec).register();
    }

    fn set_result(&mut self, res: syscall::Result<usize>) {
        self.res = res;
    }

    /// Uses a generator to queue this process
    fn queue(&mut self) {
        // borrow checker
        let self_ptr = self as *mut _;

        // Generators make the process of implementing full preemptive multitasking fairly straightforward
        let mut main = || {
            match self.state {
                State::Runnable => {
                    let main_box = Box::new(self.main);

                    if main_box().type_id() == TypeId::of::<()>() {
                        // Main functions for processes that need to run indefinitely
                        // will use infinite loops within their own main function bodies
                        // so no need to redundantly use infinite loops here

                        self.state = State::Exited(0);
                        self.set_result(Ok(0));
                    } else if main_box().type_id() == TypeId::of::<syscall::Result<()>>() {
                        match main_box().downcast_mut::<syscall::Result<()>>().unwrap() {
                            Ok(()) => {
                                self.state = State::Exited(0);
                                self.set_result(Ok(0));
                            }
                            Err(e) => {
                                self.state = State::Exited(e.errno as u64);

                                // borrow checker
                                self.set_result(Err(Error::new(e.errno.clone())));
                            }
                        }
                    }
                }

                // Yield until changed to Runnable
                State::Blocked => yield (),
                State::AwaitingIo => yield (),
                State::Stopped(_) => yield (),

                // Check exit status, then return an error containing it if nonzero
                State::Exited(status) => {
                    self.exit_status.get_or_init(move || status);
                    let status = self.exit_status.get().cloned().unwrap();

                    if self.signal_received == Signal::Success {
                        if status == 0 {
                            PTABLE.write().remove(self.pid.0.get_mut());

                            // Note: if we return here then we don't need to from the `Runnable` arm
                            // as that's the arm that the exit status is set from
                            self.set_result(Ok(0));
                        } else {
                            PTABLE.write().remove(self.pid.0.get_mut());
                            self.set_result(Err(Error::new(status as i32)));
                        }
                    } else {
                        PTABLE.write().remove(self.pid.0.get_mut());

                        // borrow checker
                        let signal = self.signal_received;
                        self.set_result(match signal.handle(unsafe { &mut *self_ptr }) {
                            Ok(()) => Ok(0),
                            Err(e) => Err(e),
                        });
                    }
                }

                // All invalid states are erroneous
                State::Invalid(_) => self.set_result(Err(Error::new(EBADF))),

                // Zombie process slair
                State::Zombie => self.kill(Signal::SIGKILL),
            }
        };

        // Errors already handled inside the generator
        Pin::new(&mut main).resume(());
    }

    fn set_state(&mut self, state: State) {
        self.state = state;
    }

    /// Blocks this process
    pub fn block(&mut self) {
        self.set_state(State::Blocked);
    }

    /// Unblocks this process
    pub fn unblock(&mut self) {
        self.set_state(State::Runnable);
    }

    /// Exits this process
    pub fn exit(&mut self, code: u64) -> ! {
        self.state = State::Exited(code);
        abort();
    }

    /// Sends signal
    pub fn kill(&mut self, signal: Signal) {
        self.signal_received = signal;
    }

    /// Opens a file using a stream of bytes
    pub fn fopen(&mut self, file: FileData) {
        if self.open_files.read().is_none() {
            self.open_files = Arc::new(RwLock::new(Some(alloc::vec![file])));
        } else if let Some(files) = self.open_files.write().as_mut() {
            files.push(file)
        }
    }
}

unsafe impl<'a> Send for Process<'a> {}
unsafe impl<'a> Sync for Process<'a> {}

impl<'a> From<ElfFile<'a>> for Process<'a> {
    fn from(value: ElfFile<'a>) -> Self {
        let start = value.header.pt2.entry_point();
        let main = unsafe { *(start as *mut fn() -> Box<dyn Any>) };

        let out = Self::new(None, main);
        out.executable.get_or_init(move || value);
        out
    }
}
