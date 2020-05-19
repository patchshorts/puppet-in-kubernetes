#!/bin/bash
set -e
. /vagrant/provision/both.sh
kubeadm init --apiserver-advertise-address=10.0.3.30 --pod-network-cidr=10.244.0.0/16 --v=5 > /vagrant/kinit.out
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
cp -i /etc/kubernetes/admin.conf /vagrant/kconfig
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl get pods --all-namespaces
