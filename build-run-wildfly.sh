#!/usr/bin/env bash

set -a
set -e
set -u

SERVICE="$1"
LDAP_CREDENTIALS="$2"

# Source env vars
. ./env-vars.sh ${SERVICE}

# Build image
./build.sh ${SERVICE}

# Create docker network
./create-net.sh ${NET_NAME}

# Run postgres
./run-wildfly.sh ${SERVICE}
