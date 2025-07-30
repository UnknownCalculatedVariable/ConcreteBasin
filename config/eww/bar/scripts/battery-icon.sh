#!/bin/bash

# Function to get battery percentage
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

# Function to get charging status
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

# Nerd Font battery icons for discharging
BATTERY_ICONS=(
    "󰂎"  # 0-2% - nf-md-battery_outline
    "󰁺"  # 3-8% - nf-md-battery_10
    "󰁻"  # 9-18% - nf-md-battery_20
    "󰁼"  # 19-28% - nf-md-battery_30
    "󰁽"  # 29-38% - nf-md-battery_40
    "󰁾"  # 39-48% - nf-md-battery_50
    "󰁿"  # 49-58% - nf-md-battery_60
    "󰂀"  # 59-68% - nf-md-battery_70
    "󰂁"  # 69-78% - nf-md-battery_80
    "󰂂"  # 79-88% - nf-md-battery_90
    "󰁹"  # 89-98% - nf-md-battery_90
    "󰂄"  # 99-100% - nf-md-battery
)

# Nerd Font charging battery icons
CHARGING_ICONS=(
    "󰢟"  # 0-2% - nf-md-battery_charging_outline
    "󰢜"  # 3-8% - nf-md-battery_charging_10
    "󰂆"  # 9-18% - nf-md-battery_charging_20
    "󰂇"  # 19-28% - nf-md-battery_charging_30
    "󰂈"  # 29-38% - nf-md-battery_charging_40
    "󰢝"  # 39-48% - nf-md-battery_charging_50
    "󰢞"  # 49-58% - nf-md-battery_charging_60
    "󰂉"  # 59-68% - nf-md-battery_charging_70
    "󰂊"  # 69-78% - nf-md-battery_charging_80
    "󰂋"  # 79-88% - nf-md-battery_charging_90
    "󰂅"  # 89-98% - nf-md-battery_charging_90
    "󰂄"  # 99-100% - nf-md-battery_charging_100
)

# Function to get the icon index based on battery percentage
get_icon_index() {
    local percentage=$1
    
    if [ $percentage -le 2 ]; then
        echo 0
    elif [ $percentage -le 8 ]; then
        echo 1
    elif [ $percentage -le 18 ]; then
        echo 2
    elif [ $percentage -le 28 ]; then
        echo 3
    elif [ $percentage -le 38 ]; then
        echo 4
    elif [ $percentage -le 48 ]; then
        echo 5
    elif [ $percentage -le 58 ]; then
        echo 6
    elif [ $percentage -le 68 ]; then
        echo 7
    elif [ $percentage -le 78 ]; then
        echo 8
    elif [ $percentage -le 88 ]; then
        echo 9
    elif [ $percentage -le 98 ]; then
        echo 10
    else
        echo 11
    fi
}

# Function to update battery icon
update_battery() {
    local percentage=$(get_battery_percentage)
    local status=$(get_battery_status)
    
    if ! [[ "$percentage" =~ ^[0-9]+$ ]]; then
        return 1
    fi
    
    local icon_index=$(get_icon_index $percentage)
    
    if [[ "$status" == "charging" ]]; then
        echo "${CHARGING_ICONS[$icon_index]}"
    else
        echo "${BATTERY_ICONS[$icon_index]}"
    fi
}

# Main loop
while true; do
    update_battery
    sleep 1
done
