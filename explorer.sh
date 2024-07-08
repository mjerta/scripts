#!/bin/bash

# Get the current directory
current_dir=$(pwd)

# Convert the Linux path to Windows path
windows_path=$(wslpath -w "$current_dir")

# Open the current directory in Windows File Explorer
/mnt/c/windows/explorer.exe "$windows_path"

