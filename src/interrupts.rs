use core::convert::identity;

use alloc::sync::Arc;
use raw_cpuid::{CpuId, Hypervisor, HypervisorInfo};
use x86_64::{
    instructions::interrupts,
    registers::{
        read_rip,
        rflags::{self, RFlags},
    },
    structures::idt::{DescriptorTable, SelectorErrorCode},
};

use crate::{
    ahci::{get_ahci, AhciPort},
    PRINTK,
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
    IDT.load();
}

pub const QEMU_STATUS_FAIL: u32 = 0x11;

pub static INTA_IRQ: AtomicU64 = AtomicU64::new(0);
pub static INTB_IRQ: AtomicU64 = AtomicU64::new(0);
pub static INTC_IRQ: AtomicU64 = AtomicU64::new(0);
pub static INTD_IRQ: AtomicU64 = AtomicU64::new(0);

lazy_static! {
    pub static ref IDT: InterruptDescriptorTable = {
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
        idt[INTA_IRQ.load(Ordering::SeqCst) as usize].set_handler_fn(pin_inta);
        idt[INTB_IRQ.load(Ordering::SeqCst) as usize].set_handler_fn(pin_intb);
        idt[INTC_IRQ.load(Ordering::SeqCst) as usize].set_handler_fn(pin_intc);
        idt[INTD_IRQ.load(Ordering::SeqCst) as usize].set_handler_fn(pin_intd);
        idt[139].set_handler_fn(ahci0);
        idt[0x82].set_handler_fn(spurious);
        idt[151].set_handler_fn(ahci1);
        idt
    };
}

pub static TICK_COUNT: AtomicU64 = AtomicU64::new(0);
pub static PID: AtomicU64 = AtomicU64::new(0);

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
    TICK_COUNT.fetch_add(1, Ordering::SeqCst);
    debug!("{:#?}", &TICK_COUNT.load(Ordering::SeqCst));
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
        let int3_ip = read_rip().as_u64();
        let ret_ip = frame.instruction_pointer.as_u64();

        // 0xcc is the INT3 opcode
        if unsafe { *(int3_ip as *const u8) != *(ret_ip as *const u8) } {
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
}

extern "x86-interrupt" fn sigsegv(frame: InterruptStackFrame, code: u64) {
    let is_caused_by_np = match code {
        0 => None,
        sel => Some(sel),
    };

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
}

extern "x86-interrupt" fn general_protection(frame: InterruptStackFrame, code: u64) {
    let is_seg_related = match code {
        0 => None,
        sel => Some(sel),
    };
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
}

pub extern "x86-interrupt" fn pin_inta(_frame: InterruptStackFrame) {
    info!("Received IntA interrupt");
    unsafe { LOCAL_APIC.lock().as_mut().unwrap().end_of_interrupt() }
}

pub extern "x86-interrupt" fn pin_intb(_frame: InterruptStackFrame) {
    info!("Received IntB interrupt");
    unsafe { LOCAL_APIC.lock().as_mut().unwrap().end_of_interrupt() }
}

pub extern "x86-interrupt" fn pin_intc(_frame: InterruptStackFrame) {
    info!("Received IntC interrupt");
    unsafe { LOCAL_APIC.lock().as_mut().unwrap().end_of_interrupt() }
}

pub extern "x86-interrupt" fn pin_intd(_frame: InterruptStackFrame) {
    info!("Received IntD interrupt");
    unsafe { LOCAL_APIC.lock().as_mut().unwrap().end_of_interrupt() }
}

pub extern "x86-interrupt" fn ahci0(frame: InterruptStackFrame) {
    debug!("Received AHCI interrupt: {:#?}", &frame);

    // Read and write back global interrupt status
    let global_is_read_guard = get_ahci().inner.read();
    let global_is = global_is_read_guard.hba_mem().get_global_is();
    drop(global_is_read_guard);

    let global_is_write_guard = get_ahci().inner.write();
    global_is_write_guard.hba_mem().set_global_is(global_is);
    drop(global_is_write_guard);

    // Read and write back the interrupt status of all HBA ports
    for p in get_ahci()
        .inner
        .write()
        .ports()
        .iter()
        .filter(|p| p.is_some())
        .map(|p| p.as_ref().unwrap())
    {
        let is_read_guard = p.inner.read();
        let is = p.inner.read().hba_port().is.get();
        drop(is_read_guard);

        let mut is_write_guard = p.inner.write();
        is_write_guard.hba_port_mut().is.set(is);
        drop(is_write_guard);
    }

    unsafe { LOCAL_APIC.lock().as_mut().unwrap().end_of_interrupt() }
}

pub extern "x86-interrupt" fn ahci1(frame: InterruptStackFrame) {
    debug!("Received AHCI interrupt: {:#?}", &frame);

    // Read and write back global interrupt status
    let global_is_read_guard = get_ahci().inner.read();
    let global_is = global_is_read_guard.hba_mem().get_global_is();
    drop(global_is_read_guard);

    let global_is_write_guard = get_ahci().inner.write();
    global_is_write_guard.hba_mem().set_global_is(global_is);
    drop(global_is_write_guard);

    // Read and write back the interrupt status of all HBA ports
    for p in get_ahci()
        .inner
        .write()
        .ports()
        .iter()
        .filter(|p| p.is_some())
        .map(|p| p.as_ref().unwrap())
    {
        let is_read_guard = p.inner.read();
        let is = p.inner.read().hba_port().is.get();
        drop(is_read_guard);

        let mut is_write_guard = p.inner.write();
        is_write_guard.hba_port_mut().is.set(is);
        drop(is_write_guard);
    }

    unsafe { LOCAL_APIC.lock().as_mut().unwrap().end_of_interrupt() }
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
