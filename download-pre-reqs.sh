#!/usr/bin/env bash

set -a
set -e
set -u

SERVICE="$1"
LDAP_CREDENTIALS="$2"

# Source env vars
. ./env-vars.sh ${SERVICE}

curl -o postgresql-${POSTGRES_VERSION}.jar https://jdbc.postgresql.org/download/postgresql-${POSTGRES_VERSION}.jar

# Clone ESS java config
git clone --branch=${ESS_JAVA_CONFIG_VERSION} https://bitbucket.org/europeanspallationsource/ess-java-config ${ESS_JAVA_CONFIG_REPO}
# Clone naming-convention-tool
git clone --branch=${RBAC_VERSION_REPO} https://bitbucket.org/europeanspallationsource/rbac.git ${RBAC_REPO}
# Clone wait-for-it
git clone --branch=${WAIT_FOR_IT_VERSION} https://github.com/vishnubob/wait-for-it ${WAIT_FOR_IT_REPO}

# Apply patches
cd ${RBAC_REPO}
git am --ignore-whitespace /build/patches/rbac/*
cd ..

# Insert LDAP Credentials
find . -iname "*ldap.properties" -exec sed -i -e "s/<INSERT_YOUR_LDAP_CREDENTIAL_HERE>/${LDAP_CREDENTIALS}/g" '{}' \;

# Build Java Config
cd ${ESS_JAVA_CONFIG_REPO}
mvn install
cd ..

# Build Naming Convention tool
cd ${RBAC_REPO}
mvn clean && mvn install -Dmaven.test.skip=true
cd ..
