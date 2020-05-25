#! /bin/bash

chown -R puppet:puppet /etc/puppetlabs/puppet/ || true
chown -R puppet:puppet /opt/puppetlabs/server/data/puppetserver/ || true
