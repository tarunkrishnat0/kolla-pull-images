#!/bin/bash
# Description: This script use to pull images from public docker
#              registry and push them to local docker registry.

local_registry_host="192.168.2.79" # needs to be updated
kolla_release="2023.1-ubuntu-jammy" # needs to be updated
# To see available images check this link: https://quay.io/repository/openstack.kolla/fluentd?tab=tags

public_registry_host="quay.io"
IMAGE_LIST="kolla-images.list"

#
for qw in `cat $IMAGE_LIST`
do
echo "===========> Pull ==> $qw"
docker pull $public_registry_host/openstack.kolla/$qw:$kolla_release
docker tag $public_registry_host/openstack.kolla/$qw:$kolla_release "$local_registry_host:4000/openstack.kolla/$qw:$kolla_release"
echo "===========> Push ==> $qw"
docker push "$local_registry_host:4000/openstack.kolla/$qw:$kolla_release"
docker rmi $public_registry_host/openstack.kolla/$qw:$kolla_release
done
