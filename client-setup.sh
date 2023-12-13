#!/bin/bash

export IP=162.19.224.103
export CLIENT=client_tap
export PORT=1194
export C="GB"
export ST="London"
export L="London"
export O="Global Security"
export OU="IT Department"
export CN="example.com"

## Creating and moving to a specific directory to create the certificates
mkdir config-files
cd config-files

## Creating client's certification
cat <<EOF > openssl.x509.client.conf 
# These extensions are added when 'ca' signs a request.
keyUsage = digitalSignature
extendedKeyUsage=clientAuth
EOF

openssl genrsa -out client.key 4096
openssl req -new -utf8 -key client.key -out client.csr -subj "/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN"
openssl x509 -req -days 36500 -in client.csr -CA /etc/openvpn/ca.crt -CAkey /etc/openvpn/ca.key -set_serial 01 -out client.crt -extfile openssl.x509.client.conf
rm client.csr

{
echo "
client
dev tap
remote $IP $PORT
proto tcp"
echo "<ca>"
cat /etc/openvpn/ca.crt
echo "</ca>"
echo "<cert>"
cat client.crt
echo "</cert>"
echo "<key>"
cat client.key
echo "</key>"
echo "resolv-retry infinite
nobind
persist-key
persist-tun
ignore-unknown-option block-outside-dns
verb 3"
} > ../"$CLIENT".ovpn

