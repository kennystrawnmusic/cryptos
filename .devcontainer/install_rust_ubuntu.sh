#!/bin/bash
source /etc/profile
apt-get update && apt-get -y install sudo
sudo -u vscode curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- --default-toolchain nightly -y