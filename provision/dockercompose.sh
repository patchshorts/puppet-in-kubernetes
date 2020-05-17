#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

echo -n "updating repos..."
apt-get update > /dev/null 2>&1 || exit 1
echo "done"

echo -n "adding dynamic swap..."
apt-get install wget swapspace -y > /dev/null 2>&1
echo "done"

echo -n "installing packages..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y docker-compose > /dev/null 2>&1
echo "done"

echo "Installing configuration..."
cd /vagrant/
docker-compose up
