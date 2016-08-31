#!/usr/bin/env bash

set -a
set -u
set -e

POSTGRES_VERSION="$1"
RBAC_VERSION="$2"
RBAC_TARGET_WAR="$3"
RBAC_SERVICE_NAME="$4"
RBAC_DOCKER_IMAGE_NAME="$5"

# Copy files to correct locations, removing existing "wars" and "jars"
rm -f deploy/*.war
rm -f deploy/*.jar
if [ "${SERVICE}" == "rbac" ]; then
    cp ${RBAC_TARGET_WAR} deploy/
    cp postgresql-${POSTGRES_VERSION}.jar deploy/
elif [ "${SERVICE}" == "mgmt" ]; then
    cp ${RBAC_TARGET_WAR} deploy/
    cp postgresql-${POSTGRES_VERSION}.jar deploy/
else
    echo "Unsupported service"
    exit 0
fi

# Change this if your Host have a "sane" DNS like 168.192.1.1
OPTNAMESERVER="echo nameserver 10.0.0.71 > /etc/resolv.conf \&\& \\\\"
#OPTRBACERVER="\\\\"

sed -e "s|OPTNAMESERVER|${OPTNAMESERVER}|g" \
    -e "s|ENV_POSTGRES_VERSION|${POSTGRES_VERSION}|g" \
    -e "s|ENV_RBAC_VERSION|${RBAC_VERSION}|g" \
    -e "s|ENV_RBAC_SERVICE_NAME|${RBAC_SERVICE_NAME}|g" \
    Dockerfile.ini > Dockerfile

docker build -t lerwys/docker-${RBAC_DOCKER_IMAGE_NAME}-wildfly .
