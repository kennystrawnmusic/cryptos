#!/bin/bash
source /etc/profile
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo -u vscode bash -s -- --default-toolchain nightly -y