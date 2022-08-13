# Roadmap

## Intended kernel design
* Kernel type — hybrid, XNU-like/Darwin-like/MacOS-like (extremely important to note re: eventual kernel-mode graphics in the pipeline below: Apple, *not* Microsoft, was the first to bake a GUI into the kernel, and MacOS definitely doesn't have as many stability issues as Windows does *precisely because* of its otherwise-Unix-like design)
  * GPLv3 for anti-Tivoization reasons first and foremost: the reason why so many smartphone manufacturers and carriers are able to get away with locking down the bootloaders on Android devices is because Linux uses an outdated version of the GPL that allows it
  * Reason for depending on permissively licensed system call interface: because Redox is a microkernel itself, the system call interface that comes with it can be configured to allow direct memory access from user mode. This is important as it allows proprietary drivers to be written for an otherwise strong copyleft kernel **if** and only if they're user-mode drivers

## Progress:
* Basic booting — done
* Configuring of APICs — done
* ACPI/AML table handling — done
* AHCI driver — almost done (see [Issue #1](https://github.com/kennystrawnmusic/cryptos/issues/1) — should be done when that showstopper is fixed)
* Task scheduler — TODO (need to be able to load executables from disk first in order to run and schedule them)
* Graphics — TODO (going to define my own wrapper around the framebuffer structure provided by the `bootloader` crate that implements `Clone` as a means of allowing compositing)
* Userland — TODO (idea is to port the Redox init, Redox coreutils, and most of the non-mission-critical Redox user-mode drivers — like network drivers, for example — over, as well as use my own terminal emulator for running Ion in emulated mode only)
