#!/usr/bin/env bash

# Get command from rofi
cmd=$(rofi -dmenu -p "Run")

# Exit if empty
[ -z "$cmd" ] && exit 0

# Run command headless
bash -c "$cmd" & disown

