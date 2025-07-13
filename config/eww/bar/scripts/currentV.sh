#!/bin/bash
while :; do 
  echo "$(amixer sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | tr -d '%')"; 
  sleep 1; 
done