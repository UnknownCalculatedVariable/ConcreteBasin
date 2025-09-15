#!/bin/bash

# Get status from cmus
status=$(cmus-remote -Q | grep "status" | awk '{print $2}')

# Get metadata
title=$(cmus-remote -Q | grep 'tag title' | cut -d ' ' -f3-)
artist=$(cmus-remote -Q | grep 'tag artist' | cut -d ' ' -f3-)
file=$(cmus-remote -Q | grep 'file ' | cut -d ' ' -f2-)

# Path to cover cache
cover="$HOME/.cache/cmus_cover.jpg"

# Handle playback states
case "$status" in
    playing)
        # Extract album art
        ffmpeg -y -i "$file" -an -vcodec copy "$cover" 2>/dev/null
        notify-send -i "$cover" "▶ Playing" "$title — $artist"
        ;;
    paused)
        notify-send -i media-playback-pause "⏸ Paused" "$title — $artist"
        ;;
    stopped)
        notify-send -i media-playback-stop "⏹ Stopped" "Playback stopped"
        ;;
esac

