#!/bin/sh

CONFIG_PATH=/data/options.json
echo options.json
cat /data/options.json
echo

export CLIENTS=$(jq --raw-output '.clients // ""' $CONFIG_PATH)
export CERT=$(jq --raw-output '.db_user // "seafile"' $CONFIG_PATH)
export KEY=$(jq --raw-output '.db_pass // "seafile"' $CONFIG_PATH)

echo CLIENTS: $CLIENTS
echo CERT: $CERT
echo KEY: $KEY



./tunneld -tlsCrt $CERT -tlsKey $KEY -clients $CLIENTS