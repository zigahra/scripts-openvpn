#!/bin/bash

client
dev tap
remote SRV.domain
proto tcp
port PORT

ca cacert.pem
cert CLNT.crt
key CLNT.key
