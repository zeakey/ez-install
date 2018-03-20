#!/bin/bash
if [ ! -d /pkg/ ]; then
    sudo mkdir /pkg/ && sudo chmod 777 /pkg/
fi
cd /pkg && git clone https://github.com/NVIDIA/nccl
cd nccl
make CUDA_HOME=/usr/local/cuda test -j$(nproc)
if [ $? == 1 ]; then
    make PREFIX=/pkg/nccl install -j$(nproc)
else
    echo "test failed!"
    exit 1
fi
echo "export LD_LIBRARY_PATH=/pkg/nccl/lib:$LD_LIBRARY_PATH" >>  ~/.bashrc
echo "export LIBRARY_PATH=/pkg/nccl/lib:$LIBRARY_PATH" >>  ~/.bashrc
echo "export C_INCLUDE_PATH=/pkg/nccl/lib:$C_INCLUDE_PATH" >>  ~/.bashrc
echo "export CPP_INCLUDE_PATH=/pkg/nccl/lib:$CPP_INCLUDE_PATH" >>  ~/.bashrc
source ~/.bashrc
echo "All done, nccl installed at '/pkg/nccl'"
