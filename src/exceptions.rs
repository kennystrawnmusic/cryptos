use {
    lazy_static::lazy_static,
    x86_64::{
        instructions::{
            segmentation::{Segment, CS, DS},
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
    data: SegmentSelector,
    tss: SegmentSelector,
}

pub const DOUBLE_FAULT_STACK_INDEX: u16 = 0;

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
        tss
    };
    pub static ref GDT: (GlobalDescriptorTable, Selectors) = {
        let mut gdt = GlobalDescriptorTable::new();
        let code = gdt.add_entry(Descriptor::kernel_code_segment());
        let data = gdt.add_entry(Descriptor::kernel_data_segment());
        let tss = gdt.add_entry(Descriptor::tss_segment(&TSS));
        (gdt, Selectors { code, data, tss })
    };
}

pub fn init() {
    GDT.0.load();
    unsafe {
        CS::set_reg(GDT.1.code);
        DS::set_reg(GDT.1.data);
        load_tss(GDT.1.tss);
    }
}
