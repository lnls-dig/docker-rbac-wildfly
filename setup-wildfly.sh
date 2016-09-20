#!/usr/bin/env bash

set -a
set -e
set -u

SERVICE="$1"
#LDAP_CREDENTIALS="$2"

# Source env vars
. ./env-vars.sh ${SERVICE}

# Download prereqs
./download-pre-reqs.sh ${SERVICE}

# Deploy app
./deploy-app.sh ${SERVICE}
