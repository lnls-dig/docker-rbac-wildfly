#!/usr/bin/env bash

set -a
set -u

SERVICE="$1"

# Source env vars
. ./env-vars.sh ${SERVICE}

curl -o deploy/postgresql-${POSTGRES_VERSION}.jar https://jdbc.postgresql.org/download/postgresql-${POSTGRES_VERSION}.jar

# Clone ESS java config
git clone --branch=${ESS_JAVA_CONFIG_VERSION} https://bitbucket.org/europeanspallationsource/ess-java-config ${ESS_JAVA_CONFIG_REPO}
# Clone naming-convention-tool
git clone --branch=${RBAC_VERSION_REPO} https://bitbucket.org/europeanspallationsource/rbac.git ${RBAC_REPO}
# Clone wait-for-it
git clone --branch=${WAIT_FOR_IT_VERSION} https://github.com/vishnubob/wait-for-it scripts/${WAIT_FOR_IT_REPO}

# Build Java Config
cd ${ESS_JAVA_CONFIG_REPO}
mvn install
cd ..

# Build Naming Convention tool
cd ${RBAC_REPO}
mvn install
cd ..
