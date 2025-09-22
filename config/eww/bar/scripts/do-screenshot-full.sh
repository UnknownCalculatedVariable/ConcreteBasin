#!/bin/bash
grim ~/Pictures/Screenshots/"$(date +'%A %m-%d-%y %H:%M:%S')".png &
sleep 0.1
notify-send "Full Screenshot taken"

