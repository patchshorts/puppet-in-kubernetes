#!/bin/bash
set -e
. /vagrant/provision/both.sh
while [ ! -f /vagrant/kinit.out ];do
  sleep 2
done
/bin/sh -c "`grep -A1 'kubeadm join' /vagrant/kinit.out`"
