use {
    lazy_static::lazy_static,
    x86_64::{
        instructions::{
            segmentation::{Segment, CS, DS, ES, FS, GS},
            tables::load_tss,
        },
        structures::{
            gdt::{Descriptor, GlobalDescriptorTable, SegmentSelector},
            tss::TaskStateSegment,
        },
        VirtAddr,
    },
};

pub struct Selectors {
    code: SegmentSelector,
    ds: SegmentSelector,
    es: SegmentSelector,
    fs: SegmentSelector,
    gs: SegmentSelector,
    tss: SegmentSelector,
}

pub const DOUBLE_FAULT_STACK_INDEX: u16 = 0;
pub const PAGE_FAULT_STACK_INDEX: u16 = 1;
pub const INVALID_TSS_STACK_INDEX: u16 = 2;
pub const DIV_ERR_STACK_INDEX: u16 = 3;
pub const SIGBUS_STACK_INDEX: u16 = 4;
pub const SIGSEGV_STACK_INDEX: u16 = 5;
pub const GPF_STACK_INDEX: u16 = 6;

lazy_static! {
    pub static ref TSS: TaskStateSegment = {
        let mut tss = TaskStateSegment::new();
        tss.interrupt_stack_table[DOUBLE_FAULT_STACK_INDEX as usize] = {
            const LEN: usize = 4096 * 5;
            static mut STACK: [u8; LEN] = [0; LEN];

            let begin = VirtAddr::from_ptr(unsafe { &STACK });
            let end = begin + LEN;
            end
        };
        tss.interrupt_stack_table[PAGE_FAULT_STACK_INDEX as usize] = {
            const LEN: usize = 4096 * 5;
            static mut STACK: [u8; LEN] = [0; LEN];

            let begin = VirtAddr::from_ptr(unsafe { &STACK });
            let end = begin + LEN;
            end
        };
        tss.interrupt_stack_table[INVALID_TSS_STACK_INDEX as usize] = {
            const LEN: usize = 4096 * 5;
            static mut STACK: [u8; LEN] = [0; LEN];

            let begin = VirtAddr::from_ptr(unsafe { &STACK });
            let end = begin + LEN;
            end
        };
        tss.interrupt_stack_table[DIV_ERR_STACK_INDEX as usize] = {
            const LEN: usize = 4096 * 5;
            static mut STACK: [u8; LEN] = [0; LEN];

            let begin = VirtAddr::from_ptr(unsafe { &STACK });
            let end = begin + LEN;
            end
        };
        tss.interrupt_stack_table[SIGBUS_STACK_INDEX as usize] = {
            const LEN: usize = 4096 * 5;
            static mut STACK: [u8; LEN] = [0; LEN];

            let begin = VirtAddr::from_ptr(unsafe { &STACK });
            let end = begin + LEN;
            end
        };
        tss.interrupt_stack_table[SIGSEGV_STACK_INDEX as usize] = {
            const LEN: usize = 4096 * 5;
            static mut STACK: [u8; LEN] = [0; LEN];

            let begin = VirtAddr::from_ptr(unsafe { &STACK });
            let end = begin + LEN;
            end
        };
        tss.interrupt_stack_table[GPF_STACK_INDEX as usize] = {
            const LEN: usize = 4096 * 5;
            static mut STACK: [u8; LEN] = [0; LEN];

            let begin = VirtAddr::from_ptr(unsafe { &STACK });
            let end = begin + LEN;
            end
        };
        tss
    };
    pub static ref GDT: (GlobalDescriptorTable, Selectors) = {
        let mut gdt = GlobalDescriptorTable::new();
        let code = gdt.add_entry(Descriptor::kernel_code_segment());
        let ds = gdt.add_entry(Descriptor::kernel_data_segment());
        let es = gdt.add_entry(Descriptor::kernel_data_segment());
        let fs = gdt.add_entry(Descriptor::kernel_data_segment());
        let gs = gdt.add_entry(Descriptor::kernel_data_segment());
        let tss = gdt.add_entry(Descriptor::tss_segment(&TSS));
        (
            gdt,
            Selectors {
                code,
                ds,
                es,
                fs,
                gs,
                tss,
            },
        )
    };
}

pub fn init() {
    GDT.0.load();
    unsafe {
        CS::set_reg(GDT.1.code);
        DS::set_reg(GDT.1.ds);
        ES::set_reg(GDT.1.es);
        FS::set_reg(GDT.1.fs);
        GS::set_reg(GDT.1.gs);
        load_tss(GDT.1.tss);
    }
}
