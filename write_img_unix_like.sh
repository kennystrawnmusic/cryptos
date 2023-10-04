#!/bin/bash

read -p "Enter the path of the device to write to: " path
cargo bin --write $path