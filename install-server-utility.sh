#!/bin/bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install openssl openssh-server openssh-client
sudo apt-get install git build-essential tmux htop

if [[ "$(which pip)" == '' ]]; then
    curl https://bootstrap.pypa.io/get-pip.py | sudo python
else
    sudo -H pip install --upgrade pip
fi
sudo -H pip install numpy
sudo -H pip install git+https://github.com/shadowsocks/shadowsocks.git@master

