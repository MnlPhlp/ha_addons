#!/bin/sh

CONFIG_DIR=/data
CONFIG_PATH=$CONFIG_DIR/options.json
# if the file does not existing create an empty one
if [ ! -f $CONFIG_PATH ]; then
    echo "creating empty config file"

    echo "{}" > $CONFIG_PATH
fi
echo $CONFIG_PATH
cat $CONFIG_PATH
echo
no_tls=$(jq --raw-output .no_tls $CONFIG_PATH)
if [ "$no_tls" = "true" ]; then
    export CELLS_NO_TLS=1
else
    export CELLS_NO_TLS=0
fi

export DB_HOST=$(jq --raw-output '.db // "core-mariadb"' $CONFIG_PATH)

echo DB_HOST: $DB_HOST
echo CELLS_NO_TLS: $CELLS_NO_TLS

## setup taken from pydio/cells container and adjusted for HA
## First check if the system is already installed:
needInstall=false
cells admin config check > /dev/null 2>&1
if [ $? -ne 0  ] ; then
    needInstall=true
fi

# Exit immediately in case of error. See https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html for more details about the set builtin.
set -e

if [ "$needInstall" = true -a "$1" = "cells" -a "$2" = "start" ]; then
        ## Remove the first 2 args (aka: cells start) 
        shift 2
        ## And re-add cells configure
        set -- cells configure "$@"
fi

# Solve issue when no bind is defined on configure
if [ "$needInstall" = true -a "$2" = "configure" -a "xxx$CELLS_BIND" = "xxx" ]; then   
        # we have to check in ENV and all flags
        bindFlag=false
        for currArg in "$@"
        do
                case $currArg in --bind*)
                        bindFlag=true
                esac
        done

        if [ "$bindFlag" = false ]; then
                set -- "$@" --bind :8080
        fi 
fi

# Convenience shortcuts to avoid having to retype 'cells start' before the flags:
# We check if first arg starts with a dash (typically `-f` or `--some-option`) 
# And prefix arguments with 'cells start' or 'cells configure' command in such case 
if [ "${1#-}" != "$1" ]; then
        if [ "$1" = "-h" -o "$1" = "--help"  ]; then
                set -- cells "$@"
        elif [ "$needInstall" = true ]; then
                set -- cells configure "$@"
        else
                set -- cells start "$@"
        fi
fi

# Workaround issue of key generation at first run until it is fixed.
cells version > /dev/null

if [ "$2" != "version" ]; then
        echo "### $(cells version)"
fi 
echo "### About to execute: [$@]"

exec "$@"
