#!/bin/bash

set -e
for f in /docker-entrypoint.d/*.sh; do
  # Don't print out any messages here since this is a CLI container
  # chmod +x "$f"
  "$f"
done
if [ "${1}" == "/usr/local/bin/webhook" ];then
  /usr/bin/r10k deploy environment -pv || exit 0
  exec /opt/puppetlabs/puppet/bin/ruby "/usr/local/bin/webhook"
else
  exec /usr/bin/r10k "$@"
fi
