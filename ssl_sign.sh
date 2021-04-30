#!/bin/bash

SSLDIR="/etc/ssl"

cert=$1
ext=${cert##*.}
name=$(basename $cert $ext | sed "s/\.//")

UID=$(id -u)

if [[ $UID -ne 0 ]]; then
	print $0 "you've got to run $0 as UID=0 \n"
	exit 1
fi

openssl pkcs12 -in $1 -nocerts -out "private/$name.key"
openssl pkcs12 -in $1 -clcerts -nokeys -out "$SSLDIR/$name.crt"
openssl x509 -pubkey -noout -in "$SSLDIR/certs/$name.crt"  > $name.key.pub

