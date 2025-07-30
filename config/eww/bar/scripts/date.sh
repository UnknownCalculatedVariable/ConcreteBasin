#!/bin/bash
date -d "$(timedatectl | awk '/Local time/ {print $3}')" +'%m/%d/%y'
