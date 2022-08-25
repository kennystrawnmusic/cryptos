use std::{
    env::args,
    fs::{metadata, File, OpenOptions},
    io::{copy, Seek, SeekFrom},
    path::Path,
    process::{exit, Command},
};

use fatfs::{format_volume, FileSystem, FormatVolumeOptions, FsOptions};
use gpt::{disk::LogicalBlockSize, mbr::ProtectiveMBR, partition_types, GptConfig};

fn mkfs_vfat(fat: &Path, efi: &Path) {
    let megabyte = 1024 * 1024;

    // because the whole kernel needs to fit inside the ESP
    let rounded = 512 * megabyte;

    let fat_file = OpenOptions::new()
        .read(true)
        .write(true)
        .create(true)
        .truncate(true)
        .open(&fat)
        .unwrap();
    fat_file.set_len(rounded).unwrap();

    let mkfs_opts = FormatVolumeOptions::new();
    format_volume(&fat_file, mkfs_opts).unwrap();

    let fs = FileSystem::new(&fat_file, FsOptions::new()).unwrap();

    let root = fs.root_dir();
    let efi_dir = root.create_dir("efi").unwrap();
    let boot = efi_dir.create_dir("boot").unwrap();
    let mut bootx64 = boot.create_file("bootx64.efi").unwrap();

    bootx64.truncate().unwrap();
    copy(&mut File::open(&efi).unwrap(), &mut bootx64).unwrap();
}

fn mklabel_gpt(disk: &Path, img: &Path) {
    // as before
    let megabyte = 1024 * 1024;
    let mut gptlabel = OpenOptions::new()
        .read(true)
        .write(true)
        .create(true)
        .truncate(true)
        .open(&disk)
        .unwrap();

    let partlen = metadata(&img).unwrap().len();

    // because the whole kernel needs to fit inside the ESP
    let disklen = 1024 * megabyte;
    gptlabel.set_len(disklen).unwrap();

    let gpt_pmbr =
        ProtectiveMBR::with_lb_size(u32::try_from((disklen / 512) - 1).unwrap_or(0xffffffff));
    gpt_pmbr.overwrite_lba0(&mut gptlabel).unwrap();

    let blklen = LogicalBlockSize::Lb512;

    let mut partition_table = GptConfig::new()
        .writable(true)
        .initialized(false)
        .create_from_device(Box::new(&mut gptlabel), None)
        .unwrap();
    partition_table
        .update_partitions(Default::default())
        .unwrap();

    let partid = partition_table
        .add_partition("boot", partlen, partition_types::EFI, 0, None)
        .unwrap();
    let part = partition_table.partitions().get(&partid).unwrap();
    let begin = part.bytes_start(blklen).unwrap();

    partition_table.write().unwrap();

    gptlabel.seek(SeekFrom::Start(begin)).unwrap();
    copy(&mut File::open(&img).unwrap(), &mut gptlabel).unwrap();
}

fn main() {
    // skip the "imager" executable name
    let mut args = args().skip(1);

    let kbin = Path::new("target/x86_64-unknown-uefi/release/cryptos.efi")
        .canonicalize()
        .unwrap();
    let kdir = Path::new(env!("CARGO_MANIFEST_DIR")).parent().unwrap();

    let fat_img = kbin.with_extension("fat");
    let disk_path = kbin.with_extension("img");

    mkfs_vfat(&fat_img, &kbin);
    mklabel_gpt(&disk_path, &fat_img);

    if let Some(arg) = args.next() {
        match arg.as_str() {
            "--uefi" => {
                let mut uefi_cmd = Command::new("qemu-system-x86_64");

                uefi_cmd
                    .arg("-accel")
                    .arg("tcg")
                    .arg("-drive")
                    .arg("format=raw,file=target/x86_64-unknown-uefi/release/cryptos.img")
                    .arg("-bios")
                    .arg("OVMF-pure-efi.fd")
                    .arg("-machine")
                    .arg("q35")
                    /* .arg("-d")
                    .arg("int") */;

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
            "--uefi-debug" => {
                let mut uefi_cmd = Command::new("qemu-system-x86_64");

                uefi_cmd
                    .arg("-accel")
                    .arg("tcg")
                    .arg("-drive")
                    .arg("format=raw,file=target/x86_64-unknown-uefi/release/cryptos.img")
                    .arg("-bios")
                    .arg("OVMF-pure-efi.fd")
                    .arg("-gdb")
                    .arg("tcp::3333")
                    .arg("-S")
                    .arg("-machine")
                    .arg("q35");

                uefi_cmd.current_dir(&kdir);

                uefi_cmd.spawn().unwrap();

                let mut debug_cmd = Command::new("gdb");
                debug_cmd
                    .arg("target/x86_64-unknown-uefi/release/cryptos.efi")
                    .arg("-ex")
                    .arg("target remote :3333");

                let uefi_status = debug_cmd.status().unwrap();
                if !uefi_status.success() {
                    println!(
                        "Failed to run GDB: {:#?}",
                        uefi_status.code().clone().unwrap()
                    );
                    exit(uefi_status.code().clone().unwrap());
                }
            }
            _ => {
                println!("Unknown command line argument specified. Acceptable options are \"--uefi\" and \"--uefi-debug\"");
                exit(1)
            }
        }
    }
}
