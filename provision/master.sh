#!/bin/bash
apt-get update
apt-get install python python3 python3-pip sshpass -y
pip3 install ansible
cd /vagrant/provision
cp .vault.pw /root/.vault.pw
chmod 644 /root/.vault.pw
ansible-playbook -i hosts site-from-inside.yml --vault-id ~/.vault.pw -vvvv
