#!/usr/bin/env bash

# Configuration
ACTIVATION_ZONE=10  # Pixels from left edge to trigger open
HIDE_RADIUS=50      # Pixels from left edge to trigger close
POLL_INTERVAL=0.1   # Seconds between checks
DEBUG=false         # Set to true for troubleshooting

# State tracking
BAR_VISIBLE=false

if $DEBUG; then
    echo "Starting EWW autohide script"
    echo "Activation zone: $ACTIVATION_ZONE px"
    echo "Hide radius: $HIDE_RADIUS px"
fi

while true; do
    # Get cursor position (relative to focused output)
    cursor_data=$(swaymsg -t get_seats | jq -r '.[].devices[] | select(.type == "pointer") | .pointer.focus.coords')
    if [[ -z "$cursor_data" ]]; then
        sleep "$POLL_INTERVAL"
        continue
    fi

    # Parse cursor coordinates
    cursor_x=$(echo "$cursor_data" | jq -r '.x')
    cursor_y=$(echo "$cursor_data" | jq -r '.y')

    # Get focused output dimensions
    output_data=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .rect')
    output_x=$(echo "$output_data" | jq -r '.x')
    output_y=$(echo "$output_data" | jq -r '.y')
    output_width=$(echo "$output_data" | jq -r '.width')

    # Calculate absolute cursor position
    abs_cursor_x=$((cursor_x + output_x))
    abs_cursor_y=$((cursor_y + output_y))

    if $DEBUG; then
        echo "Cursor: X=$abs_cursor_x, Y=$abs_cursor_y"
    fi

    # Check if cursor is in activation zone
    if (( abs_cursor_x <= ACTIVATION_ZONE )) && ! $BAR_VISIBLE; then
        if $DEBUG; then
            echo "Opening EWW bar (cursor in activation zone)"
        fi
        eww open side
        BAR_VISIBLE=true
    # Check if cursor is outside hide radius
    elif (( abs_cursor_x > HIDE_RADIUS )) && $BAR_VISIBLE; then
        if $DEBUG; then
            echo "Closing EWW bar (cursor outside hide radius)"
        fi
        eww close side
        BAR_VISIBLE=false
    fi

    sleep "$POLL_INTERVAL"
done
