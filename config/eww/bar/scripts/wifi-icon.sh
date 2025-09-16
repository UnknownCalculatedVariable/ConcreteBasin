#!/usr/bin/env bash

while true; do
    # Get Wi-Fi state (enabled/disabled)
    wifi_state=$(nmcli -t -f WIFI g 2>/dev/null)
    # Get Wi-Fi signal strength (0–100)
    signal=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^\*' | cut -d: -f2)

    if [[ "$wifi_state" == "enabled" && -n "$signal" ]]; then
        if   (( signal >= 80 )); then
            echo "󰤨"   # Full
        elif (( signal >= 60 )); then
            echo "󰤥"   # 3/4
        elif (( signal >= 40 )); then
            echo "󰤢"   # Half
        elif (( signal >= 20 )); then
            echo "󰤟"   # 1/4
        else
            echo "󰤯"   # Empty outline
        fi
    else
        echo "󰤮"  # Wi-Fi off
    fi

    sleep 1 
done

