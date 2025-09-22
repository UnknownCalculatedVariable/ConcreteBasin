#!/bin/bash

# --- Function Definitions ---

_battery_icon() {
    get_battery_percentage() {
        if command -v acpi &> /dev/null; then
            acpi -b | grep -P -o '[0-9]+(?=%)'
        elif [ -f "/sys/class/power_supply/BAT0/capacity" ]; then
            cat /sys/class/power_supply/BAT0/capacity
        elif command -v upower &> /dev/null; then
            upower -i $(upower -e | grep 'BAT') | awk -F: '/percentage/ {gsub(" ","",$2); print $2}' | sed 's/%//'
        else
            echo "Error: Unable to determine battery percentage" >&2
            exit 1
        fi
    }

    get_battery_status() {
        if command -v acpi &> /dev/null; then
            acpi -b | grep -q "Charging" && echo "charging" || echo "discharging"
        elif [ -f "/sys/class/power_supply/BAT0/status" ]; then
            cat /sys/class/power_supply/BAT0/status | tr '[:upper:]' '[:lower:]'
        elif command -v upower &> /dev/null; then
            upower -i $(upower -e | grep 'BAT') | awk -F: '/state/ {gsub(" ","",$2); print $2}'
        else
            echo "discharging"
        fi
    }

    BATTERY_ICONS=(
        "󰂎"  # 0-2%
        "󰁺"  # 3-8%
        "󰁻"  # 9-18%
        "󰁼"  # 19-28%
        "󰁽"  # 29-38%
        "󰁾"  # 39-48%
        "󰁿"  # 49-58%
        "󰂀"  # 59-68%
        "󰂁"  # 69-78%
        "󰂂"  # 79-88%
        "󰁹"  # 89-98%
        "󰂄"  # 99-100%
    )

    CHARGING_ICONS=(
        "󰢟"   # 0-2%
        "󰢜"   # 3-8%
        "󰢜"   # 9-18%
        "󰂆"   # 19-28%
        "󰂇"   # 29-38%
        "󰢝"   # 39-48%
        "󰂈"   # 49-58%
        "󰢞"   # 59-68%
        "󰂉"   # 69-78%
        "󰂊"   # 79-88%
        "󰂋"   # 89-100%
        "󰂅"   # 100%
    )

    get_icon_index() {
        local percentage=$1
        if [ $percentage -le 2 ]; then echo 0
        elif [ $percentage -le 8 ]; then echo 1
        elif [ $percentage -le 18 ]; then echo 2
        elif [ $percentage -le 28 ]; then echo 3
        elif [ $percentage -le 38 ]; then echo 4
        elif [ $percentage -le 48 ]; then echo 5
        elif [ $percentage -le 58 ]; then echo 6
        elif [ $percentage -le 68 ]; then echo 7
        elif [ $percentage -le 78 ]; then echo 8
        elif [ $percentage -le 88 ]; then echo 9
        elif [ $percentage -le 98 ]; then echo 10
        else echo 11; fi
    }

    update_battery() {
        local percentage=$(get_battery_percentage)
        local status=$(get_battery_status)
        if ! [[ "$percentage" =~ ^[0-9]+$ ]]; then return 1; fi
        local icon_index=$(get_icon_index $percentage)
        if [[ "$status" == "charging" ]]; then
            echo "${CHARGING_ICONS[$icon_index]}"
        else
            echo "${BATTERY_ICONS[$icon_index]}"
        fi
    }

    update_battery
}

_battery_percent() {
    BATTERY=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{print $2}' | tr -d '%')
    echo "$BATTERY"
}

_date() {
    date -d "$(timedatectl | awk '/Local time/ {print $3}')" +'%m/%d/%y'
}

_gammastep_toggle() {
    if pgrep -f "gammastep -O 3200" > /dev/null; then
        pkill -f "gammastep -O 3200"
        notify-send "gammastep disabled"
    else
        gammastep -O 3200 &
        notify-send "gammastep enabled (3200K)"
    fi
}

_screenshot_full() {
    grim ~/Pictures/Screenshots/"$(date +'%A %m-%d-%y %H:%M:%S')".png &
    sleep 0.1
    notify-send "Full Screenshot taken"
}

_screenshot_sectional() {
    eww close ssC &
    grim -g "$(slurp)" ~/Pictures/Screenshots/"$(date +'%A %m-%d-%y %H:%M:%S')".png &
    notify-send "Partial Screenshot taken"
}

