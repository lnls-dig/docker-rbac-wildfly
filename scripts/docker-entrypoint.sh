#!/bin/bash

set -a
set -e

# Find the Wildfly configuration file
cd /opt/jboss/wildfly/standalone/configuration/
sed -i -e "s/LDAP_CREDENTIALS/$LDAP_CREDENTIALS/g" standalone.xml

# Call wait-for-it script to wait for DB
/wait-for-it.sh "$@"
