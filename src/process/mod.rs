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
use syscall::{Error, EBADF, ESRCH};
use xmas_elf::ElfFile;

use crate::fs::hmfs::{Entry, FileData};

pub use self::signal::Signal;

pub mod signal;

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

pub(crate) static PTABLE: RwLock<Vec<Arc<RwLock<Process>>>> = RwLock::new(Vec::new());
pub(crate) static PTABLE_IDX: AtomicUsize = AtomicUsize::new(0);

/// Enum of `main()` fn signatures for the kernel to accept
///
/// Implements `From` for easy signature parsing
#[derive(Copy, Clone)]
pub enum MainLoop {
    WithoutResult(fn() -> ()),
    WithResult(fn() -> syscall::Result<()>),
}

// Necessary for function signature parsing
impl From<fn() -> ()> for MainLoop {
    fn from(value: fn() -> ()) -> Self {
        Self::WithoutResult(value)
    }
}

impl From<fn() -> syscall::Result<()>> for MainLoop {
    fn from(value: fn() -> syscall::Result<()>) -> Self {
        Self::WithResult(value)
    }
}

/// Process object
///
/// Uses `core::ops::Generator` behind the scenes for easy preemption
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
    executable: OnceCell<ElfFile<'a>>,

    open_files: Arc<Option<Vec<FileData>>>,
    pwd: RwLock<Option<Entry<'a>>>,

    exit_status: OnceCell<u64>,
    systrace: AtomicBool,

    main: MainLoop,
}

impl<'a> Process<'a> {
    fn new(data: Option<FileData>, main: MainLoop) -> Self {
        let open_files = data.map(|data| alloc::vec![data]);

        Self {
            self_reference: Weak::new(),
            state: State::Blocked, // don't make process Runnable until it's actually ready to be run
            pid: PTABLE.read().len(), // necessary for cleanup
            tid: PTABLE.read().len(),
            sid: AtomicU64::new(PTABLE.read().len() as u64),
            gid: AtomicU64::new(PTABLE.read().len() as u64),
            parent: RwLock::new(None),
            sleep: AtomicU64::new(PTABLE.read().len() as u64),
            signal_received: Signal::Success,
            io_pending: AtomicBool::new(false),
            executable: OnceCell::uninit(),
            open_files: Arc::new(open_files),
            pwd: RwLock::new(None),
            exit_status: OnceCell::<u64>::uninit(),
            systrace: AtomicBool::new(false),
            main,
        }
    }
    /// Creates a new process using and automatically adds it to `PTABLE`
    pub fn create(exec: ElfFile<'static>) {
        PTABLE
            .write()
            .push(Arc::new(RwLock::new(Process::<'static>::from(exec))));
    }

    /// Runs this process
    pub fn run(&mut self) -> syscall::Result<usize> {
        // Generators make the process of implementing full preemptive multitasking fairly straightforward
        let mut main = || {
            match self.state {
                State::Runnable => match self.main {
                    MainLoop::WithoutResult(main) => {
                        // Call the process's main() function
                        main();

                        // Processes that need to constantly run (i.e. daemons) always
                        // use infinite loops within their own main() bodies anyway,
                        // so we don't need to redundantly add one here
                        self.state = State::Exited(0);
                    }
                    MainLoop::WithResult(main) => match main() {
                        Ok(()) => {
                            self.state = State::Exited(0);
                        }
                        Err(e) => {
                            self.state = State::Exited(e.errno as u64);
                        }
                    },
                },

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
                            // TODO: redefine the process table as a `BTreeMap<usize, Arc<RwLock<Process>>>` for proper management of this
                            PTABLE.write().remove(self.pid - 1);

                            // Note: if we return here then we don't need to from the `Runnable` arm
                            // as that's the arm that the exit status is set from
                            return Ok(());
                        } else {
                            PTABLE.write().remove(self.pid - 1);
                            return Err(Error::new(status as i32));
                        }
                    } else {
                        PTABLE.write().remove(self.pid - 1);

                        // borrow checker
                        let signal = self.signal_received;
                        signal.handle(self)?;
                    }
                }

                // All invalid states are erroneous
                State::Invalid(_) => return Err(Error::new(EBADF)),

                // Zombie process slair
                State::Zombie => self.kill(Signal::SIGKILL),
            }
            Ok(())
        };

        // Listen indefinitely for the process to exit
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

    /// Sets this process's state
    ///
    /// This paves the way for proper preemption
    pub(crate) fn set_state(&mut self, state: State) {
        self.state = state;
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
}

unsafe impl<'a> Send for Process<'a> {}
unsafe impl<'a> Sync for Process<'a> {}

impl<'a> From<ElfFile<'a>> for Process<'a> {
    fn from(value: ElfFile<'a>) -> Self {
        let start = value.header.pt2.entry_point() as usize;
        let main = unsafe { *(start as *mut MainLoop) };

        let out = Self::new(None, main);
        out.executable.get_or_init(move || value);
        out
    }
}
