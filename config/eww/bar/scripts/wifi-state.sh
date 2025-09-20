#!/usr/bin/env bash

if ! command -v nmcli &> /dev/null; then
    echo "off"
    exit 1
fi

get_wifi_state() {
    wifi_state=$(nmcli -t -f WIFI g)
    if [[ "$wifi_state" == "enabled" ]]; then
        signal=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^*' | cut -d: -f2)
        if [[ -n "$signal" ]]; then
            echo "connected"
        else
            echo "disconnected"
        fi
    else
        echo "off"
    fi
}

get_wifi_state

nmcli monitor | while read -r; do
    get_wifi_state
done
