#!/bin/sh
#
# This script collects system info, and the built MicroPython hex and places it
# in the directory indicated by the first command line argument (mandatory)
#
set -e
set -x

# Get Python and modules info
echo "Python version:" > $1/python_info.txt
python -c "import sys;print(sys.version)" >> $1/python_info.txt
python -c "import struct; print('{}-bits\n'.format(struct.calcsize('P') * 8))" >> $1/python_info.txt
echo "Pip version:" >> $1/python_info.txt
python -m pip --version >> $1/python_info.txt && echo "" >> $1/python_info.txt
echo "Pip freeze:" >> $1/python_info.txt
python -m pip freeze >> $1/python_info.txt

# Get installed packages
apt list --installed > $1/apt_packages.txt

# Copy MicroPython hex file
cp micropython/build/firmware.hex $1/micropython-v1-firmware.hex
cp micropython-microbit-v2/src/MICROBIT.hex $1/micropython-v2-firmware.hex

# Copy MicroPython directory
tar -zcvf $1/micropython-v1-build-src.tar.gz micropython 1> /dev/null
tar -zcvf $1/micropython-v2-build-src.tar.gz micropython-microbit-v2 1> /dev/null
