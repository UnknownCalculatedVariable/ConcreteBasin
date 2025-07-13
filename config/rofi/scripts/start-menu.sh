#!/bin/bash

# Replace "Your Name" with your actual name
USER_NAME="Shreeraam"

# Rofi command
rofi_cmd() {
    rofi -dmenu \
        -p "$USER_NAME" \
        -theme-str 'window {width: 20%;} listview {lines: 5;}'
}

# Get current power profile with indentation to match other options
current_profile() {
    current=$(powerprofilesctl get)
    echo "  Power Profile: ${current^}"
}

# Menu options
options=(
    "  Power Off"
    "  Restart"
    "  Update System"
    "  Update Distrobox"
    "  Backup"
    "$(current_profile)"
)

# Show menu
chosen=$(printf '%s\n' "${options[@]}" | rofi_cmd)

# Handle selection
case "$chosen" in
    "  Restart")
        systemctl reboot
        ;;
    "  Update Distrobox")
        alacritty -e bash -c "distrobox-upgrade -a"
        ;;	
    "  Backup")
        alacritty -e bash -c "~/.local/bin/bckp; read -p 'Press enter to close...'"
        ;;
        esac
        powerprofilesctl set "$new_profile"
        # Relaunch the script to show updated profile
        $0
        ;;
esac
