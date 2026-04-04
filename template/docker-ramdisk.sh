#!/bin/bash

BRIDGE="docker_ramdisk"
BASE_DIR="/dev/shm/$BRIDGE"
SUBNET="10.20.30.0/24"
GATEWAY="10.20.30.1"

cleanup() {
    echo "Cleaning up..."
    # Remove the manual filter rules
    iptables -D FORWARD -i "$BRIDGE" -j ACCEPT 2>/dev/null
    iptables -D FORWARD -o "$BRIDGE" -m state --state RELATED,ESTABLISHED -j ACCEPT 2>/dev/null

    # Remove NAT rule
    iptables -t nat -D POSTROUTING -s "$SUBNET" ! -o "$BRIDGE" -j MASQUERADE 2>/dev/null

    # Remove UFW specific allow for DNS (host-inbound)
    ufw delete allow in on "$BRIDGE" to "$GATEWAY" port 53 2>/dev/null

    [ -f /var/run/$BRIDGE.pid ] && kill $(cat /var/run/$BRIDGE.pid)
    ip link set dev "$BRIDGE" down 2>/dev/null
    ip link del dev "$BRIDGE" 2>/dev/null
    exit 0
}

trap cleanup SIGINT SIGTERM EXIT

# 1. Setup Bridge
if ! ip link show "$BRIDGE" > /dev/null 2>&1; then
    ip link add name "$BRIDGE" type bridge
    ip addr add "$GATEWAY/24" dev "$BRIDGE"
    ip link set dev "$BRIDGE" up
fi

# 2. Networking Setup
# A. Allow containers to talk to host for DNS (via UFW)
ufw allow in on "$BRIDGE" to "$GATEWAY" port 53

# B. THE FIX: Bypass UFW for Forwarding (TCP/UDP/ICMP)
# We use -I to insert at the very top (position 1)
iptables -I FORWARD 1 -i "$BRIDGE" -j ACCEPT
iptables -I FORWARD 1 -o "$BRIDGE" -m state --state RELATED,ESTABLISHED -j ACCEPT

# C. NAT/Masquerade
iptables -t nat -I POSTROUTING -s "$SUBNET" ! -o "$BRIDGE" -j MASQUERADE

if [ ! -d "$BASE_DIR" ]; then
    mkdir -p "$BASE_DIR"
fi

echo '{"insecure-registries" : ["rg.ethan.nas:5000"]}' > /home/ethan/ramdisk/tmp/docker.json

# 3. Start Docker
dockerd -H unix:///var/run/$BRIDGE.sock \
        -p /var/run/$BRIDGE.pid \
        --bridge="$BRIDGE" \
        --iptables=false \
        --ip-masq=false \
        --dns "$GATEWAY" \
        --config-file /home/ethan/ramdisk/tmp/docker.json \
        --data-root="$BASE_DIR" \
        --exec-root="$BASE_DIR" &

wait $!