#!/bin/bash

# Check if playerctl is installed
if ! command -v playerctl &> /dev/null; then
    echo -e "\uF04B"  # Play icon fallback
    exit 1
fi

last_status=""

while true; do
    if playerctl status &> /dev/null; then
        status=$(playerctl status 2>/dev/null)
        if [[ "$status" == "Playing" ]]; then
            icon="\uF04C"  # Play
        else
            icon="\uF04B"  # Pause
        fi
    else
        icon="\uF04C"  # Default to pause if no players
    fi

    if [[ "$status" != "$last_status" ]]; then
        echo -e "$icon"
        last_status="$status"
    fi

    sleep 0.2  # small poll delay, but won’t re-echo unless changed
done

