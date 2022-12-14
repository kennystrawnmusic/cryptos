use bootloader::UefiBoot;
use std::{
    env::args,
    path::Path,
    process::{exit, Command},
};

fn main() {
    let kernel_path = Path::new(env!("CARGO_BIN_FILE_CRYPTOS_cryptos"));
    let kdir = Path::new(env!("CARGO_MANIFEST_DIR")).parent().unwrap();
    let out_str = format!("{}/cryptos.img", &kdir.display());
    let out_path = Path::new(&out_str);

    let uefi = UefiBoot::new(&kernel_path);
    if let Err(e) = uefi.create_disk_image(&out_path) {
        eprintln!("{:#?}", &e);
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
    let mut url_cmd = Command::new("bash");
    url_cmd.arg("-c").arg("curl -s https://github.com/rust-osdev/ovmf-prebuilt/releases/ | grep \"href\" | grep \"OVMF-pure-efi.fd\" | cut -d\\\" -f2");

    let url_fragment = url_cmd.output().unwrap_or_else(|e| {
        panic!(
            "Error attempting to parse URL of latest version of OVMF: {:#?}",
            e
        )
    });
    let url_fragment_string = String::from_utf8(url_fragment.stdout)
        .expect("Malformed command line output: not valid UTF-8");
    let url = format!("https://github.com{}", url_fragment_string);

    let mut download_cmd = Command::new("curl");

    download_cmd
        .arg("-L")
        .arg("-o")
        .arg("OVMF-pure-efi.fd")
        .arg(url.as_str());

    let download_dir = Path::new(env!("CARGO_MANIFEST_DIR")).parent().unwrap();
    download_cmd.current_dir(&download_dir);

    let download_status = download_cmd.status().unwrap();

    if !download_status.success() {
        println!(
            "Failed to run QEMU: {:#?}",
            &download_status.code().clone().unwrap()
        );
        exit(download_status.code().clone().unwrap());
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
