#!/bin/bash

set -e

BRIDAGE=docker_ramdisk
BASE_DIR=/dev/shm/$BRIDAGE

# Check if root
if [ $(id -u) -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Create the bridge directory if it does not exist
if ! ip link show $BRIDAGE ; then
    ip link add name $BRIDAGE type bridge
    ip addr add "10.20.30.1/24" dev $BRIDAGE
    ip link set dev $BRIDAGE up
fi

# Create the base directory if it does not exist
if [ ! -d $BASE_DIR ]; then
    mkdir -p $BASE_DIR
fi

echo "{}" > /home/ethan/ramdisk/tmp/docker.json

dockerd -H unix:///var/run/$BRIDAGE.sock \
        -p /var/run/$BRIDAGE.pid \
        --bridge=docker_ramdisk \
        --config-file /home/ethan/ramdisk/tmp/docker.json \
        --data-root=$BASE_DIR \
        --exec-root=$BASE_DIR