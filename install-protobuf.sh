#!/bin/bash
set -e
sudo apt-get install autoconf automake libtool curl make g++ unzip
if [ ! -e /tmp/protobuf-all-3.5.1.tar.gz ]; then
  wget http://data.kaiz.xyz/data/protobuf-all-3.5.1.tar.gz -P /tmp
fi
cd /tmp
tar -xvf protobuf-all-3.5.1.tar.gz
cd protobuf-3.5.1
./autogen.sh
./configure
make -j$(nproc)
make check -j$(nproc)
sudo make install -j$(nproc)
sudo ldconfig

# Install Python interface
echo "Installing protobuf python interface..."
cd python
python setup.py build
python setup.py test
sudo -H python setup.py install
echo 'Done!'

