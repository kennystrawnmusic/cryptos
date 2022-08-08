use {
    bootloader_locator::locate_bootloader,
    std::{path::Path, process::Command},
};

pub fn main() {
    let mut args = std::env::args().skip(1); //skip executable name

    let loader_manifest = locate_bootloader("bootloader").unwrap();

    let uefi_img = Path::new("target/x86_64-uefi-cryptos/release/cryptos")
        .canonicalize()
        .unwrap();

    let manifest_d = Path::new(env!("CARGO_MANIFEST_DIR"));

    let kdir = manifest_d.parent().unwrap();
    let manifest = kdir.join("Cargo.toml");
    let target = kdir.join("target");
    let uefi_out = uefi_img.parent().unwrap();

    let mut uefi_img_build_cmd = Command::new(env!("CARGO"));

    uefi_img_build_cmd
        .arg("builder")
        .arg("--kernel-manifest")
        .arg(&manifest)
        .arg("--kernel-binary")
        .arg(&uefi_img)
        .arg("--target-dir")
        .arg(&target)
        .arg("--out-dir")
        .arg(&uefi_out);

    let loader_dir = loader_manifest.parent().unwrap();
    uefi_img_build_cmd.current_dir(&loader_dir);

    let status = uefi_img_build_cmd.status().unwrap();
    if !status.success() {
        panic!(
            "Bootloader build exited with status code {:#?}",
            status.code().unwrap()
        )
    }

    //deduplicate
    let mut uefi_cleanup = Command::new("rm");
    uefi_cleanup.current_dir(&uefi_out);
    uefi_cleanup.arg("-f").arg("boot-bios-cryptos.img");

    let uefi_cleanup_status = uefi_cleanup.status().unwrap();
    if !uefi_cleanup_status.success() {
        panic!(
            "Failed to clean up the UEFI directory: {:#?}",
            status.code().unwrap()
        )
    }

    let bios_img = Path::new("target/x86_64-bios-cryptos/release/cryptos")
        .canonicalize()
        .unwrap();

    let mut bios_img_build_cmd = Command::new(env!("CARGO"));

    let bios_out = bios_img.parent().unwrap();

    bios_img_build_cmd
        .arg("builder")
        .arg("--kernel-manifest")
        .arg(&manifest)
        .arg("--kernel-binary")
        .arg(&bios_img)
        .arg("--target-dir")
        .arg(&target)
        .arg("--out-dir")
        .arg(&bios_out);

    let loader_dir = loader_manifest.parent().unwrap();
    bios_img_build_cmd.current_dir(&loader_dir);

    let status = bios_img_build_cmd.status().unwrap();
    if !status.success() {
        panic!(
            "Bootloader build exited with status code {:#?}",
            status.code().unwrap()
        )
    }

    //deduplicate
    let mut bios_cleanup = Command::new("rm");
    bios_cleanup
        .arg("-f")
        .arg("boot-uefi-cryptos.img")
        .arg("boot-uefi-cryptos.efi")
        .arg("boot-uefi-cryptos.fat");
    bios_cleanup.current_dir(&bios_out);

    let bios_cleanup_status = bios_cleanup.status().unwrap();
    if !bios_cleanup_status.success() {
        panic!(
            "Failed to clean up the BIOS directory: {:#?}",
            status.code().unwrap()
        )
    }

    if let Some(arg) = args.next() {
        match arg.as_str() {
            "--uefi" => {
                let mut uefi_cmd = Command::new("qemu-system-x86_64");

                uefi_cmd
                    .arg("-accel")
                    .arg("tcg")
                    .arg("-drive")
                    .arg("format=raw,file=target/x86_64-uefi-cryptos/release/boot-uefi-cryptos.img")
                    .arg("-bios")
                    .arg("/usr/share/edk2-ovmf/x64/OVMF.fd")
                    .arg("-machine")
                    .arg("q35");

                uefi_cmd.current_dir(&kdir);

                let uefi_status = uefi_cmd.status().unwrap();
                if !uefi_status.success() {
                    panic!("Failed to run QEMU: {:#?}", uefi_status.code().unwrap());
                }
            }
            "--bios" => {
                let mut bios_cmd = Command::new("qemu-system-x86_64");

                bios_cmd
                    .arg("-accel")
                    .arg("tcg")
                    .arg("-drive")
                    .arg("format=raw,file=target/x86_64-bios-cryptos/release/boot-bios-cryptos.img")
                    .arg("-machine")
                    .arg("q35");

                let bios_status = bios_cmd.status().unwrap();
                if !bios_status.success() {
                    panic!("Failed to run QEMU: {:#?}", bios_status.code().unwrap());
                }
            }
            "--uefi-debug" => {
                let mut uefi_cmd = Command::new("qemu-system-x86_64");

                uefi_cmd
                    .arg("-accel")
                    .arg("tcg")
                    .arg("-drive")
                    .arg("format=raw,file=target/x86_64-uefi-cryptos/release/boot-uefi-cryptos.img")
                    .arg("-bios")
                    .arg("/usr/share/edk2-ovmf/x64/OVMF.fd")
                    .arg("-gdb")
                    .arg("tcp::3333")
                    .arg("-S")
                    .arg("-machine")
                    .arg("q35");

                uefi_cmd.current_dir(&kdir);

                let uefi_status = uefi_cmd.status().unwrap();
                if !uefi_status.success() {
                    panic!("Failed to run QEMU: {:#?}", uefi_status.code().unwrap());
                }
            }
            "--bios-debug" => {
                let mut bios_cmd = Command::new("qemu-system-x86_64");

                bios_cmd
                    .arg("-accel")
                    .arg("tcg")
                    .arg("-drive")
                    .arg("format=raw,file=target/x86_64-bios-cryptos/release/boot-bios-cryptos.img")
                    .arg("-gdb")
                    .arg("tcp::3333")
                    .arg("-S")
                    .arg("-machine")
                    .arg("q35");

                let bios_status = bios_cmd.status().unwrap();
                if !bios_status.success() {
                    panic!("Failed to run GDB: {:#?}", bios_status.code().unwrap());
                }
            }
            _ => panic!("Unknown argument specified"),
        }
    }
}
