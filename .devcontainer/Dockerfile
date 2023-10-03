FROM ubuntu:23.04
RCOPY install_rust.sh /tmp
RUN chmod a+x /tmp/install_rust.sh
RUN /tmp/install_rust.sh
RUN /bin/bash -c "$(/usr/bin/which sudo) apt-get update && $(/usr/bin/which sudo) apt-get -y install build-essential qemu-system-x86 ovmf p7zip"