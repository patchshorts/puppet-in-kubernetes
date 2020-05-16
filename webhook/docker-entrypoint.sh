#!/bin/bash

set -e

for f in /docker-entrypoint.d/*.sh; do
  # Don't print out any messages here since this is a CLI container
  # chmod +x "$f"
  "$f"
done

/usr/bin/r10k "$@" || exit 0

exec /opt/puppetlabs/puppet/bin/ruby "/usr/local/bin/webhook"