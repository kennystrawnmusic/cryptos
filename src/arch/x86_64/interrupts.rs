use core::{arch::asm, sync::atomic::AtomicU32};

use log::warn;
use raw_cpuid::{CpuId, Hypervisor};
use spin::RwLock;
use x86_64::{
    instructions::interrupts,
    registers::{
        control::{Efer, EferFlags},
        model_specific::{LStar, SFMask},
        read_rip,
        rflags::{self, RFlags},
        segmentation::{Segment, CS},
    },
    structures::{
        gdt::SegmentSelector,
        idt::{Entry, InterruptStackFrameValue, SelectorErrorCode},
        paging::{Page, PageTableFlags, Size4KiB},
    },
    PrivilegeLevel,
};

use crate::{
    ahci::{get_ahci, get_hba, HbaPortInterruptStatus},
    apic_impl::{get_active_lapic, get_lapic_ids},
    get_phys_offset, map_page,
    process::{signal::Signal, PTABLE, PTABLE_IDX},
};

use {
    core::sync::atomic::{AtomicU64, Ordering},
    lazy_static::lazy_static,
    log::{debug, error, info},
    x86_64::{
        registers::control::Cr2,
        structures::idt::{InterruptDescriptorTable, InterruptStackFrame, PageFaultErrorCode},
    },
};

/// Initializes the IDT
pub fn init() {
    lazy_static! {
        static ref IDT_CLONE: InterruptDescriptorTable = IDT.read().clone();
    }
    IDT_CLONE.load();
}

pub fn current_privilege_level(frame: InterruptStackFrameValue) -> PrivilegeLevel {
    // TODO: from what end is the SegmentSelector padded with zeros? Ask @phil-opp for advice on this
    let sel = SegmentSelector(frame.code_segment.0);

    sel.rpl()
}

// Marker trait for satisfying type checking of syscall method return type
pub trait SyscallRet {}

// Implementations for ensuring acceptable return types
impl SyscallRet for ! {}
impl SyscallRet for () {}
// to be continued

macro_rules! primitive_impl_syscall_ret {
    ($($t:ty),*) => {
        $(
            impl SyscallRet for $t {}
        )*
    };
}

primitive_impl_syscall_ret!(u8, u16, u32, u64, i8, i16, i32, i64, f32, f64);

pub const QEMU_STATUS_FAIL: u32 = 0x11;

pub static INTA_IRQ: AtomicU64 = AtomicU64::new(0);
pub static INTB_IRQ: AtomicU64 = AtomicU64::new(0);
pub static INTC_IRQ: AtomicU64 = AtomicU64::new(0);
pub static INTD_IRQ: AtomicU64 = AtomicU64::new(0);

lazy_static! {
    pub static ref IDT: RwLock<InterruptDescriptorTable> = {
        let mut idt = InterruptDescriptorTable::new();
        unsafe {
            idt.double_fault
                .set_handler_fn(double_fault)
                .set_stack_index(super::exceptions::DOUBLE_FAULT_STACK_INDEX);

            idt.page_fault
                .set_handler_fn(page_fault)
                .set_stack_index(super::exceptions::PAGE_FAULT_STACK_INDEX);
            idt.divide_error
                .set_handler_fn(sigfpe)
                .set_stack_index(super::exceptions::DIV_ERR_STACK_INDEX);
            idt.invalid_tss
                .set_handler_fn(invalid_tss)
                .set_stack_index(super::exceptions::INVALID_TSS_STACK_INDEX);
            idt.segment_not_present
                .set_handler_fn(sigbus)
                .set_stack_index(super::exceptions::SIGBUS_STACK_INDEX);
            idt.stack_segment_fault
                .set_handler_fn(sigsegv)
                .set_stack_index(super::exceptions::SIGSEGV_STACK_INDEX);
            idt.general_protection_fault
                .set_handler_fn(general_protection)
                .set_stack_index(super::exceptions::GPF_STACK_INDEX);
        }

        idt.breakpoint.set_handler_fn(breakpoint);
        idt.bound_range_exceeded
            .set_handler_fn(bound_range_exceeded);
        idt.invalid_opcode.set_handler_fn(invalid_op);
        idt.device_not_available.set_handler_fn(navail);
        idt[IrqIndex::Timer as u8].set_handler_fn(timer);
        idt[IrqIndex::LapicErr as u8].set_handler_fn(lapic_err);
        idt[IrqIndex::Spurious as u8].set_handler_fn(spurious);
        idt[INTA_IRQ.load(Ordering::SeqCst) as u8].set_handler_fn(pin_inta);
        idt[INTB_IRQ.load(Ordering::SeqCst) as u8].set_handler_fn(pin_intb);
        idt[INTC_IRQ.load(Ordering::SeqCst) as u8].set_handler_fn(pin_intc);
        idt[INTD_IRQ.load(Ordering::SeqCst) as u8].set_handler_fn(pin_intd);
        idt[0x80].set_handler_fn(syscall);

        // Vector 100 = IPI_WAKE handler as task scheduler
        // performance is the obvious reason why I'm doing this
        idt[100].set_handler_fn(task_sched);
        idt[139].set_handler_fn(pci);
        idt[0x80].set_handler_fn(syscall);
        idt[0x82].set_handler_fn(pci);
        idt[0xff].set_handler_fn(spurious);
        idt[151].set_handler_fn(pci);
        RwLock::new(idt)
    };
}

