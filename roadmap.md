# Roadmap

## Intended kernel design
* Kernel type — hybrid, XNU-like/Darwin-like/MacOS-like (extremely important to note re: eventual kernel-mode graphics in the pipeline below: Apple, *not* Microsoft, was the first to bake a GUI into the kernel, and MacOS definitely doesn't have as many stability issues as Windows does *precisely because* of its otherwise-Unix-like design, irrespective of the aforementioned fact that MacOS has had a GUI in its kernel for far longer than Windows has)
  * GPLv3 for anti-Tivoization reasons first and foremost: the reason why so many smartphone manufacturers and carriers are able to get away with locking down the bootloaders on Android devices is because Linux uses an outdated version of the GPL that allows it
  * Reason for depending on permissively licensed system call interface: because Redox is a microkernel itself, the system call interface that comes with it can be configured to allow direct memory access from user mode. This is important as it allows proprietary drivers to be written for an otherwise strong copyleft kernel **if** and only if they're user-mode drivers

## Progress:
* Basic booting — done
* Heap allocation — done (set up immediately at the very top of the main loop)
* Configuring of APICs — done
* ACPI/AML table handling — done
* AHCI driver — done
* Modern file system — HMFS (in progress):
  * Uses `hashbrown::HashMap` instead of a B+ tree or B-tree as its basic data structure (hence the abbreviation: HashMap File System)
  * 512-bit SHA-3 replacing AHash for real-time checksumming
  * Block-level metadata forking
  * Design goal: do what Microsoft tried and failed to do with WinFS, except at the block level instead of the service level
* USB mass storage — TODO (need to support this inside the kernel for the exact same reason as AHCI: you can't run apps from USB flash drives if you can't access the drives they — and the kernel itself along with them in some cases — are stored on)
* NVMe — TODO (same as above)
* Task scheduler — TODO (need to be able to load executables from disk first in order to run and schedule them)
* Graphics — TODO (idea is to rewrite the framebuffer structure provided by the `bootloader` crate as a new structure that implements both `Clone` as a compositor backend and `From` to convert from the bootloader's impl, then use the aforementioned `FrameBuffer + Clone + From` rewrite to actually bake a compositor into the kernel itself)
* USB HID — TODO (can't have a GUI without a mouse and keyboard)
* Userland — TODO (idea is to port the Redox init, Redox coreutils, and most of the non-mission-critical Redox user-mode drivers — like network drivers, for example — over, as well as use my own terminal emulator for running Ion in emulated mode only)
* Use of `cfg` as a means of supporting additional CPU architectures — TODO
* Port to bootloader v. 0.11 — done
