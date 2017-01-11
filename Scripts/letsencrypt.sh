#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CERTBOT_CMD=${DIR}/certbot-auto
WWW_DIR=/tmp/shorts-salad
SSL_CONFIG_FILE=${DIR}/../config/ssl.json
LETSENCRYPT_DIR=/etc/letsencrypt/live
DOMAIN=xn--7p8h3t.ws

mkdir -p ${WWW_DIR}/.well-known/acme-challenge

if [ -f ${SSL_CONFIG_FILE} ]; then
    cp ${SSL_CONFIG_FILE} ${SSL_CONFIG_FILE}.backup
fi

${CERTBOT_CMD} certonly --webroot -w ${WWW_DIR} -d ${DOMAIN}

cat > ${SSL_CONFIG_FILE} << EOF
{
  "selfSigned": false,
  "keyPath": "${LETSENCRYPT_DIR}/${DOMAIN}/privkey.pem",
  "certPath": "${LETSENCRYPT_DIR}/${DOMAIN}/fullchain.pem"
}
EOF