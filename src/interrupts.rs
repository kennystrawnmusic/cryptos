use x86_64::{
    instructions::interrupts,
    registers::rflags::{self, RFlags},
    structures::idt::SelectorErrorCode,
};

#[allow(unused_imports)]
use {
    crate::apic_impl::LOCAL_APIC,
    core::sync::atomic::{AtomicU64, Ordering},
    lazy_static::lazy_static,
    log::{debug, error, info},
    spin::Mutex,
    x86_64::{
        registers::control::Cr2,
        structures::idt::{InterruptDescriptorTable, InterruptStackFrame, PageFaultErrorCode},
    },
};

pub fn init() {
    crate::exceptions::init();
    IDT_CLONE.load();
}

pub const QEMU_STATUS_FAIL: u32 = 0x11;

const INT3_OPCODE: u8 = 0xcc;

lazy_static! {
    pub static ref IDT_CLONE: InterruptDescriptorTable = IDT.lock().clone();
    pub static ref IDT: Mutex<InterruptDescriptorTable> = {
        let mut idt = InterruptDescriptorTable::new();
        unsafe {
            idt.double_fault
                .set_handler_fn(double_fault)
                .set_stack_index(crate::exceptions::DOUBLE_FAULT_STACK_INDEX);

            idt.page_fault
                .set_handler_fn(page_fault)
                .set_stack_index(crate::exceptions::PAGE_FAULT_STACK_INDEX);
            idt.divide_error
                .set_handler_fn(sigfpe)
                .set_stack_index(crate::exceptions::DIV_ERR_STACK_INDEX);
            idt.invalid_tss
                .set_handler_fn(invalid_tss)
                .set_stack_index(crate::exceptions::INVALID_TSS_STACK_INDEX);
            idt.segment_not_present
                .set_handler_fn(sigbus)
                .set_stack_index(crate::exceptions::SIGBUS_STACK_INDEX);
            idt.stack_segment_fault
                .set_handler_fn(sigsegv)
                .set_stack_index(crate::exceptions::SIGSEGV_STACK_INDEX);
            idt.general_protection_fault
                .set_handler_fn(general_protection)
                .set_stack_index(crate::exceptions::GPF_STACK_INDEX);
        }

        idt.breakpoint.set_handler_fn(breakpoint);
        idt.bound_range_exceeded
            .set_handler_fn(bound_range_exceeded);
        idt.invalid_opcode.set_handler_fn(invalid_op);
        idt.device_not_available.set_handler_fn(navail);
        idt[IrqIndex::Timer as usize].set_handler_fn(timer);
        idt[IrqIndex::LapicErr as usize].set_handler_fn(lapic_err);
        idt[IrqIndex::Spurious as usize].set_handler_fn(spurious);
        idt[43].set_handler_fn(dummy_ahci);
        idt[151].set_handler_fn(dummy_ahci);
        idt[0x82].set_handler_fn(spurious);
        Mutex::new(idt)
    };
}

pub static TICK_COUNT: AtomicU64 = AtomicU64::new(0);
pub static PID: AtomicU64 = AtomicU64::new(0);

#[derive(Debug, Clone, Copy)]
#[repr(u8)]
pub enum IrqIndex {
    Timer = 0xfe,     // 32
    LapicErr = 0x31,  // 49
    IpiWake = 0x40,   // 64
    IpiTlb = 0x41,    // 65
    IpiSwitch = 0x42, // 66
    IpiPit = 0x43,    // 67
    Spurious = 0xff,  // 254
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

extern "x86-interrupt" fn bound_range_exceeded(frame: InterruptStackFrame) {
    panic!("Bound range exceeded\nStack frame: {:#?}", frame);
}

extern "x86-interrupt" fn invalid_op(frame: InterruptStackFrame) {
    let offender = unsafe { *((frame.instruction_pointer.as_u64()) as *const u32) };
    panic!(
        "Invalid opcode\nOffending instruction: {:#x?}\nStack frame: {:#?}",
        offender.to_be_bytes(),
        frame
    );
}

extern "x86-interrupt" fn navail(frame: InterruptStackFrame) {
    panic!("Device not available\nStack frame: {:#?}", frame);
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

extern "x86-interrupt" fn sigbus(frame: InterruptStackFrame, code: u64) {
    let selector = SelectorErrorCode::new_truncate(code);
    panic!(
        "Segment selector at index {:#?} is not present\n\
        Descriptor table involved: {:#?}\n\
        Is external? {}\n\
        Is null? {}\n\
        Backtrace: {:#?}",
        selector.index(),
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
}

extern "x86-interrupt" fn sigsegv(frame: InterruptStackFrame, code: u64) {
    let is_caused_by_np = match code {
        0 => None,
        sel => Some(sel),
    };

    if let Some(seg) = is_caused_by_np {
        panic!(
            "Segment selector at index {:#?} caused a stack segment fault\nBacktrace: {:#?}",
            seg, frame
        );
    } else {
        panic!(
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
        panic!(
            "Segment selector at index {:#?} caused a general protection fault\nBacktrace: {:#?}",
            code, frame
        );
    } else {
        panic!(
            "General protection fault of unknown cause\nBacktrace: {:#?}",
            frame
        )
    }
}

// FIXME: if this is indeed the cause of the #10 page fault, figure out why
pub extern "x86-interrupt" fn dummy_ahci(frame: InterruptStackFrame) {
    info!("Received AHCI interrupt: {:#?}", &frame)
}

// #[allow(dead_code)]
// pub extern "x86-interrupt" fn ahci(_frame: InterruptStackFrame) {
//     // Spinloop until all statics are initialized
//     while !ALL_DISKS.is_initialized() && GLOBAL_IS.read().is_none() {
//         core::hint::spin_loop();
//     }

//     // Reference: https://wiki.osdev.org/AHCI#IRQ_handler

//     // Checklist item 1
//     // TODO: listen for changes to this static and write them to the global IS itself
//     let global_interrupt = *GLOBAL_IS.read();
//     *GLOBAL_IS.write() = global_interrupt;

//     // Checklist item 2
//     for disk in ALL_DISKS.get().unwrap().write().iter_mut() {
//         let status = disk.read_interrupt_status();

//         if EIO_STATUS.read().is_none() {
//             disk.write_interrupt_status(status)
//         } else {
//             // Checklist item 3
//             match EIO_STATUS.read().as_ref().unwrap() {
//                 InterruptError::TaskFile => error!("{:#?}", crate::ahci_old::hba::EIO_DEBUG.read()),
//                 InterruptError::HostBusFatal => {
//                     error!("{:#?}", crate::ahci_old::hba::EIO_DEBUG.read())
//                 }
//                 InterruptError::HostBusData => {
//                     error!("{:#?}", crate::ahci_old::hba::EIO_DEBUG.read())
//                 }
//                 InterruptError::InterfaceFatal => {
//                     error!("{:#?}", crate::ahci_old::hba::EIO_DEBUG.read())
//                 }
//                 InterruptError::InvalidSlot => {
//                     error!("{:#?}", crate::ahci_old::hba::EIO_DEBUG.read())
//                 }
//             }
//         }
//     }
//     unsafe { LOCAL_APIC.lock().as_mut().unwrap().end_of_interrupt() }
// }

#[inline(always)]
pub fn is_enabled() -> bool {
    rflags::read().contains(RFlags::INTERRUPT_FLAG)
}

#[inline(always)]
pub unsafe fn disable_interrupts() {
    interrupts::disable();
}

#[inline(always)]
pub unsafe fn enable_interrupts() {
    interrupts::enable();
}
