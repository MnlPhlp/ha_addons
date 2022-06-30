#!/bin/sh

CONFIG_PATH=/data/options.json
echo options.json
cat /data/options.json
echo

export CERT=$(jq --raw-output '.cert_path // ""' $CONFIG_PATH)
export KEY=$(jq --raw-output '.key_path // ""' $CONFIG_PATH)
export SERVER=$(jq --raw-output '.server_addr // ""' $CONFIG_PATH)
export TUNNELS=$(jq '.tunnel_config // ""' $CONFIG_PATH | cut -c 2- | rev | cut -c 2- | rev)

echo CERT: $CERT
echo KEY: $KEY
echo SERVER: $SERVER
echo TUNNELS: $TUNNELS

echo "server_addr: $SERVER" > tunnel.yml
echo "tls_crt: $CERT" >> tunnel.yml
echo "tls_key: $KEY" >> tunnel.yml
echo "tunnels:" >> tunnel.yml
IFS=""
echo -e "$TUNNELS" | while read line; do echo "    $line"; done >> tunnel.yml

# create new certs if needed
if [ ! -f $CERT ]; then
    echo "creating new certificate"
    openssl req -x509  -batch  -nodes -newkey rsa:2048 -sha256 -keyout $KEY -out $CERT
fi

echo "Running: ./tunnel start-all"
./tunnel start-all
