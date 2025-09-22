#!/bin/bash

# Check if cmus is running
if ! cmus-remote -Q &>/dev/null; then
    echo "0"
    exit 1
fi

while true; do
    # Get position and duration
    position=$(cmus-remote -Q | awk '/position/ {print $2}')
    duration=$(cmus-remote -Q | awk '/duration/ {print $2}')

    if [[ -n "$position" && -n "$duration" && "$duration" -gt 0 ]]; then
        progress=$(( (position * 100) / duration ))
        echo "$progress"
    else
        echo "0"
    fi

    sleep 1
done

