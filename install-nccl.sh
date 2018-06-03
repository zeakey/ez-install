#!/bin/bash
cd /tmp && git clone https://github.com/NVIDIA/nccl && cd nccl
make CUDA_HOME=/usr/local/cuda test -j$(nproc)
if [ $? == 1 ]; then
    sudo make install -j$(nproc)
else
    echo "test failed!"
    exit 1
fi
echo "All done, nccl has been installed to /usr/local'"
