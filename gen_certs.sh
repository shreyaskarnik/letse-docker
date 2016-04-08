#!/usr/bin/env bash

set -e

if [ "$1" = 'new' ]; then
  echo "Generating New LetsEncrypt Certificate for $2 at /etc/certs based on DNS challenge"
  cd /etc/certs && \
  letse keygen -k rsa -b 2048 && \
  echo "Generating Diffie-Helman parameters" && \
  openssl dhparam -out dhparams.pem 2048 && \
  letse $@ -a private_key.pem -k rsa && \
  echo "Generating Full Chain Certificate" && \
  curl https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem -o lets-encrypt-x3-cross-signed.pem && \
  cat $2.crt lets-encrypt-x3-cross-signed.pem > $2-fullchain.pem
fi

if ["$1" = 'renew']; then
  echo "Renewing LetsEncrypt Certificate for $2 at /etc/certs/$2.crt"
  cd /etc/certs && \
  letse renew $1.crt -f
fi
