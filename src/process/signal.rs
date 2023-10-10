use bitflags::bitflags;
use core::arch::asm;

use syscall::{
    Error, ECANCELED, EDOM, EDQUOT, EFAULT, EILSEQ, EINTR, EIO, EPERM, EPIPE, ESPIPE, ESRCH,
};
// reuse all the signal numbers defined in the redox_syscall crate
pub use syscall::{
    SIGABRT, SIGALRM, SIGBUS, SIGCHLD, SIGCONT, SIGFPE, SIGHUP, SIGILL, SIGINT, SIGIO, SIGKILL,
    SIGPIPE, SIGPROF, SIGPWR, SIGQUIT, SIGSEGV, SIGSTKFLT, SIGSTOP, SIGSYS, SIGTERM, SIGTRAP,
    SIGTSTP, SIGTTIN, SIGTTOU, SIGURG, SIGUSR1, SIGUSR2, SIGVTALRM, SIGWINCH, SIGXCPU, SIGXFSZ,
};

use super::{Process, State};

// not defined upstream, so adding here
pub const SIGINFO: usize = 32;

/// Handles SIGKILL
pub fn abort() -> ! {
    unsafe { asm!("ret", options(noreturn)) }
}

/// Signal numbers
#[derive(Clone, Copy, Debug, Eq, PartialEq, Ord, PartialOrd)]
#[repr(u64)]
pub enum Signal {
    Success,
    SIGHUP,
    SIGINT,
    SIGQUIT,
    SIGILL,
    SIGTRAP,
    SIGABRT,
    SIGBUS,
    SIGFPE,
    SIGKILL,
    SIGUSR1,
    SIGSEGV,
    SIGUSR2,
    SIGPIPE,
    SIGALRM,
    SIGTERM,
    SIGSTKFLT,
    SIGCHLD,
    SIGCONT,
    SIGSTOP,
    SIGTSTP,
    SIGTTIN,
    SIGTTOU,
    SIGURG,
    SIGXCPU,
    SIGXFSZ,
    SIGVTALRM,
    SIGPROF,
    SIGWINCH,
    SIGIO,
    SIGPWR,
    SIGSYS,
    SIGINFO,
}

impl Signal {
    pub fn new(num: usize) -> Self {
        match num {
            SIGHUP => Self::SIGHUP,
            SIGINT => Self::SIGINT,
            SIGQUIT => Self::SIGQUIT,
            SIGILL => Self::SIGILL,
            SIGTRAP => Self::SIGTRAP,
            SIGABRT => Self::SIGABRT,
            SIGBUS => Self::SIGBUS,
            SIGFPE => Self::SIGFPE,
            SIGKILL => Self::SIGKILL,
            SIGUSR1 => Self::SIGUSR1,
            SIGSEGV => Self::SIGSEGV,
            SIGUSR2 => Self::SIGUSR2,
            SIGPIPE => Self::SIGPIPE,
            SIGALRM => Self::SIGALRM,
            SIGTERM => Self::SIGTERM,
            SIGSTKFLT => Self::SIGSTKFLT,
            SIGCHLD => Self::SIGCHLD,
            SIGCONT => Self::SIGCONT,
            SIGSTOP => Self::SIGSTOP,
            SIGTSTP => Self::SIGTSTP,
            SIGTTIN => Self::SIGTTIN,
            SIGTTOU => Self::SIGTTOU,
            SIGURG => Self::SIGURG,
            SIGXCPU => Self::SIGXCPU,
            SIGXFSZ => Self::SIGXFSZ,
            SIGVTALRM => Self::SIGVTALRM,
            SIGPROF => Self::SIGPROF,
            SIGWINCH => Self::SIGWINCH,
            SIGIO => Self::SIGIO,
            SIGPWR => Self::SIGPWR,
            SIGSYS => Self::SIGSYS,
            SIGINFO => Self::SIGINFO,
            _ => Self::Success,
        }
    }

