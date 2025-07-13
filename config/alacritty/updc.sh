#!/bin/bash
# Send reload command to all running Alacritty instances
if command -v alacritty >/dev/null; then
  for pid in $(pgrep alacritty); do
    ALACRITTY_SOCKET=$(ls /run/user/$(id -u)/Alacritty-*.sock 2>/dev/null | head -n 1)
    if [ -n "$ALACRITTY_SOCKET" ]; then
      alacritty msg --socket "$ALACRITTY_SOCKET" config reload
    fi
  done
fi
