#!/bin/bash

while :; do
  # Get battery information using upower
  BATTERY_INFO=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)

  # Extract state
  STATE=$(echo "$BATTERY_INFO" | grep state | awk '{print $2}')

  # Extract time to empty or full
  TIME_TO_EMPTY=$(echo "$BATTERY_INFO" | grep "time to empty" | awk '{print $4, $5}')
  TIME_TO_FULL=$(echo "$BATTERY_INFO" | grep "time to full" | awk '{print $4, $5}')

  INFO=""
  if [ "$STATE" = "charging" ]; then
    INFO="Charging: ${TIME_TO_FULL}"
  elif [ "$STATE" = "discharging" ]; then
    INFO="Remaining: ${TIME_TO_EMPTY}"
  elif [ "$STATE" = "fully-charged" ]; then
    INFO="Fully Charged"
  else
    INFO="State: ${STATE}"
  fi

  echo "$INFO"
  sleep 1
done