pub static TICK_COUNT: AtomicU64 = AtomicU64::new(0);
pub static ACTIVE_LAPIC_ID: AtomicU32 = AtomicU32::new(0);

#[derive(Debug, Clone, Copy)]
#[repr(u8)]
pub enum IrqIndex {
    Timer = 0xfe,     // 254
    LapicErr = 0x31,  // 49
    IpiWake = 0x40,   // 64
    IpiTlb = 0x41,    // 65
    IpiSwitch = 0x42, // 66
    IpiPit = 0x43,    // 67
    Spurious = 0xff,  // 255
}

extern "x86-interrupt" fn timer(_frame: InterruptStackFrame) {
    // TODO: use as RNG entropy
    TICK_COUNT.fetch_add(1, Ordering::Relaxed);
    unsafe { get_active_lapic().end_of_interrupt() };
}

extern "x86-interrupt" fn spurious(_frame: InterruptStackFrame) {
    debug!("Received spurious interrupt");
    unsafe { get_active_lapic().end_of_interrupt() };
}

extern "x86-interrupt" fn lapic_err(_frame: InterruptStackFrame) {
    error!("Local APIC error; check the status for details");
    unsafe { get_active_lapic().end_of_interrupt() };
}

/// Round-robin preemptive scheduler
///
/// Uses an IPI instead of the timer or the loop at the end of maink for optimization reasons:
/// an IPI can send itself to every CPU on the system, making it possible to evenly distribute all that power
extern "x86-interrupt" fn task_sched(_: InterruptStackFrame) {
    // use index of an atomic to ensure that only one process is being run at a time
    if !(PTABLE.read().is_empty()) {
        if PTABLE.read().len() == 1 {
            // always runnable as only one process exists
            (PTABLE.read())[&PTABLE_IDX.load(Ordering::SeqCst)]
                .write()
                .unblock();
        } else {
            // need to preempt previous process in the table
            (PTABLE.read())[&(PTABLE_IDX.load(Ordering::SeqCst) - 1)]
                .write()
                .block();

            (PTABLE.read())[&PTABLE_IDX.load(Ordering::SeqCst)]
                .write()
                .unblock();
        }

        if PTABLE_IDX.load(Ordering::SeqCst) < (PTABLE.read().len() - 1) {
            // ensure that the next CPU core runs the next process when it receives this interrupt
            PTABLE_IDX.fetch_add(1, Ordering::SeqCst);
        } else {
            // we've reached the end of PTABLE, so time to reset this
            PTABLE_IDX.store(0, Ordering::SeqCst);
        }
    }

    if ACTIVE_LAPIC_ID.load(Ordering::SeqCst) == 0 {
        // initialize with first LAPIC ID
        ACTIVE_LAPIC_ID.store(get_lapic_ids().next().unwrap(), Ordering::SeqCst);

        // get the ball rolling
        unsafe { get_active_lapic().send_ipi(100, get_lapic_ids().cycle().nth(1).unwrap()) };
    } else {
        // need to store this in a variable in order to ensure that `.next()` matches the correct core ID
        let mut lapic_iter = get_lapic_ids().cycle();

        if lapic_iter.any(|id| id == ACTIVE_LAPIC_ID.load(Ordering::SeqCst)) {
            // find the next LAPIC ID after the current one
            // Note that because we're using `.cycle` this will never be None
            let id = lapic_iter.next().unwrap();

            // update active LAPIC ID to match the next one
            ACTIVE_LAPIC_ID.store(id, Ordering::SeqCst);

            // send the very IPI that this handler handles to the next available CPU core on the system
            unsafe { get_active_lapic().send_ipi(100, ACTIVE_LAPIC_ID.load(Ordering::SeqCst)) };
        } else {
            unreachable!()
        }
    }

    unsafe {
        get_active_lapic().end_of_interrupt();
    };
}

