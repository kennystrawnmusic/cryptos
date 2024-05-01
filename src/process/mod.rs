// SPDX-License-Identifier: GPL-3.0-or-later

use core::{
    any::{Any, TypeId},
    ffi::c_int,
    ops::Coroutine,
    pin::Pin,
    sync::atomic::{AtomicBool, AtomicU64, AtomicUsize},
};

use crate::{common::RwLock, get_phys_offset, map_page};
use alloc::{
    collections::BTreeMap,
    sync::{Arc, Weak},
    vec::Vec,
};
use conquer_once::spin::OnceCell;
use syscall::{Error, EBADF};
use x86_64::structures::paging::{PageTableFlags, Size4KiB};
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

/// Marker trait for tracking return type of main() function of given process
pub trait MainLoopRet: Any {}

impl MainLoopRet for () {}
impl MainLoopRet for syscall::Result<usize> {}
impl MainLoopRet for c_int {}

/// Type alias for process's entry point
pub type MainLoop = fn() -> dyn MainLoopRet;

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

pub(crate) static PTABLE: RwLock<BTreeMap<usize, Arc<RwLock<Process>>>> =
    RwLock::new(BTreeMap::new());

pub(crate) static PTABLE_IDX: AtomicUsize = AtomicUsize::new(0);

/// Process object
///
/// Uses `core::ops::Generator` behind the scenes for easy preemption
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

    res: Option<syscall::Result<usize>>,
    main_sig: TypeId,
    main: MainLoop,
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
    fn new(data: Option<FileData>, main: MainLoop) -> Self {
        let open_files = data.map(|data| alloc::vec![data]);
        let main_id = main.type_id();

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
            res: None, // this will change when the process runs
            main_sig: main_id,
            main,
        }
    }

    /// Creates a new process using and automatically adds it to `PTABLE`
    pub fn create(exec: ElfFile<'static>) {
        Process::<'static>::from(exec).register();
    }

    fn set_result(&mut self, res: syscall::Result<usize>) {
        self.res = Some(res);
    }

    /// Uses a coroutine to queue this process
    fn queue(&mut self) {
        // borrow checker
        let me = self as *mut Self;

        // Coroutines make the process of implementing full preemptive multitasking fairly straightforward
        let mut main = #[coroutine]
        || {
            match self.state {
                State::Runnable => {
                    // Run the main loop
                    let my_type_id = self.main_sig.clone();
                    let ptr_to_main = unsafe { (*me).main as *mut MainLoop };

                    if my_type_id == TypeId::of::<fn() -> ()>() {
                        let main = unsafe {
                            // TypeId checks the type for us to make sure that we're not causing UB here
                            core::mem::transmute::<MainLoop, fn() -> ()>(*ptr_to_main)
                        };
                        main();
                    } else if my_type_id == TypeId::of::<fn() -> syscall::Result<usize>>() {
                        let main = unsafe {
                            core::mem::transmute::<MainLoop, fn() -> syscall::Result<usize>>(
                                *ptr_to_main,
                            )
                        };
                        self.set_result(main());
                    } else {
                        let main = unsafe {
                            core::mem::transmute::<MainLoop, fn() -> c_int>(*ptr_to_main)
                        };
                        match main() {
                            0 => self.set_result(Ok(0)),
                            e => self.set_result(Err(Error::new(e))),
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
                        self.set_result(match signal.handle(unsafe { &mut *me }) {
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

        // Errors already handled inside the coroutine
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

        map_page!(
            start,
            start + get_phys_offset(),
            Size4KiB,
            PageTableFlags::PRESENT | PageTableFlags::WRITABLE | PageTableFlags::USER_ACCESSIBLE
        );

        let start_ptr = start as *mut MainLoop;

        let main = unsafe { *start_ptr };

        let out: Process<'a> = Self::new(None, main);
        out.executable.get_or_init(move || value);
        out
    }
}
