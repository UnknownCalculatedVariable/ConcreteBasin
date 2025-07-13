#!/bin/bash
while :; do
  BATTERY=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{print $2}')
  echo "$BATTERY"
  sleep 1
done
