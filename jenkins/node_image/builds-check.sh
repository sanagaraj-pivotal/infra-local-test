#!/usr/bin/env bash
IMAGE_RESOURCE_NAME=$1
kp builds list $IMAGE_RESOURCE_NAME | grep -q FAILURE && exit 1


#function check_build_status() {
#
#}