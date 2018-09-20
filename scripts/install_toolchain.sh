#!/bin/sh
alias pretty_echo='{ set +x; } 2> /dev/null; f(){ echo "#\n#\n# $1\n#\n#"; set -x; }; f'

pretty_echo "Ensure Ubuntu has basic tools..."
apt-get update -qq
apt-get install -y software-properties-common
apt-get install -y git

pretty_echo "Removing any present installation of GCC ARM compiler..."
apt-get remove binutils-arm-none-eabi gcc-arm-none-eabi
pretty_echo "Installing GCC ARM compiler version 7-2018q2-1~bionic1..."
add-apt-repository -y ppa:team-gcc-arm-embedded/ppa
apt-get update -qq
apt-get install -y gcc-arm-embedded=7-2018q2-1~bionic1

pretty_echo "Installing pip v18.0 in system Python 2..."
apt-get install -y python-pip
pip install --upgrade pip==18.0

pretty_echo "Installing Pipenv v2018.7.1..."
python -m pip install pipenv==2018.7.1

pretty_echo "Installing yotta dependencies..."
apt-get install -y cmake=3.10.2-1ubuntu2
apt-get install -y build-essential=12.4ubuntu1
apt-get install -y ninja-build=1.8.2-1
apt-get install -y srecord=1.58-1.1ubuntu2

pretty_echo "Installing Yotta in system Python 2 via locked Pipfile"
if [[ ! -f Pipfile.lock ]] ; then
    echo 'Pipfile.lock not found, exit.'
    exit 1
fi
pipenv install --system

pretty_echo "Clean up a bit to reduce image size"
apt-get clean
rm -rf /var/lib/apt/lists/*

pretty_echo "Done installing tool chain"