extern "x86-interrupt" fn bound_range_exceeded(frame: InterruptStackFrame) {
    if let PrivilegeLevel::Ring0 = current_privilege_level(*frame) {
        panic!("Bound range exceeded\nStack frame: {:#?}", frame);
    } else {
        (PTABLE.read())[&PTABLE_IDX.load(Ordering::SeqCst)]
            .write()
            .kill(Signal::SIGFPE);
    }
}

extern "x86-interrupt" fn invalid_op(frame: InterruptStackFrame) {
    let offender = unsafe { *((frame.instruction_pointer.as_u64()) as *const u32) };
    let mut flags = Efer::read();

    if !flags.contains(EferFlags::SYSTEM_CALL_EXTENSIONS) {
        // Enable syscall extensions and try again

        flags.insert(EferFlags::SYSTEM_CALL_EXTENSIONS);
        unsafe { Efer::write(flags) };
    } else if let PrivilegeLevel::Ring0 = current_privilege_level(*frame) {
        panic!(
            "Invalid opcode\nOffending instruction: {:#x?}\nStack frame: {:#?}",
            offender.to_be_bytes(),
            frame
        );
    } else {
        (PTABLE.read())[&PTABLE_IDX.load(Ordering::SeqCst)]
            .write()
            .kill(Signal::SIGILL);
    }
}

extern "x86-interrupt" fn navail(frame: InterruptStackFrame) {
    if let PrivilegeLevel::Ring0 = current_privilege_level(*frame) {
        panic!("Device not available\nStack frame: {:#?}", frame);
    } else {
        (PTABLE.read())[&PTABLE_IDX.load(Ordering::SeqCst)]
            .write()
            .kill(Signal::SIGSYS);
    }
}

extern "x86-interrupt" fn breakpoint(_frame: InterruptStackFrame) {
    debug!("Reached breakpoint; waiting for debugger to give the all-clear");
    loop {
        let int3_ip = read_rip().as_u64();

        // 0xcc is the INT3 opcode
        if unsafe { *(int3_ip as *const u8) != 0xcc } {
            debug!("Resuming");
            break;
        }
    }
}

extern "x86-interrupt" fn double_fault(frame: InterruptStackFrame, _code: u64) -> ! {
    panic!(
        "Double fault at address {:#x}\nBacktrace: {:#?}",
        frame.instruction_pointer.as_u64(),
        frame
    );
}

extern "x86-interrupt" fn page_fault(frame: InterruptStackFrame, code: PageFaultErrorCode) {
    if code.is_empty() {
        // Create and map the nonexistent page and try again
        if let Ok(cr2) = Cr2::read() {
            let virt = Page::<Size4KiB>::containing_address(cr2)
                .start_address()
                .as_u64();

            let phys = if cr2.as_u64() < get_phys_offset() {
                cr2.as_u64()
            } else {
                cr2.as_u64() - get_phys_offset()
            };

            map_page!(
                phys,
                virt,
                Size4KiB,
                PageTableFlags::PRESENT
                    | PageTableFlags::WRITABLE
                    | PageTableFlags::NO_CACHE
                    | PageTableFlags::WRITE_THROUGH
            );

            unsafe { frame.iretq() }
        };
    } else if let PrivilegeLevel::Ring0 = CS::get_reg().rpl()
        && code.contains(PageFaultErrorCode::INSTRUCTION_FETCH)
        && code.contains(PageFaultErrorCode::PROTECTION_VIOLATION)
    {
        // Use EFER to check if XD bit is enabled, then clear it and try again
        let mut flags = Efer::read();
        flags &= !EferFlags::NO_EXECUTE_ENABLE;

        unsafe {
            Efer::write(flags);
            frame.iretq();
        }

        // TODO: Re-enable this when it comes time to set up user mode
    } else if let PrivilegeLevel::Ring0 = CS::get_reg().rpl() {
        // kernel mode
        panic!(
            "Page fault: Attempt to access address {:#x} returned a {:#?} error\n Backtrace: {:#?}",
            Cr2::read().unwrap(),
            code,
            frame
        );
    } else {
        // user mode
        (PTABLE.read())[&PTABLE_IDX.load(Ordering::SeqCst)]
            .write()
            .kill(Signal::SIGSEGV);
    }
}

