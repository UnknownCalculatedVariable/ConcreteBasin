#!/bin/bash

# Check if playerctl is installed
if ! command -v playerctl &> /dev/null; then
    echo ""  # Pause icon if playerctl not found
    exit 1
fi

# Continuous output loop
while true; do
    # Check if any players are available
    if playerctl status &> /dev/null; then
        status=$(playerctl status 2>/dev/null)
        if [[ "$status" == "Playing" ]]; then
            echo "󰏤"  # Play icon
        else
            echo ""  # Pause icon
        fi
    else
        echo ""  # Pause icon (no players available)
    fi
    
    # Small delay to prevent high CPU usage
    sleep 1
done

