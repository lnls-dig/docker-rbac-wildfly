#!/usr/bin/env bash

set -a
set -u
set -e

SERVICE="$1"

. ./env-vars.sh ${SERVICE}

docker build -t ${RBAC_DOCKER_ORG_NAME}/${RBAC_DOCKER_IMAGE_NAME} -f ${RBAC_DOCKERFILE_NAME} .
