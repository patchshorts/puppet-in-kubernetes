#!/usr/bin/env bash

mkdir -p /etc/facter/facts.d/

if [ -n "$SERVER_FACTS_BASE64" ]; then
  echo "---> Saving custom Facter facts configuration to /etc/facter/facts.d/server_facts.sh (base64 decoded)"
  echo -e "$SERVER_FACTS_BASE64" | base64 -d > /etc/facter/facts.d/server_facts.sh
  chmod 755 /etc/facter/facts.d/server_facts.sh
fi
