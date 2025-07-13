#!/bin/bash

if pgrep -f "gammastep -O 3200" > /dev/null; then
    echo "running"
else
    echo "not running"
fi