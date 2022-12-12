// SPDX-License-Identifier: GPL-3.0-or-later
// Port of https://github.com/Andy-Python-Programmer/aero/raw/master/src/aero_kernel/src/drivers/block/ahci.rs
pub mod util;

use {
    alloc::{sync::Arc, vec::Vec},
    bit_field::BitField,
    spin::Once,
    util::{sync::Mutex, CeilDiv, VolatileCell},
    crate::pci_impl::*,
};

