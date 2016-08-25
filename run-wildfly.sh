#!/usr/bin/env bash

set -a
set -e
set -u

NET_NAME="$1"
DNS_IP="$2"
WILDFLY_PORT="$3"
LOCAL_WILDFLY_PORT="$4"
ADMIN_PORT="$5"
LOCAL_ADMIN_PORT="$6"
RBAC_DOCKER_IMAGE_NAME="$7"

# Run Wildfly
docker run --name ${RBAC_DOCKER_IMAGE_NAME} --net ${NET_NAME} --dns ${DNS_IP} \
    -p ${LOCAL_WILDFLY_PORT}:${WILDFLY_PORT} -p ${LOCAL_ADMIN_PORT}:${ADMIN_PORT} \
    -d --entrypoint "/wait-for-it.sh" lerwys/docker-${RBAC_DOCKER_IMAGE_NAME}-wildfly \
    rbac-postgres:5432 -- /opt/jboss/wildfly/bin/standalone.sh \
    -b 0.0.0.0 -bmanagement 0.0.0.0
