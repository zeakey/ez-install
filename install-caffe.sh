#!/bin/bash
# install common deps
set -e
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential cmake make
sudo apt-get install libboost-all-dev libleveldb-dev  \
                     libsnappy-dev libhdf5-serial-dev \
                     libgflags-dev libgoogle-glog-dev liblmdb-dev \
                     libatlas-base-dev python-dev python3-dev -y
# install protobuf
if [[ "$(which protoc)" == '' ]]; then
  echo "Install Protobuf..."
  bash install-protobuf.sh
fi
# install OpenCV 3+
if [[ "$(which opencv_version)" == '' ]]; then
    echo "Installing OpenCV ..."
    sudo bash install-opencv.sh
fi
# install python deps
if [[ "$(which pip)" == '' ]]; then
    # curl https://bootstrap.pypa.io/get-pip.py
    # alternative link for CN users
    curl http://data.kaiz.xyz/data/get-pip.py | sudo -H python
else
    sudo -H pip install --upgrade pip
fi
# tkinter cannot install with pip, it is necessary for matplotlib
sudo apt-get install python-tk  
# Only install python dependencies that are necessary for compiling caffe
sudo -H pip install numpy
sudo -H pip install scipy
sudo -H pip install scikit-image
# You can install full dependencies by `sudo -H pip install -r requirements.txt`
. ~/.bashrc
# clone latest caffe source code
cd ~/ && git clone https://github.com/BVLC/caffe --depth 1 && cd caffe
mkdir build && cd build
cmake .. -DCPU_ONLY=ON -DCMAKE_CXX_FLAGS=-std=c++11 .. && make -j$(nproc)
echo "Done! Built caffe source at '~/caffe'"

