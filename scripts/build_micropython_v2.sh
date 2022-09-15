#!/bin/sh
set -e
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'


pretty_echo "Cloning MicroPython repository..."
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
pretty_echo "Building MicroPython..."
make -C lib/micropython/mpy-cross
cd src
make
pretty_echo "MicroPython hex file location:\n#\tmicropython-microbit-v2/src/MICROBIT.hex"
