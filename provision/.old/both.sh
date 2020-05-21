#!/bin/bash
set -e
sudo apt-get install docker.io -y
sudo systemctl enable docker
sudo apt-get install curl -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add || true
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" # Does apt-get update for us
sudo apt-get install kubeadm -y
sudo swapoff -a

# read yaml on cli
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64
sudo add-apt-repository ppa:rmescandon/yq
#sudo apt update
sudo apt-get install yq -y
