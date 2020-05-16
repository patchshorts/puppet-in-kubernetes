#!/usr/bin/env bash

if [ -n "$R10K_CONTROL_REPO" ]; then
  echo "---> Configuring r10k repository: ${R10K_CONTROL_REPO}"
  sed -i "s|R10K_CONTROL_REPO|$R10K_CONTROL_REPO|" /etc/puppetlabs/r10k/r10k.yaml
else
  echo "---> Missing R10K_CONTROL_REPO configuration. Skipping r10k control configuration"
fi

if [ -n "$R10K_HIERA_REPO" ]; then
  echo "---> Configuring r10k repository: ${R10K_HIERA_REPO}"
  sed -i "s|R10K_HIERA_REPO|$R10K_HIERA_REPO|" /etc/puppetlabs/r10k/r10k.yaml
else
  echo "---> Missing R10K_HIERA_REPO configuration. Skipping r10k hiera configuration"
fi

if [ -n "$R10K_DEPLOY_KEY" ]; then
  echo "---> Saving SSH deploy key to /root/.ssh/id_rsa"
  echo "$R10K_DEPLOY_KEY" > /root/.ssh/id_rsa
  chmod 0400 /root/.ssh/id_rsa
fi

if [ -n "$R10K_DEPLOY_KEY_BASE64" ]; then
  echo "---> Saving SSH deploy key to /root/.ssh/id_rsa (base64 decoded)"
  echo -e "$R10K_DEPLOY_KEY_BASE64" | base64 -d > /root/.ssh/id_rsa
  chmod 0400 /root/.ssh/id_rsa
fi

if [ -n "$R10K_ADDITIONAL_CONFIG" ]; then
  echo "---> Additional r10k configuration"
  echo "$R10K_ADDITIONAL_CONFIG" >> /etc/puppetlabs/r10k/r10k.yaml
fi
