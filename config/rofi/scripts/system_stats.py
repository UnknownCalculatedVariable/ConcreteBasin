#!/usr/bin/env python3
import psutil, datetime, socket

# Get stats
cpu = psutil.cpu_percent()
mem = psutil.virtual_memory().percent
time = datetime.datetime.now().strftime("%H:%M")
host = socket.gethostname()

# Format with icons
print(f"󰍛 {host}   {cpu}%   {mem}%   {time}")
