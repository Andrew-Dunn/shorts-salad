#!/bin/bash

if [ ! -d "config" ]; then
    mkdir "config"
fi

pushd config
openssl genrsa -out key.pem 2048
openssl req -new -sha256 -key key.pem -out csr.csr
openssl req -x509 -sha256 -days 30 -key key.pem -in csr.csr -out certificate.pem
openssl pkcs12 -export -out cert.pfx -inkey key.pem -in certificate.pem
cat > ssl.json << EOF
{
  "selfSigned": true,
  "keyPath": "$PWD/key.pem",
  "certPath": "$PWD/cert.pem"
}
EOF
popd