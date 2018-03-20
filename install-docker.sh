#!/bin/bash
# remove old version
sudo apt-get remove docker docker-engine
set -e
# recommended extra packages for Ubuntu 14
if [ "$(lsb_release -a | grep 'Ubuntu 14')"!="" ]; then
    sudo apt-get update
    sudo apt-get install \
        linux-image-extra-$(uname -r) \
        linux-image-extra-virtual
fi
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# check fingerprint 
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo usermod -aG docker ${USER}
echo "Done!"
docker --version

