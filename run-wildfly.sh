#!/usr/bin/env bash

set -a
set -e
set -u

SERVICE="$1"
LDAP_CREDENTIALS="$2"

. ./env-vars.sh ${SERVICE}

# Run Wildfly
docker run --name ${RBAC_DOCKER_RUN_NAME} --net ${NET_NAME} --dns ${DNS_IP} \
    -p ${LOCAL_WILDFLY_PORT}:${WILDFLY_PORT} -p ${LOCAL_ADMIN_PORT}:${ADMIN_PORT} \
    -e LDAP_CREDENTIALS=${LDAP_CREDENTIALS}\
    -d --entrypoint "/docker-entrypoint.sh" ${RBAC_DOCKER_ORG_NAME}/${RBAC_DOCKER_IMAGE_NAME}  \
    ${DB_NAME}:${DB_PORT} -- /opt/jboss/wildfly/bin/standalone.sh \
    -b 0.0.0.0 -bmanagement 0.0.0.0