extern "x86-interrupt" fn sigfpe(frame: InterruptStackFrame) {
    if let PrivilegeLevel::Ring0 = current_privilege_level(*frame) {
        panic!("Attempt to divide by zero\nBacktrace: {:#?}", frame);
    } else {
        (PTABLE.read())[&PTABLE_IDX.load(Ordering::SeqCst)]
            .write()
            .kill(Signal::SIGFPE);
    }
}
extern "x86-interrupt" fn invalid_tss(frame: InterruptStackFrame, code: u64) {
    error!(
        "Invalid TSS at segment selector {:#?}\nBacktrace: {:#?}",
        code, frame
    );
}

extern "x86-interrupt" fn sigbus(frame: InterruptStackFrame, code: u64) {
    let selector = SelectorErrorCode::new_truncate(code);

    if let PrivilegeLevel::Ring0 = current_privilege_level(*frame) {
        panic!(
            "Segment selector at index {:#?} is not present\n\
            Descriptor table involved: {:#?}\n\
            Is external? {}\n\
            Is null? {}\n\
            Backtrace: {:#?}",
            match CpuId::new().get_hypervisor_info() {
                Some(hypervisor) =>
                    if let Hypervisor::QEMU = hypervisor.identify() {
                        selector.index() / 2
                    } else {
                        selector.index()
                    },
                None => selector.index(),
            },
            selector.descriptor_table(),
            match selector.external() {
                true => "Yes",
                false => "No",
            },
            match selector.is_null() {
                true => "Yes",
                false => "No",
            },
            frame
        );
    } else {
        (PTABLE.read())[&PTABLE_IDX.load(Ordering::SeqCst)]
            .write()
            .kill(Signal::SIGBUS);
    }
}

extern "x86-interrupt" fn sigsegv(frame: InterruptStackFrame, code: u64) {
    let is_caused_by_np = match code {
        0 => None,
        sel => Some(sel),
    };

    if let PrivilegeLevel::Ring0 = current_privilege_level(*frame) {
        if let Some(code) = is_caused_by_np {
            let selector = SelectorErrorCode::new_truncate(code);
            panic!(
                "Segment selector at index {:#?} caused a stack segment fault\nBacktrace: {:#?}",
                match CpuId::new().get_hypervisor_info() {
                    Some(hypervisor) =>
                        if let Hypervisor::QEMU = hypervisor.identify() {
                            selector.index() / 2
                        } else {
                            selector.index()
                        },
                    None => selector.index(),
                },
                frame
            );
        } else {
            panic!(
                "Stack segment fault of unknown cause\nBacktrace: {:#?}",
                frame
            );
        }
    } else {
        (PTABLE.read())[&PTABLE_IDX.load(Ordering::SeqCst)]
            .write()
            .kill(Signal::SIGSEGV);
    }
}

extern "x86-interrupt" fn general_protection(frame: InterruptStackFrame, code: u64) {
    let is_seg_related = match code {
        0 => None,
        sel => Some(sel),
    };

    if let PrivilegeLevel::Ring0 = current_privilege_level(*frame) {
        if let Some(code) = is_seg_related {
            let selector = SelectorErrorCode::new_truncate(code);
            panic!(
                "Segment selector at index {:#?} caused a general protection fault\n\
                Descriptor table involved: {:#?}\n\
                Is external? {}\n\
                Is null? {}\n\
                Backtrace: {:#?}",
                match CpuId::new().get_hypervisor_info() {
                    Some(hypervisor) =>
                        if let Hypervisor::QEMU = hypervisor.identify() {
                            selector.index() / 2
                        } else {
                            selector.index()
                        },
                    None => selector.index(),
                },
                selector.descriptor_table(),
                match selector.external() {
                    true => "Yes",
                    false => "No",
                },
                match selector.is_null() {
                    true => "Yes",
                    false => "No",
                },
                frame
            );
        } else {
            panic!(
                "General protection fault of unknown cause\nBacktrace: {:#?}",
                frame
            )
        }
    } else {
        (PTABLE.read())[&PTABLE_IDX.load(Ordering::SeqCst)]
            .write()
            .kill(Signal::SIGABRT);
    }
}

