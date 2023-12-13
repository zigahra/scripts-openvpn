#!/bin/bash

## Creating and moving to a specific directory to create the certificates
mkdir config-files
cd config-files

## Creating certification authority
openssl genrsa -des3 -out ca.key 4096
printf '\n\n\n\n\n\n\n' | openssl req -new -x509 -utf8 -days 36500 -key ca.key -out ca.crt 

## Creating server's certification
cat <<EOF > openssl.x509.server.conf 
# These extensions are added when 'ca' signs a request.
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage=serverAuth
EOF

openssl genrsa -out server.key 4096
printf '\n\n\n\n\n\n\n' | openssl req -new -utf8 -key server.key -out server.csr
openssl x509 -req -days 36500 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt -extfile openssl.x509.server.conf
rm server.csr

## Creating the tls-auth key
#openvpn --genkey --secret ta.key

## Creating Diffie-Hellman file
#openssl dhparam -out dh4096.pem 4096
