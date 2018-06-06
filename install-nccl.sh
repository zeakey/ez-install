#!/bin/bash
cd /tmp && git clone https://github.com/NVIDIA/nccl && cd nccl
make CUDA_HOME=/usr/local/cuda test -j$(nproc)
sudo make install -j$(nproc)
echo "All done, nccl has been installed to /usr/local'"
