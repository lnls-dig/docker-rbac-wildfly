# Docker Image for RBAC Authentication Services with Wildfly

## Usage

This repository generates different docker images.
In order to generate your desired image, change the file
env-vars.sh to the appropriate names.

Variables of interest are (RBAC-AuthServices, for instance):

    LOCAL_WILDFLY_PORT=8443
    LOCAL_ADMIN_PORT=9990

    RBAC_VERSION=2.0.4

    RBAC_SERVICE_PATH=RBAC-AuthServices
    RBAC_SERVICE_NAME=auth-services
    RBAC_DOCKER_IMAGE_NAME=rbac
