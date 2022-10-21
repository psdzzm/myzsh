#!/bin/bash

for i in {1..30}; do
    nc -zvw 10 google.com 443 && con=1 && break
done

if [[ $con == 1 ]]; then
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -e WATCHTOWER_NOTIFICATIONS_LEVEL=info -e WATCHTOWER_RUN_ONCE=true -e WATCHTOWER_INCLUDE_STOPPED=true -e WATCHTOWER_CLEANUP=true containrrr/watchtower
else
    echo "Fail to establish connection"
fi