pub extern "x86-interrupt" fn pin_inta(_frame: InterruptStackFrame) {
    info!("Received IntA interrupt");
    unsafe { get_active_lapic().end_of_interrupt() };
}

pub extern "x86-interrupt" fn pin_intb(_frame: InterruptStackFrame) {
    info!("Received IntB interrupt");
    unsafe { get_active_lapic().end_of_interrupt() };
}

pub extern "x86-interrupt" fn pin_intc(_frame: InterruptStackFrame) {
    info!("Received IntC interrupt");
    unsafe { get_active_lapic().end_of_interrupt() };
}

pub extern "x86-interrupt" fn pin_intd(_frame: InterruptStackFrame) {
    info!("Received IntD interrupt");
    unsafe { get_active_lapic().end_of_interrupt() };
}

pub extern "x86-interrupt" fn pci(frame: InterruptStackFrame) {
    debug!("Received PCI interrupt: {:#?}", &frame);
    unsafe { get_active_lapic().end_of_interrupt() };
}

pub extern "x86-interrupt" fn ahci(_: InterruptStackFrame) {
    // Source: https://wiki.osdev.org/AHCI#IRQ_handler

    // Read and write back global HBA interrupt status
    let status = get_hba().interrupt_status.get();
    info!("AHCI: Global interrupt status: {:#?}", status);

    get_hba().interrupt_status.set(status);

    // Read and write back port interrupt status
    for port in get_ahci().write().ports.as_mut().iter_mut().flatten() {
        let port_status = port.inner.write().hba_port().interrupt_status.get();

        info!("AHCI: Port interrupt status: {:#?}", port_status);

        // Check error bit and debug if set
        if port_status.contains(HbaPortInterruptStatus::HOST_BUS_DATA_ERR) {
            warn!("AHCI: Host bus data error");
        } else if port_status.contains(HbaPortInterruptStatus::HOST_BUS_FATAL_ERR) {
            warn!("AHCI: Host bus file error");
        } else if port_status.contains(HbaPortInterruptStatus::TASK_FILE_ERR) {
            warn!("AHCI: Task file error");
        } else if port_status.contains(HbaPortInterruptStatus::COLD_PORT_DETECT) {
            warn!("AHCI: Cold port detected");
        }

        port.inner
            .write()
            .hba_port()
            .interrupt_status
            .set(port_status);
    }

    unsafe { get_active_lapic().end_of_interrupt() };
}

