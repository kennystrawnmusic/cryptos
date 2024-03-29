use core::sync::atomic::{AtomicBool, Ordering};

use x2apic::lapic::xapic_base;
use x86_64::structures::paging::PageTableFlags;

use crate::get_phys_offset;

use {
    crate::{arch::x86_64::interrupts::IrqIndex, map_page, INTERRUPT_MODEL},
    acpi::InterruptModel,
    alloc::vec::Vec,
    x2apic::{
        ioapic::IoApic,
        lapic::{LocalApic, LocalApicBuilder},
    },
    x86_64::{instructions::port::Port, structures::paging::Size4KiB},
};

pub(crate) static APIC_IS_INITIALIZED: AtomicBool = AtomicBool::new(false);

/// Function returning an Iterator of all XAPIC IDs present on the system
///
/// Uses `raw_cpuid::ExtendedTopologyIter` to extract this information at runtime,
/// so this should work on pretty much all hardware
pub fn get_lapic_ids() -> impl Iterator<Item = u32> + Clone {
    let mut id_vec = Vec::new();

    if let Some(iter) = raw_cpuid::CpuId::new().get_extended_topology_info() {
        for topology in iter {
            id_vec.push(topology.x2apic_id());
        }
    } else {
        //only have one core
        id_vec.push(unsafe { get_active_lapic().id() });
    }

    id_vec.into_iter()
}

pub(crate) fn build_all_available_apics() -> Option<(LocalApic, Vec<IoApic>)> {
    unsafe {
        // Disable 8259 immediately

        let mut cmd_8259a = Port::<u8>::new(0x20);
        let mut data_8259a = Port::<u8>::new(0x21);
        let mut cmd_8259b = Port::<u8>::new(0xa0);
        let mut data_8259b = Port::<u8>::new(0xa1);

        let mut spin_port = Port::<u8>::new(0x80);
        let mut spin = || spin_port.write(0);

        cmd_8259a.write(0x11);
        cmd_8259b.write(0x11);
        spin();

        data_8259a.write(0xf8);
        data_8259b.write(0xff);
        spin();

        data_8259a.write(0b100);
        spin();

        data_8259b.write(0b10);
        spin();

        data_8259a.write(0x1);
        data_8259b.write(0x1);
        spin();

        data_8259a.write(u8::MAX);
        data_8259b.write(u8::MAX);
    };

    if let InterruptModel::Apic(apic) = INTERRUPT_MODEL.get().unwrap() {
        let offset = crate::get_phys_offset();
        let mut ioapic_impl_vec = Vec::new();

        let lapic_virt = apic.local_apic_address + offset;

        map_page!(
            apic.local_apic_address,
            lapic_virt,
            Size4KiB,
            PageTableFlags::PRESENT
                | PageTableFlags::WRITABLE
                | PageTableFlags::NO_CACHE
                | PageTableFlags::WRITE_THROUGH
        );

        let first_lapic = LocalApicBuilder::new()
            .timer_vector(IrqIndex::Timer as usize)
            .error_vector(IrqIndex::LapicErr as usize)
            .spurious_vector(IrqIndex::Spurious as usize)
            .set_xapic_base(lapic_virt)
            .build()
            .unwrap_or_else(|e| panic!("Error building the local APIC: {:#?}", e));

        for ioapic in apic.io_apics.iter() {
            let phys = ioapic.address as u64;
            let virt = phys + offset;

            ioapic_impl_vec.push(unsafe { IoApic::new(virt) });
            map_page!(
                phys,
                virt,
                Size4KiB,
                PageTableFlags::PRESENT
                    | PageTableFlags::WRITABLE
                    | PageTableFlags::NO_CACHE
                    | PageTableFlags::WRITE_THROUGH
            );
        }
        Some((first_lapic, ioapic_impl_vec))
    } else {
        None
    }
}

macro_rules! ioapic_irq {
    ($pic:expr, $irq:expr, $dest:expr) => {
        use x2apic::ioapic::{IrqFlags, IrqMode, RedirectionTableEntry};
        let mut e = RedirectionTableEntry::default();
        e.set_mode(IrqMode::Fixed);
        e.set_flags(IrqFlags::LEVEL_TRIGGERED | IrqFlags::LOW_ACTIVE);
        e.set_vector($irq as u8);
        e.set_dest($dest as u8);

        $pic.set_table_entry($irq, e);
        $pic.enable_irq($irq);
    };
}

pub(crate) fn init_all_available_apics() {
    let (lapic, ioapics) = build_all_available_apics().expect("Legacy 8259 PIC not supported");

    unsafe {
        for mut ioapic in ioapics.into_iter() {
            ioapic.init(32);

            for i in 0..(255 - 32) {
                ioapic_irq!(ioapic, i, lapic.id());
            }
        }

        x86_64::instructions::interrupts::enable();
    }

    APIC_IS_INITIALIZED.store(true, Ordering::Relaxed);
}

/// Workaround for getting a reference to the local APIC without needing to lock it
///
/// Uses raw pointer but is abstracted behind the scenes
#[inline(always)]
pub fn get_active_lapic<'a>() -> &'a mut LocalApic {
    unsafe { &mut *((xapic_base() + get_phys_offset()) as *mut LocalApic) }
}
