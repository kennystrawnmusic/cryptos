use bootloader::{BootConfig, UefiBoot};
use bootloader_boot_config::{FrameBuffer, LevelFilter};
use std::{
    env::{args, set_var},
    path::Path,
    process::{exit, Command, Stdio},
};

fn main() {
    let mut is_ubuntu = Command::new("which");
    is_ubuntu.arg("apt-get");
    is_ubuntu.stdout(Stdio::null());
    is_ubuntu.stderr(Stdio::null());

    if let Ok(status) = is_ubuntu.status() {
        if status.success() {
            install_ubuntu_deps();
        }
    }

    let mut is_archlinux = Command::new("which");
    is_archlinux.arg("pacman");
    is_archlinux.stdout(Stdio::null());
    is_archlinux.stderr(Stdio::null());

    if let Ok(status) = is_archlinux.status() {
        if status.success() {
            install_arch_deps();
        }
    }

    let kernel_path = Path::new(env!("CARGO_BIN_FILE_CRYPTOS_cryptos"));
    let kdir = Path::new(env!("CARGO_MANIFEST_DIR")).parent().unwrap();
    let out_path = kdir.join("cryptos.img");

    let fb = FrameBuffer::default();

    let mut c = BootConfig::default();
    c.frame_buffer = fb;

    // Suppress excessive output in release mode
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
            "--write" => {
                // Workaround to satisfy the borrow checker
                let args = args().collect::<Vec<_>>();
                let dev = args.get(2).unwrap_or_else(|| {
                    eprintln!("Error: no device specified");
                    exit(1);
                });

                let mut write_cmd = Command::new("sudo");
                write_cmd
                    .arg("dd")
                    .arg("if=cryptos.img")
                    .arg(format!("of={}", dev));

                match write_cmd.status() {
                    Ok(_) => println!("Image successfully written to {}", dev),
                    Err(e) => {
                        eprintln!("Error attempting to write to {}: {}", dev, e);
                        exit(1);
                    }
                }
            }
            _ => {
                println!("Unknown command line argument specified. Acceptable options are \"--boot\" and \"--write\"");
                exit(1)
            }
        }
    }
}

fn install_arch_deps() {
    let mut arch_install_deps = Command::new("sudo");

    let mut does_dep_1_exist = Command::new("which");
    does_dep_1_exist.arg("7z");
    does_dep_1_exist.stdout(Stdio::null());
    does_dep_1_exist.stderr(Stdio::null());

    if let Err(_) = does_dep_1_exist.status() {
        let mut does_dep_2_exist = Command::new("which");
        does_dep_2_exist.arg("gcc");
        does_dep_2_exist.stdout(Stdio::null());
        does_dep_2_exist.stderr(Stdio::null());

        if let Err(_) = does_dep_2_exist.status() {
            let mut does_dep_3_exist = Command::new("which");
            does_dep_3_exist.arg("qemu-system-x86_64");
            does_dep_3_exist.stdout(Stdio::null());
            does_dep_3_exist.stderr(Stdio::null());

            if let Err(_) = does_dep_3_exist.status() {
                arch_install_deps
                    .arg("pacman")
                    .arg("--noconfirm")
                    .arg("-S")
                    .arg("base-devel")
                    .arg("qemu-system-x86")
                    .arg("p7zip");

                let status = arch_install_deps.status().unwrap_or_else(|e| {
                    eprintln!("Error attempting to install dependencies: {:#?}", &e);
                    exit(1);
                });

                if !status.success() {
                    eprintln!("Error attempting to install dependencies: {:#?}", &status);
                    exit(status.code().unwrap());
                }
            } else {
                // have QEMU but don't have the other 2 dependencies
                arch_install_deps
                    .arg("pacman")
                    .arg("--noconfirm")
                    .arg("-S")
                    .arg("base-devel")
                    .arg("p7zip");

                let status = arch_install_deps.status().unwrap_or_else(|e| {
                    eprintln!("Error attempting to install dependencies: {:#?}", &e);
                    exit(1);
                });

                if !status.success() {
                    eprintln!("Error attempting to install dependencies: {:#?}", &status);
                    exit(status.code().unwrap());
                }
            }
        } else {
            // have QEMU and GCC but don't have p7zip
            arch_install_deps
                .arg("apt-get")
                .arg("-y")
                .arg("install")
                .arg("p7zip");

            let status = arch_install_deps.status().unwrap_or_else(|e| {
                eprintln!("Error attempting to install dependencies: {:#?}", &e);
                exit(1);
            });

            if !status.success() {
                eprintln!("Error attempting to install dependencies: {:#?}", &status);
                exit(status.code().unwrap());
            }
        }
    }
}

