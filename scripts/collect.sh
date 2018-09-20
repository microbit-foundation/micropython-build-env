#!/bin/sh
#
# This script collects system info, and built MicroPython and places it in the
# directory indicated by the first command line argument (mandatory)
#
set -x

# Get Python and modules info
echo "Python version:" > python_info.txt
python -c "import sys;print(sys.version)" >> python_info.txt
python -c "import struct; print('{}-bits\n'.format(struct.calcsize('P') * 8))" >> python_info.txt
echo "Pip version:" >> python_info.txt
python -m pip --version >> python_info.txt && echo "" >> python_info.txt
echo "Pip freeze:" >> python_info.txt
python -m pip freeze >> python_info.txt
cp python_info.txt $1/python_info.txt

# Get installed packages
apt list --installed > apt_packages.txt
cp apt_packages.txt $1/apt_packages.txt

# Copy MicroPython hex file
cp micropython/build/firmware.hex $1/firmware.hex

# Copy MicroPython directory
tar -zcvf micropython-build-src.tar.gz micropython 1> /dev/null
cp micropython-build-src.tar.gz $1/micropython-build-src.tar.gz
