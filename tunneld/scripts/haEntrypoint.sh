#!/bin/sh

CONFIG_PATH=/data/options.json
echo options.json
cat /data/options.json
echo

export CLIENTS=$(jq --raw-output '.clients // ""' $CONFIG_PATH)
export CERT=$(jq --raw-output '.cert_path // ""' $CONFIG_PATH)
export KEY=$(jq --raw-output '.key_path // ""' $CONFIG_PATH)

echo CLIENTS: $CLIENTS
echo CERT: $CERT
echo KEY: $KEY

# create new certs if needed
if [ ! -f $CERT ]; then
    echo "creating new certificate"
    openssl req -x509  -batch  -nodes -newkey rsa:2048 -sha256 -keyout $KEY -out $CERT
fi

if [ $CLIENTS ]; then
    CMD="./tunneld -tlsCrt $CERT -tlsKey $KEY -clients $CLIENTS"
else
    CMD="./tunneld -tlsCrt $CERT -tlsKey $KEY"
fi
echo "Running: $CMD"
$CMD
