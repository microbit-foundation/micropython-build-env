#!/bin/sh
#
# Required command line arguments:
#    $1: MicroPython git tag to build
#    $2: Path to folder where to save collected files or artefacts
#
set -e
set -x

BASEDIR=$(dirname "$0")

# Install the required tool chain
chmod +x $BASEDIR/install_toolchain.sh
sh $BASEDIR/install_toolchain.sh

# Download and build MicroPython
chmod +x $BASEDIR/build_micropython.sh
sh $BASEDIR/build_micropython.sh $1

# Collect information
chmod +x $BASEDIR/collect.sh
sh $BASEDIR/collect.sh $2
ls $2
