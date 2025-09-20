#!/usr/bin/env bash

if ! command -v nmcli &> /dev/null; then
    echo "nmcli not found"
    exit 1
fi

get_ssid() {
    ssid=$(nmcli -t -f NAME,DEVICE,TYPE c show --active | grep wifi | cut -d: -f1)

    if [ -n "$ssid" ]; then
        echo "$ssid"
    else
        echo "Disconnected"
    fi
}

get_ssid

nmcli monitor | while read -r; do
    get_ssid
done
