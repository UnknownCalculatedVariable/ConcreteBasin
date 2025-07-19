#!/bin/bash

# Get sinks: index, name, description
mapfile -t sinks < <(pactl list short sinks)

declare -A sink_names
declare -A sink_descs

# Populate mapping: name -> description
for sink in "${sinks[@]}"; do
    sink_index=$(echo "$sink" | awk '{print $1}')
    sink_name=$(echo "$sink" | awk '{print $2}')
    # Get description using pactl list sinks
    sink_desc=$(pactl list sinks | awk -v name="$sink_name" '
        $0 ~ "Name: "name"$" {found=1}
        found && /Description:/ {print substr($0, index($0,$2)); exit}
    ')
    # Fallback on raw name
    [[ -z "$sink_desc" ]] && sink_desc="$sink_name"
    sink_names["$sink_desc"]="$sink_name"
    sink_descs["$sink_name"]="$sink_desc"
done

# Present descriptions in Rofi
choices=("${!sink_names[@]}")
chosen_desc=$(printf '%s\n' "${choices[@]}" | rofi -dmenu -i -p "Select Audio Output:")

if [[ -n "$chosen_desc" ]]; then
    chosen_sink="${sink_names[$chosen_desc]}"

    # Set default sink
    pactl set-default-sink "$chosen_sink"

    # Move existing streams to the new sink
    mapfile -t sink_inputs < <(pactl list short sink-inputs | awk '{print $1}')
    for input in "${sink_inputs[@]}"; do
        pactl move-sink-input "$input" "$chosen_sink"
    done

    notify-send "Audio Output Changed" "Now using: $chosen_desc"
fi

