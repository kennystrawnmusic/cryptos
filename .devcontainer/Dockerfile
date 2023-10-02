FROM ubuntu:23.04
RUN /bin/bash -c "$(/usr/bin/which sudo) -u vscode curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- --default-toolchain nightly -y"
RUN /bin/bash -c "$(/usr/bin/which sudo) apt-get -y install build-essential qemu-system-x86 ovmf p7zip"