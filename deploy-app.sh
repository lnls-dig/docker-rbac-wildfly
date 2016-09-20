#!/usr/bin/env bash

set -a
set -u
set -e

SERVICE="$1"

# Source env vars
. ./env-vars.sh ${SERVICE}

# Copy files to correct locations
if [ "${SERVICE}" == "rbac" ]; then
    cp ${RBAC_TARGET_WAR} /deploy
    cp postgresql-${POSTGRES_VERSION}.jar /deploy
elif [ "${SERVICE}" == "mgmt" ]; then
    cp ${RBAC_TARGET_WAR} /deploy
    cp postgresql-${POSTGRES_VERSION}.jar /deploy
else
    echo "Unsupported service"
    exit 1
fi
