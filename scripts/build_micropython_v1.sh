#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'


pretty_echo "Cloning MicroPython repository..."
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
pretty_echo "Building MicroPython..."
yt clean
yt target bbc-microbit-classic-gcc-nosd
yt up
make all
pretty_echo "MicroPython hex file location:\n#\tmicropython/build/firmware.hex"
