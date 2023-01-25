# Fork of [bootloader-x86_64-uefi](https://github.com/rust-osdev/bootloader) with custom changes

## Build

```
cargo b --target x86_64-unknown-uefi --release -Zbuild-std=core -Zbuild-std-features=compiler-builtins-mem 
```
