#!/bin/sh
#
# Required command line arguments:
#    $1: MicroPython git tag to build
#    $2: Path to folder where to save collected files or artefacts
#
set -x

# Install the required tool chain
chmod +x install_toolchain.sh
sh ./install_toolchain.sh

# Download and build MicroPython
chmod +x build_micropython.sh
sh ./build_micropython.sh $1

# Collect information
chmod +x collect.sh
sh ./collect.sh $2
ls $2
