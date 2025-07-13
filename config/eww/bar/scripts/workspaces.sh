#!/bin/bash

# Chess piece icons for workspaces 1-5
icons=("󰡗" "󰡚" "" "󰡜" "")

workspaces() {
    # Get workspace data in single queries
    local workspaces=$(swaymsg -t get_workspaces)
    local current_output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
    local tree=$(swaymsg -t get_tree)

    # Start widget container
    echo -n "(box :class \"workspaces\" :orientation \"v\" :space-evenly false :spacing 2"

    for i in {1..5}; do
        # Check status
        local visible=$(echo "$workspaces" | jq -r ".[] | select(.num == $i) | .visible")
        local focused=$(echo "$workspaces" | jq -r ".[] | select(.num == $i) | .focused")
        local windows=$(echo "$tree" | jq -r "recurse(.nodes[]?) | select(.type == \"workspace\" and .num == $i) | .nodes | length")

        # Set classes
        local class="workspace"
        [[ "$visible" == "true" ]] && class="$class visible"
        [[ "$focused" == "true" ]] && class="$class focused"
        [[ "$windows" -gt 0 ]] 2>/dev/null && class="$class occupied" || class="$class empty"

        # Add button
        echo -n " (button :onclick \"swaymsg workspace number $i\" :class \"$class\" \"${icons[$i-1]}\")"
    done

    # Close container
    echo ")"
}

# Initial render
workspaces

# Live updates
swaymsg -t subscribe -m '["workspace"]' | while read -r _; do
    workspaces
done