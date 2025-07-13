#!/bin/bash
while :; do
  BATTERY=$(mpstat 1 1 | awk '/Average:/ {printf "%.0f%%\n", 100 - $NF}')
  echo "$BATTERY"
  sleep 1
done
