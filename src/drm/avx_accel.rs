// SPDX-License-Identifier: GPL-3.0-or-later
// Use AVX as kernel-mode graphics accelerator

use core::arch::asm;
use raw_cpuid::CpuId;
use x86_64::registers::control::{Cr0, Cr0Flags, Cr4, Cr4Flags};

pub fn sse_init() {
    let info = CpuId::new().get_feature_info().expect("CPUID not present");

    if info.has_sse()
        || info.has_sse2()
        || info.has_sse3()
        || info.has_ssse3()
        || info.has_sse41()
        || info.has_sse42()
    {
        // Disable coprocessor emulation and enable coprocessor monitoring
        let mut cr0_flags = Cr0::read();
        cr0_flags.set(Cr0Flags::EMULATE_COPROCESSOR, false);
        cr0_flags.set(Cr0Flags::MONITOR_COPROCESSOR, true);
        unsafe { Cr0::write(cr0_flags) };

        // Enable OSFXSR and OSXMMEXCPT
        let mut cr4_flags = Cr4::read();
        cr4_flags.set(Cr4Flags::OSFXSR, true);
        cr4_flags.set(Cr4Flags::OSXMMEXCPT_ENABLE, true);
        unsafe { Cr4::write(cr4_flags) };
    } else {
        panic!("CPU doesn't support SSE");
    }
}

pub fn avx_init() {
    let info = CpuId::new().get_feature_info().expect("CPUID not present");

    if info.has_avx() {
        sse_init(); // should already support SSE if AVX is also supported

        // Reference: https://wiki.osdev.org/SSE#AVX_2
        unsafe {
            asm!(
                // Back up registers
                "push rax",
                "push rcx",
                "push rdx",
                // XCR0 manipulation
                "xor rcx, rcx",
                "xgetbv",
                "or eax, 7",
                "xsetbv",
                // Restore registers
                "pop rdx",
                "pop rcx",
                "pop rax"
            );
        }
    } else {
        panic!("AVX not supported");
    }
}