pub extern "x86-interrupt" fn syscall(_: InterruptStackFrame) {
    let syscall_rip = LStar::read();
    let _syscall_instruction = unsafe { *(syscall_rip.as_u64() as *mut fn() -> dyn SyscallRet) };

    let _syscall_rflags = SFMask::read();
    let _syscall_cs = CS::get_reg();

    let mut syscall_iret: u64;

    unsafe {
        asm!("mov {0:r}, rcx", out(reg) syscall_iret);
    }

    // TODO: get syscall arguments from rdi, rsi, rdx, r10, r8, r9

    match syscall_iret {
        0x0 => todo!("sys_exit"),
        0x1 => todo!("sys_fork"),
        0x2 => todo!("sys_read"),
        0x3 => todo!("sys_write"),
        0x4 => todo!("sys_open"),
        0x5 => todo!("sys_close"),
        0x6 => todo!("sys_wait"),
        0x7 => todo!("sys_creat"),
        0x8 => todo!("sys_link"),
        0x9 => todo!("sys_unlink"),
        0xa => todo!("sys_exec"),
        0xb => todo!("sys_chdir"),
        0xc => todo!("sys_time"),
        0xd => todo!("sys_mknod"),
        0xe => todo!("sys_chmod"),
        0xf => todo!("sys_chown"),
        0x10 => todo!("sys_break"),
        0x11 => todo!("sys_stat"),
        0x12 => todo!("sys_lseek"),
        0x13 => todo!("sys_getpid"),
        0x14 => todo!("sys_mount"),
        0x15 => todo!("sys_umount"),
        0x16 => todo!("sys_setuid"),
        0x17 => todo!("sys_getuid"),
        0x18 => todo!("sys_stime"),
        0x19 => todo!("sys_ptrace"),
        0x1a => todo!("sys_alarm"),
        0x1b => todo!("sys_fstat"),
        0x1c => todo!("sys_pause"),
        0x1d => todo!("sys_utime"),
        0x1e => todo!("sys_stty"),
        0x1f => todo!("sys_gtty"),
        0x20 => todo!("sys_access"),
        0x21 => todo!("sys_nice"),
        0x22 => todo!("sys_ftime"),
        0x23 => todo!("sys_sync"),
        0x24 => todo!("sys_kill"),
        0x25 => todo!("sys_rename"),
        0x26 => todo!("sys_mkdir"),
        0x27 => todo!("sys_rmdir"),
        0x28 => todo!("sys_dup"),
        0x29 => todo!("sys_pipe"),
        0x2a => todo!("sys_times"),
        0x2b => todo!("sys_prof"),
        0x2c => todo!("sys_brk"),
        0x2d => todo!("sys_setgid"),
        0x2e => todo!("sys_getgid"),
        0x2f => todo!("sys_signal"),
        0x30 => todo!("sys_geteuid"),
        0x31 => todo!("sys_getegid"),
        0x32 => todo!("sys_acct"),
        0x33 => todo!("sys_phys"),
        0x34 => todo!("sys_lock"),
        0x35 => todo!("sys_ioctl"),
        0x36 => todo!("sys_fcntl"),
        0x37 => todo!("sys_mpx"),
        0x38 => todo!("sys_setpgid"),
        0x39 => todo!("sys_ulimit"),
        0x3a => todo!("sys_uname"),
        0x3b => todo!("sys_chroot"),
        0x3c => todo!("sys_ustat"),
        0x3d => todo!("sys_dup2"),
        0x3e => todo!("sys_getppid"),
        0x3f => todo!("sys_getpgrp"),
        0x40 => todo!("sys_setsid"),
        0x41 => todo!("sys_sigaction"),
        0x42 => todo!("sys_sgetmask"),
        0x43 => todo!("sys_ssetmask"),
        0x44 => todo!("sys_setreuid"),
        0x45 => todo!("sys_setregid"),
        0x46 => todo!("sys_sigsuspend"),
        0x47 => todo!("sys_sigpending"),
        0x48 => todo!("sys_sethostname"),
        0x49 => todo!("sys_setrlimit"),
        0x4a => todo!("sys_getrlimit"),
        0x4b => todo!("sys_getrusage"),
        0x4c => todo!("sys_gettimeofday"),
        0x4d => todo!("sys_settimeofday"),
        0x4e => todo!("sys_getgroups"),
        0x4f => todo!("sys_setgroups"),
        0x50 => todo!("sys_select"),
        0x51 => todo!("sys_symlink"),
        0x52 => todo!("sys_lstat"),
        0x53 => todo!("sys_readlink"),
        0x54 => todo!("sys_uselib"),
        0x55 => todo!("sys_swapon"),
        0x56 => todo!("sys_reboot"),
        0x57 => todo!("sys_readdir"),
        0x58 => todo!("sys_mmap"),
        0x59 => todo!("sys_munmap"),
        0x5a => todo!("sys_truncate"),
        0x5b => todo!("sys_ftruncate"),
        0x5c => todo!("sys_fchmod"),
        0x5d => todo!("sys_fchown"),
        0x5e => todo!("sys_getpriority"),
        0x5f => todo!("sys_setpriority"),
        0x60 => todo!("sys_profil"),
        0x61 => todo!("sys_statfs"),
        0x62 => todo!("sys_fstatfs"),
        0x63 => todo!("sys_ioperm"),
        0x64 => todo!("sys_socketcall"),
        0x65 => todo!("sys_syslog"),
        0x66 => todo!("sys_setitimer"),
        0x67 => todo!("sys_getitimer"),
        0x68 => todo!("sys_stat"),
        0x69 => todo!("sys_lstat"),
        0x6a => todo!("sys_fstat"),
        0x6b => todo!("sys_uname"),
        0x6c => todo!("sys_iopl"),
        0x6d => todo!("sys_vhangup"),
        0x6e => todo!("sys_idle"),
        0x6f => todo!("sys_vm86"),
        0x70 => todo!("sys_wait4"),
        0x71 => todo!("sys_swapoff"),
        0x72 => todo!("sys_sysinfo"),
        0x73 => todo!("sys_ipc"),
        0x74 => todo!("sys_fsync"),
        0x75 => todo!("sys_sigreturn"),
        0x76 => todo!("sys_clone"),
        0x77 => todo!("sys_setdomainname"),
        0x78 => todo!("sys_uname"),
        0x79 => todo!("sys_adjtimex"),
        0x7a => todo!("sys_mprotect"),
        0x7b => todo!("sys_sigprocmask"),
        0x7c => todo!("sys_create_module"),
        0x7d => todo!("sys_init_module"),
        0x7e => todo!("sys_delete_module"),
        0x7f => todo!("sys_get_kernel_syms"),
        0x80 => todo!("sys_quotactl"),
        0x81 => todo!("sys_getpgid"),
        0x82 => todo!("sys_fchdir"),
        0x83 => todo!("sys_bdflush"),
        0x84 => todo!("sys_sysfs"),
        0x85 => todo!("sys_personality"),
        0x86 => todo!("sys_afs_syscall"),
        0x87 => todo!("sys_setfsuid"),
        0x88 => todo!("sys_setfsgid"),
        0x89 => todo!("sys__llseek"),
        0x8a => todo!("sys_getdents"),
        0x8b => todo!("sys__newselect"),
        0x8c => todo!("sys_flock"),
        0x8d => todo!("sys_msync"),
        0x8e => todo!("sys_readv"),
        0x8f => todo!("sys_writev"),
        0x90 => todo!("sys_getsid"),
        0x91 => todo!("sys_fdatasync"),
        0x92 => todo!("sys__sysctl"),
        0x93 => todo!("sys_mlock"),
        0x94 => todo!("sys_munlock"),
        0x95 => todo!("sys_mlockall"),
        0x96 => todo!("sys_munlockall"),
        0x97 => todo!("sys_sched_setparam"),
        0x98 => todo!("sys_sched_getparam"),
        0x99 => todo!("sys_sched_setscheduler"),
        0x9a => todo!("sys_sched_getscheduler"),
        0x9b => todo!("sys_sched_yield"),
        0x9c => todo!("sys_sched_get_priority_max"),
        0x9d => todo!("sys_sched_get_priority_min"),
        0x9e => todo!("sys_sched_rr_get_interval"),
        0x9f => todo!("sys_nanosleep"),
        0xa0 => todo!("sys_mremap"),
        0xa1 => todo!("sys_setresuid"),
        0xa2 => todo!("sys_getresuid"),
        0xa3 => todo!("sys_vm86"),
        0xa4 => todo!("sys_query_module"),
        0xa5 => todo!("sys_poll"),
        0xa6 => todo!("sys_nfsservctl"),
        0xa7 => todo!("sys_setresgid"),
        0xa8 => todo!("sys_getresgid"),
        0xa9 => todo!("sys_prctl"),
        0xaa => todo!("sys_rt_sigreturn"),
        0xab => todo!("sys_rt_sigaction"),
        0xac => todo!("sys_rt_sigprocmask"),
        0xad => todo!("sys_rt_sigpending"),
        0xae => todo!("sys_rt_sigtimedwait"),
        0xaf => todo!("sys_rt_sigqueueinfo"),
        0xb0 => todo!("sys_rt_sigsuspend"),
        0xb1 => todo!("sys_pread64"),
        0xb2 => todo!("sys_pwrite64"),
        0xb3 => todo!("sys_chown"),
        0xb4 => todo!("sys_getcwd"),
        0xb5 => todo!("sys_capget"),
        0xb6 => todo!("sys_capset"),
        0xb7 => todo!("sys_sigaltstack"),
        0xb8 => todo!("sys_sendfile"),
        0xb9 => todo!("sys_getpmsg"),
        0xba => todo!("sys_putpmsg"),
        0xbb => todo!("sys_vfork"),
        0xbc => todo!("sys_ugetrlimit"),
        0xbd => todo!("sys_mmap2"),
        0xbe => todo!("sys_truncate64"),
        0xbf => todo!("sys_ftruncate64"),
        0xc0 => todo!("sys_stat64"),
        0xc1 => todo!("sys_lstat64"),
        0xc2 => todo!("sys_fstat64"),
        0xc3 => todo!("sys_lchown32"),
        0xc4 => todo!("sys_getuid32"),
        0xc5 => todo!("sys_getgid32"),
        0xc6 => todo!("sys_geteuid32"),
        0xc7 => todo!("sys_getegid32"),
        0xc8 => todo!("sys_setreuid32"),
        0xc9 => todo!("sys_setregid32"),
        0xca => todo!("sys_getgroups32"),
        0xcb => todo!("sys_setgroups32"),
        0xcc => todo!("sys_fchown32"),
        0xcd => todo!("sys_setresuid32"),
        0xce => todo!("sys_getresuid32"),
        0xcf => todo!("sys_setresgid32"),
        0xd0 => todo!("sys_getresgid32"),
        0xd1 => todo!("sys_chown32"),
        0xd2 => todo!("sys_setuid32"),
        0xd3 => todo!("sys_setgid32"),
        0xd4 => todo!("sys_setfsuid32"),
        0xd5 => todo!("sys_setfsgid32"),
        0xd6 => todo!("sys_pivot_root"),
        0xd7 => todo!("sys_mincore"),
        0xd8 => todo!("sys_madvise"),
        0xd9 => todo!("sys_getdents64"),
        0xda => todo!("sys_fcntl64"),
        0xdb => todo!("sys_reserved221"),
        0xdc => todo!("sys_gettid"),
        0xdd => todo!("sys_readahead"),
        0xde => todo!("sys_setxattr"),
        0xdf => todo!("sys_lsetxattr"),
        0xe0 => todo!("sys_fsetxattr"),
        0xe1 => todo!("sys_getxattr"),
        0xe2 => todo!("sys_lgetxattr"),
        0xe3 => todo!("sys_fgetxattr"),
        0xe4 => todo!("sys_listxattr"),
        0xe5 => todo!("sys_llistxattr"),
        0xe6 => todo!("sys_flistxattr"),
        0xe7 => todo!("sys_removexattr"),
        0xe8 => todo!("sys_lremovexattr"),
        0xe9 => todo!("sys_fremovexattr"),
        0xea => todo!("sys_tkill"),
        0xeb => todo!("sys_reserved236"),
        0xec => todo!("sys_futex"),
        0xed => todo!("sys_sched_setaffinity"),
        0xee => todo!("sys_sched_getaffinity"),
        0xef => todo!("sys_cacheflush"),
        0xf0 => todo!("sys_cachectl"),
        0xf1 => todo!("sys_sysmips"),
        0xf2 => todo!("sys_io_setup"),
        0xf3 => todo!("sys_io_destroy"),
        0xf4 => todo!("sys_io_getevents"),
        0xf5 => todo!("sys_io_submit"),
        0xf6 => todo!("sys_io_cancel"),
        0xf7 => todo!("sys_exit_group"),
        0xf8 => todo!("sys_lookup_dcookie"),
        0xf9 => todo!("sys_epoll_create"),
        0xfa => todo!("sys_epoll_ctl"),
        0xfb => todo!("sys_epoll_wait"),
        0xfc => todo!("sys_remap_file_pages"),
        0xfd => todo!("sys_set_thread_area"),
        0xfe => todo!("sys_get_thread_area"),
        0xff => todo!("sys_set_tid_address"),
        _ => unimplemented!(),
    }
}

#[inline(always)]
pub fn is_enabled() -> bool {
    rflags::read().contains(RFlags::INTERRUPT_FLAG)
}

#[inline(always)]
pub(crate) unsafe fn disable_interrupts() {
    interrupts::disable();
}

#[inline(always)]
pub(crate) unsafe fn enable_interrupts() {
    interrupts::enable();
}

/// Function that searches for an open entry in the IDT to map a new handler to
pub fn irqalloc() -> u8 {
    for i in 32..=255 {
        if IDT.read()[i] == Entry::missing() {
            return i;
        }
    }
    // we've exhausted all entries at this point
    panic!("Out of IRQs!")
}

/// Indexes a new handler at a new IDT entry created by `irqalloc()` fn
pub fn register_handler(irq: u8, handler: extern "x86-interrupt" fn(InterruptStackFrame)) {
    IDT.write()[irq].set_handler_fn(handler);
    init();
}
