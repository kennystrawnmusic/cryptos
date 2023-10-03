use alloc::boxed::Box;
use pcics::{Header, header::HeaderType};
use xhci::{Registers, registers::Operational};
use crate::{FRAME_ALLOCATOR, cralloc::frames::XhciMapper};

pub fn xhci_init(header: &Header, mapper: XhciMapper) -> Option<Operational<XhciMapper>> {
    if header.class_code.base == 0x0c && header.class_code.sub == 0x03 && header.class_code.interface == 0x30 {
        if let HeaderType::Normal(header) = header.header_type.clone() {
            let bar0 = header.base_addresses.orig()[0];
            let bar1 = header.base_addresses.orig()[1];

            let full_bar = bar0 as u64 | ((bar1 as u64) << 32);

            let regs = unsafe { Registers::new(full_bar as usize, mapper) };
            
            Some(regs.operational)
        }  else {
            None
        }
    } else {
        None
    }
}