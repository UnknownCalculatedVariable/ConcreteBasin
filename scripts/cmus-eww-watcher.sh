#!/bin/bash

was_running=false

while true; do
    if pgrep -x cmus > /dev/null; then
        if [ "$was_running" = false ]; then
            eww open-many music music-progress
            was_running=true
        fi
    else
        if [ "$was_running" = true ]; then
            eww close music && eww close music-progress
            was_running=false
        fi
    fi
    sleep 0.2 
done

