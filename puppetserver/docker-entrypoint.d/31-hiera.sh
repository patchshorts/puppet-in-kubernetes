#!/usr/bin/env bash

mkdir -p /etc/puppetlabs/puppet/ /etc/puppetlabs/keys

if [ -n "$HIERA_BASE64" ]; then
  echo "---> Saving Hiera configuration to /etc/puppetlabs/puppet/hiera.yaml (base64 decoded)"
  echo -e "$HIERA_BASE64" | base64 -d > /etc/puppetlabs/puppet/hiera.yaml
fi

if [ -n "$EYAML_PUBLIC_BASE64" ]; then
  echo "---> Saving Eyaml public key to /etc/puppetlabs/keys/public_key.pkcs7.pem (base64 decoded)"
  echo -e "$EYAML_PUBLIC_BASE64" | base64 -d > /etc/puppetlabs/keys/public_key.pkcs7.pem
fi

if [ -n "$EYAML_PRIVATE_BASE64" ]; then
  echo "---> Saving Eyaml private key to /etc/puppetlabs/keys/private_key.pkcs7.pem (base64 decoded)"
  echo -e "$EYAML_PRIVATE_BASE64" | base64 -d > /etc/puppetlabs/keys/private_key.pkcs7.pem
fi
