#!/bin/bash

export IP=<you-ip-address>
export PORT=1194
export CLIENT=client_tap

{
  	client
	dev tap
	remote $IP $PORT
	proto tcp
	echo "<ca>"
	cat /etc/openvpn/ca.crt
	echo "</ca>"
	echo "<cert>"
	cat /etc/openvpn/client.crt
	echo "</cert>"
	echo "<key>"
	cat /etc/openvpn/client.key
	echo "</key>"
 	resolv-retry infinite
	nobind
	persist-key
	persist-tun
	ignore-unknown-option block-outside-dns
 	verb 3
	} > "$CLIENT".ovpn

