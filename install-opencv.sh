#!/bin/bash
set -e
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove
# Build tools:
sudo apt-get install -y build-essential cmake make
# GUI interfaces
sudo apt-get install -y libvtk6-dev qt5-default 
# Media I/O:
sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev
# Video I/O:
sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev
# Parallelism and linear algebra libraries:
sudo apt-get install -y libtbb-dev libeigen3-dev
# Documentation:
sudo apt-get install -y doxygen
sudo apt-get install -y unzip wget
FILENAME='opencv-3.4.1'
if [ ! -e $FILENAME".zip" ]; then
  # wget https://github.com/opencv/opencv/archive/3.2.0.zip
  # alternative link for CN user
  wget "http://data.kaiz.xyz/data/"$FILENAME".zip" -P /tmp/
fi
cd /tmp
unzip $FILENAME".zip"
cd $FILENAME
if [ -e build ]; then
  rm -rf build
fi
mkdir build && cd build
cmake -DWITH_IPP=OFF -DWITH_CUDA=OFF -DWITH_QT=OFF -DWITH_OPENGL=ON -DFORCE_VTK=ON \
  -DWITH_TBB=ON -DWITH_OPENMP=ON -DWITH_GDAL=OFF -DWITH_XINE=ON -DBUILD_EXAMPLES=OFF \
  -DBUILD_DOCS=OFF -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_NEW_PYTHON_SUPPORT=ON ..
# more cmake flags refer to http://amritamaz.net/blog/opencv-config
make -j$(nproc)
sudo make install
sudo ldconfig
echo "All done"

