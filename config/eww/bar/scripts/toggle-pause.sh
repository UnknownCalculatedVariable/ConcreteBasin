#!/bin/bash

# Check if playerctl is installed
if ! command -v playerctl &> /dev/null; then
    echo "Error: playerctl is not installed"
    exit 1
fi

# Get the current playback status
status=$(playerctl status 2>/dev/null)

# Toggle play/pause based on current status
if [ "$status" = "Playing" ]; then
    playerctl pause
    echo "Playback paused"
elif [ "$status" = "Paused" ]; then
    playerctl play
    echo "Playback resumed"
else
    echo "No active player found or player is stopped"
fi