_wifi_icon() {
    if ! command -v nmcli &> /dev/null; then
        echo "󰤭" # nmcli not found
        exit 1
    fi

    get_wifi_icon() {
        wifi_state=$(nmcli -t -f WIFI g)
        if [[ "$wifi_state" == "enabled" ]]; then
            signal=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^*' | cut -d: -f2)
            if [[ -n "$signal" ]]; then
                if ((signal >= 80)); then echo "󰤨"
                elif ((signal >= 60)); then echo "󰤥"
                elif ((signal >= 40)); then echo "󰤢"
                elif ((signal >= 20)); then echo "󰤟"
                else echo "󰤯"; fi
            else
                echo "󰤮" # Disconnected
            fi
        else
            echo "󰤭" # Wi-Fi off
        fi
    }
    get_wifi_icon
}

_wifi_toggle() {
    wifi_status=$(nmcli radio wifi)
    if [ "$wifi_status" = "enabled" ]; then
        nmcli radio wifi off
    else
        nmcli radio wifi on
    fi
}

_workspaces() {
    active_icon="1"
    inactive_icon="0"

    workspaces() {
        local workspaces=$(swaymsg -t get_workspaces)
        local tree=$(swaymsg -t get_tree)

        echo -n "(box :class "workspaces" :orientation "v" :space-evenly false :spacing 1"
        local ws_numbers=($(echo "$workspaces" | jq -r '.[].num' | sort -n))
        if [ ${#ws_numbers[@]} -eq 0 ]; then
            echo -n " (button :class "workspace empty" "No workspaces")"
        else
            local max_ws=${ws_numbers[-1]}
            for ((i=1; i<=max_ws; i++)); do
                local exists=$(echo "$workspaces" | jq -r ".[] | select(.num == $i) | .num")
                if [ -n "$exists" ]; then
                    local focused=$(echo "$workspaces" | jq -r ".[] | select(.num == $i) | .focused")
                    local windows=$(echo "$tree" | jq -r "recurse(.nodes[]?) | select(.type == "workspace" and .num == $i) | .nodes | length")
                    local class="workspace"
                    local icon="$inactive_icon"
                    if [ "$focused" = "true" ]; then
                        class="$class active"
                        icon="$active_icon"
                    else
                        class="$class inactive"
                    fi
                    if [ "$windows" -gt 0 ] 2>/dev/null; then
                        class="$class occupied"
                    else
                        class="$class empty"
                    fi
                    echo -n " (button :onclick "swaymsg workspace number $i" :class "$class" "$icon")"
                fi
            done
        fi
        echo ")"
    }
    workspaces
}

# --- Main Script Logic ---

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <option>"
    echo "Available options:"
    echo "  --battery-icon"
    echo "  --battery-icon-subscribe"
    echo "  --battery-percent"
    echo "  --battery-percent-subscribe"
    echo "  --date"
    echo "  --gammastep-toggle"
    echo "  --screenshot-full"
    echo "  --screenshot-sectional"
    echo "  --wifi-icon"
    echo "  --wifi-icon-subscribe"
    echo "  --wifi-toggle"
    echo "  --workspaces"
    echo "  --workspaces-subscribe"
    exit 1
fi

case "$1" in
    --battery-icon)
        _battery_icon
        ;;
    --battery-icon-subscribe)
        while true; do
            _battery_icon
            sleep 1
        done
        ;;
    --battery-percent)
        _battery_percent
        ;;
    --battery-percent-subscribe)
        while true; do
            _battery_percent
            sleep 1
        done
        ;;
    --date)
        _date
        ;;
    --gammastep-toggle)
        _gammastep_toggle
        ;;
    --screenshot-full)
        _screenshot_full
        ;;
    --screenshot-sectional)
        _screenshot_sectional
        ;;
    --wifi-icon)
        _wifi_icon
        ;;
    --wifi-icon-subscribe)
        nmcli monitor | while read -r; do
            _wifi_icon
        done
        ;;
    --wifi-toggle)
        _wifi_toggle
        ;;
    --workspaces)
        _workspaces
        ;;
    --workspaces-subscribe)
        swaymsg -t subscribe -m '["workspace"]' | while read -r _; do
            _workspaces
        done
        ;;
    *)
        echo "Error: Unknown option '$1'"
        exit 1
        ;;
esac
