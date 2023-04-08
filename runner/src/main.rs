use bootloader::{BootConfig, UefiBoot};
use bootloader_boot_config::{FrameBuffer, LevelFilter};
use std::{
    env::args,
    path::Path,
    process::{exit, Command},
};

fn main() {
    let kernel_path = Path::new(env!("CARGO_BIN_FILE_CRYPTOS_cryptos"));
    let kdir = Path::new(env!("CARGO_MANIFEST_DIR")).parent().unwrap();
    let out_path = kdir.join("cryptos.img");

    let fb = FrameBuffer::default();

    let mut c = BootConfig::default();
    c.frame_buffer = fb;

    if cfg!(opt_level = "0") {
        c.log_level = LevelFilter::Trace;
    } else {
        c.log_level = LevelFilter::Error;
    }

    let mut uefi = UefiBoot::new(&kernel_path);
    uefi.set_boot_config(&c);

    if let Err(e) = uefi.create_disk_image(&out_path) {
        eprintln!("{:#?}", &e);
        exit(1)
    };

    println!("Created bootable UEFI disk image at {:#?}", &out_path);

    if let Some(arg) = args().skip(1).next() {
        match arg.as_str() {
            "--boot" => {
                if Path::exists(Path::new("OVMF-pure-efi.fd")) {
                    run_qemu(kdir, &out_path);
                } else {
                    println!("OVMF not found; downloading first");
                    download_ovmf();
                    run_qemu(kdir, &out_path);
                }
            }
            _ => {
                println!("Unknown command line argument specified. Acceptable options are \"--boot\" and \"--debug\"");
                exit(1)
            }
        }
    }
}

fn download_ovmf() {
    let mut download_cmd = Command::new(env!("CARGO_BIN_FILE_OVMF_PREBUILT_ovmf-prebuilt"));

    let _ = download_cmd.output().unwrap_or_else(|e| {
        panic!(
            "Error attempting to download and extract latest version of OVMF: {:#?}",
            e
        )
    });

    let mut copy_cmd = Command::new("cp");

    let dest_dir = Path::new(env!("CARGO_MANIFEST_DIR")).parent().unwrap();

    copy_cmd
        .arg("target/download/extracted/usr/share/edk2.git/ovmf-x64/OVMF-pure-efi.fd")
        .arg(dest_dir.as_os_str());

    let copy_status = copy_cmd.status().unwrap();

    if !copy_status.success() {
        println!(
            "Failed to copy OVMF to crate root: {:#?}",
            &copy_status.code().clone().unwrap()
        );
        exit(copy_status.code().clone().unwrap());
    }
}

fn run_qemu(kdir: &Path, out_path: &Path) {
    let mut uefi_cmd = Command::new("qemu-system-x86_64");

    uefi_cmd
        .arg("-drive")
        .arg(format!(
            "id=disk,format=raw,file={},if=none",
            &out_path.display()
        ))
        .arg("-device")
        .arg("ahci,id=ahci")
        .arg("-device")
        .arg("ide-hd,drive=disk,bus=ahci.0")
        .arg("-bios")
        .arg("OVMF-pure-efi.fd")
        .arg("-machine")
        .arg("q35")
        .arg("-m")
        .arg("4G")
        .arg("-d")
        .arg("int");

    uefi_cmd.current_dir(&kdir);

    let uefi_status = uefi_cmd.status().unwrap();

    if !uefi_status.success() {
        println!(
            "Failed to run QEMU: {:#?}",
            &uefi_status.code().clone().unwrap()
        );
        exit(uefi_status.code().clone().unwrap());
    }
}