    /// Convenient method for handling signals (experimental)
    pub fn handle(&self, p: &mut Process<'_>) -> syscall::Result<()> {
        match self {
            Self::Success => Ok(()),
            Self::SIGHUP => Err(Error::new(EPIPE)),
            Self::SIGINT => {
                // TODO: stderr
                Err(Error::new(ECANCELED))
            }
            Self::SIGQUIT => Err(Error::new(ECANCELED)),
            Self::SIGILL => Err(Error::new(EILSEQ)),
            Self::SIGTRAP => Err(Error::new(EPERM)),
            Self::SIGABRT => Err(Error::new(ECANCELED)),
            Self::SIGBUS => Err(Error::new(EFAULT)),
            Self::SIGFPE => Err(Error::new(EDOM)),
            Self::SIGKILL => abort(), // cannot be caught
            Self::SIGUSR1 => Ok(()),  // def by user
            Self::SIGSEGV => Err(Error::new(EFAULT)),
            Self::SIGUSR2 => Ok(()), // def by user
            Self::SIGPIPE => Err(Error::new(EPIPE)),
            Self::SIGALRM => Err(Error::new(EDQUOT)),
            Self::SIGTERM => Ok(()), // sent by user and terminates gracefully
            Self::SIGSTKFLT => Err(Error::new(ESPIPE)),
            Self::SIGCHLD => {
                p.state = State::Zombie;
                Ok(())
            }
            Self::SIGSTOP => {
                p.state = State::Stopped(u64::from(*self));
                Ok(())
            }
            Self::SIGTSTP => {
                p.state = State::Stopped(u64::from(*self));
                Ok(())
            }
            Self::SIGTTIN => {
                p.state = State::Blocked;
                Ok(())
            }
            Self::SIGTTOU => {
                p.state = State::Blocked;
                Ok(())
            }
            Self::SIGCONT => {
                p.state = State::Runnable;
                Ok(())
            }
            Self::SIGURG => Ok(()),
            Self::SIGXCPU => Err(Error::new(EDQUOT)),
            Self::SIGXFSZ => Err(Error::new(EDQUOT)),
            Self::SIGVTALRM => Err(Error::new(EDQUOT)),
            Self::SIGPROF => Err(Error::new(EDQUOT)),
            Self::SIGWINCH => Ok(()),
            Self::SIGIO => Err(Error::new(EIO)),
            Self::SIGPWR => Ok(()),
            Self::SIGSYS => Err(Error::new(EINTR)),
            Self::SIGINFO => Ok(()),
        }
    }
}

// Needed for ensuring that exit status matches signal received, if any
impl From<u64> for Signal {
    fn from(value: u64) -> Self {
        Self::new(value as usize)
    }
}

// Compatibility
impl From<i32> for Signal {
    fn from(value: i32) -> Self {
        Self::from(value as u64)
    }
}

impl From<Signal> for u64 {
    fn from(value: Signal) -> Self {
        match value {
            Signal::Success => 0,
            Signal::SIGHUP => 1,
            Signal::SIGINT => 2,
            Signal::SIGQUIT => 3,
            Signal::SIGILL => 4,
            Signal::SIGTRAP => 5,
            Signal::SIGABRT => 6,
            Signal::SIGBUS => 7,
            Signal::SIGFPE => 8,
            Signal::SIGKILL => 9,
            Signal::SIGUSR1 => 10,
            Signal::SIGSEGV => 11,
            Signal::SIGUSR2 => 12,
            Signal::SIGPIPE => 13,
            Signal::SIGALRM => 14,
            Signal::SIGTERM => 15,
            Signal::SIGSTKFLT => 16,
            Signal::SIGCHLD => 17,
            Signal::SIGCONT => 18,
            Signal::SIGSTOP => 19,
            Signal::SIGTSTP => 20,
            Signal::SIGTTIN => 21,
            Signal::SIGTTOU => 22,
            Signal::SIGURG => 23,
            Signal::SIGXCPU => 24,
            Signal::SIGXFSZ => 25,
            Signal::SIGVTALRM => 26,
            Signal::SIGPROF => 27,
            Signal::SIGWINCH => 28,
            Signal::SIGIO => 29,
            Signal::SIGPWR => 30,
            Signal::SIGSYS => 31,
            Signal::SIGINFO => 32,
        }
    }
}

// Compatibility
impl From<Signal> for i32 {
    fn from(value: Signal) -> Self {
        u64::from(value) as Self
    }
}
