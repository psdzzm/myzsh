#!/bin/bash

for i in {1..30}; do
    nc -zvw 10 google.com 443 && con=1 && break
done

if [[ $con == 1 ]]; then
    rclone mount onedrive: ~/OneDrive/ --vfs-cache-mode writes --vfs-cache-max-size 1G
else
    echo "Fail to establish connection"
fi