#!/bin/bash
eww close ssC &
grim -g "$(slurp)" ~/Pictures/Screenshots/"$(date +'%A %m-%d-%y %H:%M:%S')".png &
notify-send "Partial Screenshot taken"