#!/bin/bash
apt-get update
apt-get install python python3 python3-pip sshpass -y
pip3 install ansible kubernetes openshift
cd /vagrant/provision
cp .vault.pw /root/.vault.pw
chmod 644 /root/.vault.pw
ansible-playbook -i hosts site-from-inside.yml --vault-id ~/.vault.pw
while true;do
  for pod in `kubectl get pods -o name | egrep "puppet-|puppetdb-|webhook-|postgres-"`;do kubectl logs $pod | tail -n 5;done
  clear
done
