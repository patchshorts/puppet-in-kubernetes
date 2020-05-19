#!/bin/bash
set -e
sudo apt-get install docker.io -y
sudo systemctl enable docker
sudo apt-get install curl -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get install kubeadm -y
sudo swapoff -a
