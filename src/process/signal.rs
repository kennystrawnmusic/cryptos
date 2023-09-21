use bitflags::bitflags;

bitflags! {
    pub struct Signal: u8 {
        const SIGHUP = 1;
        const SIGINT = 2;
        const SIGQUIT = 3;
        const SIGILL = 4;
        const SIGTRAP = 5;
        const SIGABRT = 6;
        const SIGEMT = 7;
        const SIGFPE = 8;
        const SIGKILL = 9;
        const SIGBUS = 10;
        const SIGSEGV = 11;
        const SIGSYS = 12;
        const SIGPIPE = 13;
        const SIGALRM = 14;
        const SIGTERM = 15;
        const SIGURG = 16;
        const SIGSTOP = 17;
        const SIGTSTP = 18;
        const SIGCONT = 19;
        const SIGCHLD = 20;
        const SIGTTIN = 21;
        const SIGTTOU = 22;
        const SIGIO = 23;
        const SIGXCPU = 24;
        const SIGXFSZ = 25;
        const SIGVTALRM = 26;
        const SIGPROF = 27;
        const SIGWINCH = 28;
        const SIGINFO = 29;
        const SIGUSR1 = 30;
        const SIGUSR2 = 31;
    }
}