#!/bin/sh

if [ -f "/sys/class/net/enp24s0/carrier" ]; then
    echo "LAN connected"
elif [ -f "/sys/class/net/wlo1/carrier" ]; then
    echo "$(nmcli -t -f active,ssid, dev wifi | egrep '^yes' | cut -d\' -f2 | cut -d ':' -f2)"
else
    echo "No network"
fi
