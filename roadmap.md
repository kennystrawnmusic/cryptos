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
  * 512-bit SHA-3 replacing AHash as the file system's `BuildHasherDefault` for real-time checksumming — took ZFS a lot of time and effort to do what I could do in just 10 or so lines, due to how powerful the HashMap API is
  * Block-level metadata forking — why create pesky ".DS_Store" files when you can use block-level key-value pairs to achieve a similar result? 
  * Design goal: do what Microsoft tried and failed to do with WinFS, except at the block level instead of the service level because it's far easier to accomplish in the former case
* USB mass storage — TODO (need to support this inside the kernel for the exact same reason as AHCI: you can't run apps from USB flash drives if you can't access the drives they — and the kernel itself along with them in some cases — are stored on)
* NVMe — TODO (same as above)
* Initramfs — TODO (needed for some kinds of critical hardware support; virtualized Linux — i.e. ported UML — would also help in this case as far as improving hardware support goes)
* Task scheduler — [in progress](https://github.com/kennystrawnmusic/cryptos/blob/cc49a4b2b8586fb64d777587120ccde0feccbbdc/src/interrupts.rs#L123) — using an IPI to force all available CPU cores to play a game of "hot potato" with the instruction pointer; idea behind this is to take advantage of all available CPU resources at the scheduler level as opposed to the thread level. Ultimate goal is to eventually have a 2-tiered scheduler that ensures all resources get pooled by default, taking the burden of needing to write multithreaded apps to take advantage of all that power off of the developer. This is called Scheduler-Level Resource Sharing (SLRS).
* Graphics — [in progress](https://github.com/kennystrawnmusic/cryptos/blob/master/src/drm/mod.rs)
* USB HID — TODO (can't have a GUI without a mouse and keyboard)
* Userland — TODO (idea is to port the Redox init, Redox coreutils, and most of the non-mission-critical Redox user-mode drivers — like network drivers, for example — over, as well as use my own terminal emulator for running Ion in emulated mode only)
* Use of `cfg` as a means of supporting additional CPU architectures — TODO
* Port to bootloader v. 0.11 — done
