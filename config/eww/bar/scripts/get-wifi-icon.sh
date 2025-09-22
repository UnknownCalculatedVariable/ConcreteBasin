#!/usr/bin/env bash

if ! command -v nmcli &> /dev/null; then
    echo "󰤭" # nmcli not found
    exit 1
fi

get_wifi_icon() {
    wifi_state=$(nmcli -t -f WIFI g)
    if [[ "$wifi_state" == "enabled" ]]; then
        signal=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^*' | cut -d: -f2)
        if [[ -n "$signal" ]]; then
            if ((signal >= 80)); then
                echo "󰤨"
            elif ((signal >= 60)); then
                echo "󰤥"
            elif ((signal >= 40)); then
                echo "󰤢"
            elif ((signal >= 20)); then
                echo "󰤟"
            else
                echo "󰤯"
            fi
        else
            echo "󰤮" # Disconnected
        fi
    else
        echo "󰤭" # Wi-Fi off
    fi
}

get_wifi_icon

nmcli monitor | while read -r; do
    get_wifi_icon
done