fn install_ubuntu_deps() {
    let mut ubuntu_install_deps = Command::new("which");
    ubuntu_install_deps.arg("apt-get");
    ubuntu_install_deps.stdout(Stdio::null());
    ubuntu_install_deps.stderr(Stdio::null());

    if let Ok(_) = ubuntu_install_deps.status() {
        let mut ubuntu_install_deps_inner = Command::new("sudo");

        let mut does_dep_1_exist = Command::new("which");
        does_dep_1_exist.arg("7z");
        does_dep_1_exist.stdout(Stdio::null());
        does_dep_1_exist.stderr(Stdio::null());

        if let Err(_) = does_dep_1_exist.status() {
            let mut does_dep_2_exist = Command::new("which");
            does_dep_2_exist.arg("gcc");
            does_dep_2_exist.stdout(Stdio::null());
            does_dep_2_exist.stderr(Stdio::null());

            if let Err(_) = does_dep_2_exist.status() {
                let mut does_dep_3_exist = Command::new("which");
                does_dep_3_exist.arg("qemu-system-x86_64");
                does_dep_3_exist.stdout(Stdio::null());
                does_dep_3_exist.stderr(Stdio::null());

                if let Err(_) = does_dep_3_exist.status() {
                    ubuntu_install_deps_inner
                        .arg("apt-get")
                        .arg("-y")
                        .arg("install")
                        .arg("build-essential")
                        .arg("qemu-system-x86")
                        .arg("p7zip-full");

                    let status = ubuntu_install_deps_inner.status().unwrap_or_else(|e| {
                        eprintln!("Error attempting to install dependencies: {:#?}", &e);
                        exit(1);
                    });

                    if !status.success() {
                        eprintln!("Error attempting to install dependencies: {:#?}", &status);
                        exit(status.code().unwrap());
                    }
                } else {
                    // have QEMU but don't have the other 2 dependencies
                    ubuntu_install_deps_inner
                        .arg("apt-get")
                        .arg("-y")
                        .arg("install")
                        .arg("build-essential")
                        .arg("p7zip-full");

                    let status = ubuntu_install_deps_inner.status().unwrap_or_else(|e| {
                        eprintln!("Error attempting to install dependencies: {:#?}", &e);
                        exit(1);
                    });

                    if !status.success() {
                        eprintln!("Error attempting to install dependencies: {:#?}", &status);
                        exit(status.code().unwrap());
                    }
                }
            } else {
                // have QEMU and GCC but don't have p7zip
                ubuntu_install_deps_inner
                    .arg("apt-get")
                    .arg("-y")
                    .arg("install")
                    .arg("p7zip-full");

                let status = ubuntu_install_deps_inner.status().unwrap_or_else(|e| {
                    eprintln!("Error attempting to install dependencies: {:#?}", &e);
                    exit(1);
                });

                if !status.success() {
                    eprintln!("Error attempting to install dependencies: {:#?}", &status);
                    exit(status.code().unwrap());
                }
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
            &copy_status.clone()
        );
        exit(copy_status.code().clone().unwrap());
    }
}

fn is_snap() -> Option<bool> {
    let mut does_snap_exist = Command::new("which");
    does_snap_exist.arg("snap");
    does_snap_exist.stdout(Stdio::null());
    does_snap_exist.stderr(Stdio::null());

    if let Ok(status) = does_snap_exist.status() {
        if status.success() {
            let mut is_vscode_snap = Command::new("which");
            is_vscode_snap.arg("code");
            is_vscode_snap.stdout(Stdio::piped());
            is_vscode_snap.stderr(Stdio::null());

            if let Ok(status) = &is_vscode_snap.status() {
                let output = is_vscode_snap.output().unwrap();
                if status.success() {
                    let full_path = String::from_utf8_lossy(&output.stdout);
                    if full_path.contains("/snap") {
                        Some(true)
                    } else {
                        Some(false)
                    }
                } else {
                    None
                }
            } else {
                None
            }
        } else {
            None
        }
    } else {
        None
    }
}

fn run_qemu(kdir: &Path, out_path: &Path) {
    // Workaround to get this to work from the Snap version of VS Code
    if let Some(is_snap) = is_snap() {
        if is_snap {
            set_var("LD_PRELOAD", "/usr/lib/x86_64-linux-gnu/libpthread.so.0");
        }
    }

    let mut uefi_cmd = Command::new("qemu-system-x86_64");

    if cfg!(target_os = "linux") {
        uefi_cmd.arg("-accel").arg("kvm");
    }

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
