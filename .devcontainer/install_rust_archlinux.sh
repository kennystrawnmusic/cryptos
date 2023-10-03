#!/bin/bash
source /etc/profile
pacman --noconfirm -Syu sudo
sudo -u vscode curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- --default-toolchain nightly -y