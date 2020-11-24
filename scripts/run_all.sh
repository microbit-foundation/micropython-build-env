#!/bin/sh
#
# Required command line arguments:
#    $1: MicroPython v1 git tag to build
#    $2: MicroPython v2 git tag to build
#    $3: Path to folder where to save collected files or artefacts
#
set -e
set -x

BASEDIR=$(dirname "$0")

# Install the required tool chain
chmod +x $BASEDIR/install_toolchain.sh
sh $BASEDIR/install_toolchain.sh

# Download and build MicroPython
chmod +x $BASEDIR/build_micropython_v1.sh
sh $BASEDIR/build_micropython_v1.sh $1
chmod +x $BASEDIR/build_micropython_v2.sh
sh $BASEDIR/build_micropython_v2.sh $2

# Collect information
chmod +x $BASEDIR/collect.sh
sh $BASEDIR/collect.sh $3
ls $3
