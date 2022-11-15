#![no_std]
#![no_main]

use core::panic::PanicInfo;

use bootloader_api::{*, config::{Mapping, Mappings, FrameBuffer}};

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

const MAPPINGS: Mappings = {
    let mut mappings = Mappings::new_default();
    mappings.kernel_stack = Mapping::FixedAddress(0xf000_0000_0000);
    mappings.boot_info = Mapping::Dynamic;
    mappings.framebuffer = Mapping::Dynamic;
    mappings.physical_memory = Some(Mapping::Dynamic);
    mappings.page_table_recursive = None;
    mappings.aslr = false;
    mappings.dynamic_range_start = Some(0);
    mappings.dynamic_range_end = Some(0xffff_ffff_ffff);
    mappings
};

const CONFIG: BootloaderConfig = {
    let mut config = BootloaderConfig::new_default();
    config.mappings = MAPPINGS;
    config.frame_buffer = FrameBuffer::new_default();
    config
};

entry_point!(maink, config = &CONFIG);

pub fn maink(_info: &'static mut BootInfo) -> ! {
    loop {}
}
