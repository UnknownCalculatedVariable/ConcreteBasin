#!/bin/bash

# Config - set your icons here
active_icon="1"    # Icon for focused workspace
inactive_icon="0"  # Icon for inactive workspaces

workspaces() {
    # Get all existing workspaces
    local workspaces=$(swaymsg -t get_workspaces)
    local current_ws=$(echo "$workspaces" | jq -r '.[] | select(.focused).num')
    local outputs=$(swaymsg -t get_outputs)
    local tree=$(swaymsg -t get_tree)

    # Start widget container
    echo -n "(box :class \"workspaces\" :orientation \"v\" :space-evenly false :spacing 1"

    # Get all workspace numbers, sorted
    local ws_numbers=($(echo "$workspaces" | jq -r '.[].num' | sort -n))
    
    # If no workspaces, show empty
    if [ ${#ws_numbers[@]} -eq 0 ]; then
        echo -n " (button :class \"workspace empty\" \"No workspaces\")"
    else
        # Find max workspace number to determine range
        local max_ws=${ws_numbers[-1]}
        
        for ((i=1; i<=max_ws; i++)); do
            # Check if workspace exists
            local exists=$(echo "$workspaces" | jq -r ".[] | select(.num == $i) | .num")
            
            if [ -n "$exists" ]; then
                # Workspace exists - check if focused
                local focused=$(echo "$workspaces" | jq -r ".[] | select(.num == $i) | .focused")
                local windows=$(echo "$tree" | jq -r "recurse(.nodes[]?) | select(.type == \"workspace\" and .num == $i) | .nodes | length")
                
                # Set classes and icon
                local class="workspace"
                local icon="$inactive_icon"
                
                if [ "$focused" = "true" ]; then
                    class="$class active"
                    icon="$active_icon"
                else
                    class="$class inactive"
                fi
                
                if [ "$windows" -gt 0 ] 2>/dev/null; then
                    class="$class occupied"
                else
                    class="$class empty"
                fi
                
                # Add button
                echo -n " (button :onclick \"swaymsg workspace number $i\" :class \"$class\" \"$icon\")"
            fi
        done
    fi

    # Close container
    echo ")"
}

# Initial render
workspaces

# Live updates
swaymsg -t subscribe -m '["workspace"]' | while read -r _; do
    workspaces
done
