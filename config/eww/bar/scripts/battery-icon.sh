#!/bin/bash

# Update interval in seconds (default: 5)
UPDATE_INTERVAL=1

while true; do
    # Get battery percentage
    battery_percent=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n 1)

    # Check charging status
    charging_status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -n 1)

    # Check if we got a valid percentage
    if [[ -z "$battery_percent" ]]; then
        echo ""  # Question mark icon if battery not found
        sleep $UPDATE_INTERVAL
        continue
    fi

    # Determine which icon to use based on percentage and charging status
    if [[ "$charging_status" == "Charging" ]]; then
        # Charging icons with battery level indicators
        if [[ "$battery_percent" -ge 90 ]]; then
            echo "󰂅"  # 90-100% charging
        elif [[ "$battery_percent" -ge 60 ]]; then
            echo "󰂇"  # 60-89% charging
        elif [[ "$battery_percent" -ge 40 ]]; then
            echo "󰂆"  # 40-59% charging
        elif [[ "$battery_percent" -ge 10 ]]; then
            echo "󰂇"  # 10-39% charging
        else
            echo "󰢟"  # 0-9% charging
        fi
    else
        # Regular battery level indicators
        if [[ "$battery_percent" -ge 90 ]]; then
            echo ""
        elif [[ "$battery_percent" -ge 60 ]]; then
            echo ""
        elif [[ "$battery_percent" -ge 40 ]]; then
            echo ""
        elif [[ "$battery_percent" -ge 10 ]]; then
            echo ""
        else
            echo ""
        fi
    fi

    # Wait before next update
    sleep $UPDATE_INTERVAL
done
