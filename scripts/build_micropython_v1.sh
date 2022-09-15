#!/bin/sh
#
# This script builts MicroPython for V1 to the tag specified by the first
# argument ($1) and stores the build artefacts in the directory indicated
# by the second command line argument ($2)
#
set -e
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

# If the version speficied is "skip" we skip the build
if [ "$1" = "skip" ]
then
    pretty_echo "SKIPPING MicroPython for V1 build"
    exit 0
fi

pretty_echo "Cloning MicroPython V1 repository..."
git clone https://github.com/bbcmicrobit/micropython.git
cd micropython
if [ -z "$1" ]
then
    pretty_echo "No MicroPython version supplied, build master"
else
    pretty_echo "MicroPython version to build supplied: $1"
    git checkout tags/$1
fi

# Build it
pretty_echo "Building MicroPython V1..."
yt clean
yt target bbc-microbit-classic-gcc-nosd@https://github.com/lancaster-university/yotta-target-bbc-microbit-classic-gcc-nosd
yt up
make all
pretty_echo "MicroPython hex file location:\n#\tmicropython/build/firmware.hex"

# Collect data
pretty_echo "Collecting MicroPython V1 artefacts..."
cd ..
cp micropython/build/firmware.hex $2/micropython-microbit-$1.hex
tar -zcvf $2/micropython-v1-build-src.tar.gz micropython 1> /dev/null
