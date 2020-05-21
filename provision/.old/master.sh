
#!/bin/bash
# stop on any fail
set -e
# default alias is cp="cp -i". We don't want that.
alias cp=cp 
. /vagrant/provision/both.sh
# In case provision interupted and we have to run vagrant up --provision to compelte.
kubeadm reset || true
kubeadm init --apiserver-advertise-address=10.0.3.30 --pod-network-cidr=10.244.0.0/16 > /vagrant/kinit.out
mkdir -p {$HOME,"/vagrant"}/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
cp -i /etc/kubernetes/admin.conf /vagrant/.kube/kconfig
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl get pods --all-namespaces
cat .kube/config | yq r - clusters[0].cluster.certificate-authority-data | base64 -d > /vagrant/.kube/cluster-cacert.pem
cat .kube/config | yq r - users[0].user.client-certificate-data | base64 -d > /vagrant/.kube/client-cert.pem
cat .kube/config | yq r - users[0].user.client-key-data | base64 -d > /vagrant/.kube/client-key.pem
