#!/usr/bin/env bash

set -a
set -e
set -u

SERVICE="$1"
LDAP_CREDENTIALS="$2"

# Source env vars
. ./env-vars.sh ${SERVICE}

# Download prereqs
./download-pre-reqs.sh ${SERVICE} ${LDAP_CREDENTIALS}

# Build image
./build.sh ${POSTGRES_VERSION} ${RBAC_VERSION} ${RBAC_TARGET_WAR} ${RBAC_SERVICE_NAME} ${RBAC_DOCKER_IMAGE_NAME} ${SERVICE}

# Create docker network
./create-net.sh ${NET_NAME}

# Run postgres
./run-wildfly.sh ${NET_NAME} ${DNS_IP} ${WILDFLY_PORT} ${LOCAL_WILDFLY_PORT} \
    ${ADMIN_PORT} ${LOCAL_ADMIN_PORT} ${RBAC_DOCKER_IMAGE_NAME} ${DB_NAME} ${DB_PORT}
