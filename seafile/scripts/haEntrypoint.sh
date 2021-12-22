#!/bin/bash

CONFIG_PATH=/data/options.json
export DB_HOST=$(jq --raw-output '.db // "core-mariadb"' $CONFIG_PATH)
export DB_USER=$(jq --raw-output '.db_user // "seafile"' $CONFIG_PATH)
export DB_PASSWD=$(jq --raw-output '.db_pass // "seafile"' $CONFIG_PATH)
export TIME_ZONE=$(jq --raw-output '.tz // "Europe/Berlin"' $CONFIG_PATH)
export SEAFILE_ADMIN_EMAIL=$(jq --raw-output '.admin_email // "sea@file.com"' $CONFIG_PATH)
export SEAFILE_ADMIN_PASSWORD=$(jq --raw-output '.admin_pass // "seafile"' $CONFIG_PATH)
export SEAFILE_SERVER_HOSTNAME=$(jq --raw-output '.server_hostname // "hassio.local"' $CONFIG_PATH)

echo DB_HOST: $DB_HOST
echo DB_USER: $DB_USER
echo DB_PASSWD: $DB_PASSWD
echo TIME_ZONE: $TIME_ZONE
echo SEAFILE_ADMIN_EMAIL: $SEAFILE_ADMIN_EMAIL
echo SEAFILE_ADMIN_PASSWORD: $SEAFILE_ADMIN_PASSWORD
echo SEAFILE_SERVER_HOSTNAME: $SEAFILE_SERVER_HOSTNAME

my_init -- /scripts/enterpoint.sh