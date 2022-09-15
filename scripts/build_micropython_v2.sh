#!/bin/sh
#
# This script builts MicroPython for V2 to the tag specified by the first
# argument ($1) and stores the build artefacts in the directory indicated
# by the second command line argument ($2)
#
set -e
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

# If the version speficied is "skip" we skip the build
if [ "$1" = "skip" ]
then
    pretty_echo "SKIPPING MicroPython for V2 build"
    exit 0
fi

pretty_echo "Cloning MicroPython V2 repository..."
git clone https://github.com/microbit-foundation/micropython-microbit-v2.git
cd micropython-microbit-v2
if [ -z "$1" ]
then
    pretty_echo "No MicroPython version supplied, build master"
else
    pretty_echo "MicroPython version to build supplied: $1"
    git checkout tags/$1
fi
git submodule update --init

# Build it
pretty_echo "Building MicroPython V2..."
make -C lib/micropython/mpy-cross
cd src
make
pretty_echo "MicroPython hex file location:\n#\tmicropython-microbit-v2/src/MICROBIT.hex"

# Collect data
pretty_echo "Collecting MicroPython V2 artefacts..."
cd /home
cp micropython-microbit-v2/src/MICROBIT.hex $2/micropython-microbit-$1.hex
tar -zcvf $2/micropython-v2-build-src.tar.gz micropython-microbit-v2 1> /dev/null
