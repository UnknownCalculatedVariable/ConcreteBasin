#!/bin/bash
while :; do 
  echo "$(fastfetch | grep Battery | awk '{print $4}' | tr -d '[],')"; 
  sleep 1; 
done