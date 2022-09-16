#!/bin/sh
set -e
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

pretty_echo "Ensure Ubuntu has basic tools..."
apt-get update -qq
apt-get install -y git wget

pretty_echo "Installing GCC ARM compiler version 10.3-2021.10..."
wget -P /opt/ -q https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
echo "2383e4eb4ea23f248d33adc70dc3227e  /opt/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2" >> /opt/MD5SUM
md5sum -c /opt/MD5SUM
rm /opt/MD5SUM
tar -xf /opt/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 -C /opt/
mv /opt/gcc-arm-none-eabi-10.3-2021.10 /opt/gcc-arm-none-eabi/
rm /opt/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2

pretty_echo "Installing python3 and pip v20.3 in system Python 2..."
apt-get install -y --no-install-recommends python3 python-pip=9.0.1-2.3~ubuntu1.18.04.5
apt-get install -y --no-install-recommends python-setuptools=39.0.1-2
python -m pip install --no-cache-dir --upgrade pip==20.3.4

pretty_echo "Installing yotta dependencies..."
apt-get install -y build-essential=12.4ubuntu1
apt-get install -y ninja-build=1.8.2-1
apt-get install -y srecord=1.58-1.1ubuntu2

pretty_echo "Installing Yotta and CMake in system Python 2 via requirements.txt"
python -m pip install --no-cache-dir -r requirements.txt

pretty_echo "Clean up a bit to reduce image size"
apt-get autoremove -y 
apt-get clean -y
rm -rf /var/lib/apt/lists/*

pretty_echo "Done installing tool chain"
