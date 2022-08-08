#[allow(unused_imports)]
use {
    crate::apic_impl::LOCAL_APIC,
    core::sync::atomic::{AtomicU64, Ordering},
    lazy_static::lazy_static,
    log::{debug, error, info},
    x86_64::{
        registers::control::Cr2,
        structures::idt::{InterruptDescriptorTable, InterruptStackFrame, PageFaultErrorCode},
    },
};

pub fn init() {
    crate::exceptions::init();
    IDT.load();
    crate::apic_impl::init_all_available_apics();
}

const INT3_OPCODE: u8 = 0xcc;

lazy_static! {
    pub static ref IDT: InterruptDescriptorTable = {
        let mut idt = InterruptDescriptorTable::new();
        unsafe {
            idt.double_fault
                .set_handler_fn(double_fault)
                .set_stack_index(crate::exceptions::DOUBLE_FAULT_STACK_INDEX)
        };
        idt.page_fault.set_handler_fn(page_fault);
        idt.divide_error.set_handler_fn(sigfpe);
        idt.invalid_tss.set_handler_fn(invalid_tss);
        idt.segment_not_present.set_handler_fn(seg_404);
        idt.stack_segment_fault.set_handler_fn(sigsegv);
        idt.general_protection_fault
            .set_handler_fn(general_protection);
        idt.breakpoint.set_handler_fn(breakpoint);
        idt[IrqIndex::Timer as usize].set_handler_fn(timer);
        idt[IrqIndex::LapicErr as usize].set_handler_fn(lapic_err);
        idt[IrqIndex::Spurious as usize].set_handler_fn(spurious);
        idt
    };
}

pub static TICK_COUNT: AtomicU64 = AtomicU64::new(0);
pub static PID: AtomicU64 = AtomicU64::new(0);

#[derive(Debug, Clone, Copy)]
#[repr(u8)]
pub enum IrqIndex {
    Timer = 0x20,     // 32
    LapicErr = 0x31,  // 49
    IpiWake = 0x40,   // 64
    IpiTlb = 0x41,    // 65
    IpiSwitch = 0x42, // 66
    IpiPit = 0x43,    // 67
    AHCI = 0x44,      // 68
    Spurious = 0xfe,  // 254
}

extern "x86-interrupt" fn timer(_frame: InterruptStackFrame) {
    TICK_COUNT.fetch_add(1, Ordering::SeqCst);
    unsafe { LOCAL_APIC.lock().as_mut().unwrap().end_of_interrupt() }
}

extern "x86-interrupt" fn spurious(_frame: InterruptStackFrame) {
    debug!("Received spurious interrupt");
    unsafe { LOCAL_APIC.lock().as_mut().unwrap().end_of_interrupt() }
}

extern "x86-interrupt" fn lapic_err(_frame: InterruptStackFrame) {
    error!("Local APIC error; check the status for details");
    unsafe { LOCAL_APIC.lock().as_mut().unwrap().end_of_interrupt() }
}

#[allow(dead_code)]
extern "x86-interrupt" fn wake_ipi(_frame: InterruptStackFrame) {
    PID.fetch_add(1, Ordering::SeqCst);
    todo!("use a loop here as the process scheduler");
}

extern "x86-interrupt" fn breakpoint(frame: InterruptStackFrame) {
    debug!("Reached breakpoint; waiting for debugger to give the all-clear");
    loop {
        let int3_ip = frame.instruction_pointer.as_u64() - 1; //stack grows downwards

        // 0xcc is the INT3 opcode
        if unsafe { *(int3_ip as *const u8) } != INT3_OPCODE {
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
    )
}

extern "x86-interrupt" fn page_fault(frame: InterruptStackFrame, code: PageFaultErrorCode) {
    panic!(
        "Page fault: Attempt to access address {:#x} returned a {:#?} error\n Backtrace: {:#?}",
        Cr2::read(),
        code,
        frame
    );
}

extern "x86-interrupt" fn sigfpe(frame: InterruptStackFrame) {
    error!("Attempt to divide by zero\nBacktrace: {:#?}", frame);
}

extern "x86-interrupt" fn invalid_tss(frame: InterruptStackFrame, code: u64) {
    error!(
        "Invalid TSS at segment selector {:#?}\nBacktrace: {:#?}",
        code, frame
    );
}

extern "x86-interrupt" fn seg_404(frame: InterruptStackFrame, code: u64) {
    error!(
        "Segment selector at index {:#?} is not present\nBacktrace: {:#?}",
        code, frame
    );
}

extern "x86-interrupt" fn sigsegv(frame: InterruptStackFrame, code: u64) {
    let is_caused_by_np = match code {
        0 => None,
        sel => Some(sel),
    };

    if let Some(seg) = is_caused_by_np {
        error!(
            "Segment selector at index {:#?} caused a stack segment fault\nBacktrace: {:#?}",
            seg, frame
        );
    } else {
        error!(
            "Stack segment fault of unknown cause\nBacktrace: {:#?}",
            frame
        );
    }
}

extern "x86-interrupt" fn general_protection(frame: InterruptStackFrame, code: u64) {
    let is_seg_related = match code {
        0 => None,
        sel => Some(sel),
    };
    if let Some(code) = is_seg_related {
        error!(
            "Segment selector at index {:#?} caused a general protection fault\nBacktrace: {:#?}",
            code, frame
        );
    } else {
        error!(
            "General protection fault of unknown cause\nBacktrace: {:#?}",
            frame
        )
    }
}
