#!/bin/bash

# Ensure cmus is running
cmus_pid=$(pgrep -x cmus | head -n1)
if [ -z "$cmus_pid" ]; then
    echo "cmus is not running"
    exit 1
fi

# Get current workspace
current_ws=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

# Get all kitty windows with their pid + workspace (searching parents until workspace)
windows=$(swaymsg -t get_tree | jq -c '
    recurse(.nodes[]?, .floating_nodes[]?) as $n
    | ($n | recurse(.nodes[]?, .floating_nodes[]?) | select(.app_id? == "kitty"))
      | {pid: .pid, workspace: ($n | select(.type=="workspace").name)}
')

# Function: check if a process is descendant of another
is_descendant() {
    child=$1
    parent=$2
    while [ "$child" -ne 1 ]; do
        child=$(ps -o ppid= -p "$child" | tr -d ' ')
        if [ "$child" -eq "$parent" ]; then
            return 0
        fi
    done
    return 1
}

# Find the workspace where cmus lives
target_ws=""
while read -r win; do
    kitty_pid=$(echo "$win" | jq -r '.pid')
    workspace=$(echo "$win" | jq -r '.workspace')

    if is_descendant "$cmus_pid" "$kitty_pid"; then
        target_ws="$workspace"
        break
    fi
done <<< "$windows"

# Toggle logic
if [ -n "$target_ws" ]; then
    if [ "$current_ws" = "$target_ws" ]; then
        swaymsg workspace back_and_forth
    else
        swaymsg workspace "$target_ws"
    fi
else
    echo "Could not find cmus window"
fi

