#!/bin/bash

# Check if gammastep is running with the specified temperature
if pgrep -f "gammastep -O 3200" > /dev/null; then
    # If running, kill it
    pkill -f "gammastep -O 3200"
    notify-send "gammastep disabled"
else
    # If not running, start it
    gammastep -O 3200 &
    notify-send "gammastep enabled (3200K)"
fi