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

docker build -t ${RBAC_DOCKER_ORG_NAME}/${RBAC_DOCKER_IMAGE_NAME} .
