#!/bin/bash

## Battery Status Script with Icon Output
## --------------------------------------
## Outputs a battery icon based on charge level and charging status.
## Intended for use in status bars (polybar, i3bar, etc).

## Update interval in seconds (default: 1)
UPDATE_INTERVAL=1

while true; do
    # --- Get current battery percentage ---
    battery_percent=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n 1)

    # --- Get current charging status (e.g., Charging, Discharging, Full) ---
    charging_status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -n 1)

    # --- If unable to read battery info, show a question mark icon ---
    if [[ -z "$battery_percent" ]]; then
        echo ""  # Font Awesome 'question' icon
        sleep $UPDATE_INTERVAL
        continue
    fi

    # --- Determine charging/discharging and select appropriate icon ---
    if [[ "$charging_status" == "Charging" ]]; then
        # CHARGING STATE ICONS (Material Design, "plug" overlay)
        if   [[ "$battery_percent" -ge 90 ]]; then
            echo "󰂅"  # Battery charging 100%
        elif [[ "$battery_percent" -ge 70 ]]; then
            echo "󰂋"  # Battery charging 80%
        elif [[ "$battery_percent" -ge 50 ]]; then
            echo "󰂉"  # Battery charging 60%
        elif [[ "$battery_percent" -ge 30 ]]; then
            echo "󰂇"  # Battery charging 40%
        elif [[ "$battery_percent" -ge 10 ]]; then
            echo "󰢜"  # Battery charging 20%
        else
            echo "󰢟"  # Battery alert charging
        fi
    else
        # DISCHARGING or FULL STATE ICONS (Font Awesome)
        if   [[ "$battery_percent" -ge 90 ]]; then
            echo ""  # Battery full
        elif [[ "$battery_percent" -ge 70 ]]; then
            echo ""  # Battery 75%
        elif [[ "$battery_percent" -ge 50 ]]; then
            echo ""  # Battery 50%
        elif [[ "$battery_percent" -ge 30 ]]; then
            echo ""  # Battery 25%
        elif [[ "$battery_percent" -ge 10 ]]; then
            echo ""  # Battery low
        else
            echo ""  # Font Awesome 'alert' icon
        fi
    fi

    # --- Sleep and update again ---
    sleep $UPDATE_INTERVAL
done

