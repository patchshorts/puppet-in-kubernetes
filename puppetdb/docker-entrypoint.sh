#!/bin/sh

set -e

if [ "${1}" == "foreground" ];then
  chmod +x /docker-entrypoint.d/*.sh
  # sync prevents aufs from sometimes returning EBUSY if you exec right after a chmod
  sync
  for f in /docker-entrypoint.d/*.sh; do
      echo "Running $f"
      "$f"
  done
fi
exec /opt/puppetlabs/bin/puppetdb "$@"
