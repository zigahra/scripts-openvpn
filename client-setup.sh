#!/bin/bash

export IP=<you-ip-address>
export PORT=1194
export CLIENT=client_tap

{
  cat /etc/openvpn/server/client-common.txt
	echo "<ca>"
	cat /etc/openvpn/ca.crt
	echo "</ca>"
	echo "<cert>"
	cat /etc/openvpn/ca.crt
	echo "</cert>"
	echo "<key>"
	cat /etc/openvpn/ca.crt
	echo "</key>"
	} > "$CLIENT".ovpn

