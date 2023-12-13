#!/bin/bash

export PORT=1194
export C="GB"
export ST="London"
export L="London"
export O="Global Security"
export OU="IT Department"
export CN="example.com"

## Install dependencies
sudo apt update
sudo apt upgrade
sudo apt install openssl openvpn

## Creating and moving to a specific directory to create the certificates
mkdir config-files
cd config-files

## Creating certification authority
openssl genrsa -des3 -out ca.key 4096
openssl req -new -x509 -utf8 -days 36500 -key ca.key -out ca.crt -subj "/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN"
echo -n

## Creating server's certification
cat <<EOF > openssl.x509.server.conf 
# These extensions are added when 'ca' signs a request.
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage=serverAuth
EOF

openssl genrsa -out server.key 4096
openssl req -new -utf8 -key server.key -out server.csr -subj "/C=$C/ST=$ST/L=$L/O=$O/OU=$OU/CN=$CN"
openssl x509 -req -days 36500 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt -extfile openssl.x509.server.conf
rm server.csr

## Creating the tls-auth key
sudo openvpn --genkey secret ta.key

## Creating Diffie-Hellman file
openssl dhparam -out dh2048.pem 2048

## Install the server configuration files and rm the folder config-files
sudo mv ca.crt dh2048.pem server.crt server.key ta.key /etc/openvpn/.
cd .. 
rm -r config-files

## Create the needed network interfaces
sudo ip tuntap add mode tap tap0 # Pb: flag NO-CARRIER is generated
#sudo tunctl -t tap0 # package : uml-utilities
sudo ip link set tap0 up
sudo ip link add br0 type bridge
sudo ip link set br0 up
sudo ip link set dev tap0 master br0

## Add server laucher configuration 
sudo cat <<EOF > /etc/openvpn/server_tap.conf
server-bridge 10.0.0.2 255.255.255.0 10.0.0.200 10.0.0.254
dev tap0
proto tcp
port $PORT
keepalive 10 120

ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
;tls-auth ta.key 0
EOF

# systemctl start openvpn@server_tap.service
