#!/usr/bin/env bash

POSTGRES_VERSION="$1"
RBAC_VERSION="$2"
RBAC_TARGET_WAR="$3"

# Copy files to correct locations
cp ${RBAC_TARGET_WAR} deploy/

# Change this if your Host have a "sane" DNS like 168.192.1.1
OPTNAMESERVER="echo nameserver 10.0.0.71 > /etc/resolv.conf \&\& \\\\"
#OPTRBACERVER="\\\\"

sed -e "s|OPTNAMESERVER|${OPTNAMESERVER}|g" \
    -e "s|ENV_POSTGRES_VERSION|${POSTGRES_VERSION}|g" \
    -e "s|ENV_RBAC_VERSION|${RBAC_VERSION}|g" \
    Dockerfile.ini > Dockerfile

docker build -t lerwys/docker-rbac-wildfly .
