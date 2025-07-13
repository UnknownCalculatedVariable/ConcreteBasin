#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [[ "$status" == "Playing" ]]; then
    echo " pause" # Pause icon
elif [[ "$status" == "Paused" ]]; then
    echo " play" # Play icon
else
    echo " play-pause" # Default/stopped icon
fi
