use bitflags::bitflags;

// reuse all the signal numbers defined in the redox_syscall crate
pub use syscall::{
    SIGABRT, SIGALRM, SIGBUS, SIGCHLD, SIGCONT, SIGFPE, SIGHUP, SIGILL, SIGINT, SIGIO, SIGKILL,
    SIGPIPE, SIGPROF, SIGPWR, SIGQUIT, SIGSEGV, SIGSTKFLT, SIGSTOP, SIGSYS, SIGTERM, SIGTRAP,
    SIGTSTP, SIGTTIN, SIGTTOU, SIGURG, SIGUSR1, SIGUSR2, SIGVTALRM, SIGWINCH, SIGXCPU, SIGXFSZ,
};

// not defined upstream, so adding here
pub const SIGINFO: usize = 32;

#[derive(Clone, Copy, Debug, Eq, PartialEq, Ord, PartialOrd)]
pub enum Signal {
    Unknown,
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
            _ => Self::Unknown,
        }
    }
}
