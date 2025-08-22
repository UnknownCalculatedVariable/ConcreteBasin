#!/bin/bash

# Get metadata from cmus
title=$(cmus-remote -Q | grep 'tag title' | cut -d ' ' -f3-)
artist=$(cmus-remote -Q | grep 'tag artist' | cut -d ' ' -f3-)
album=$(cmus-remote -Q | grep 'tag album' | cut -d ' ' -f3-)
file=$(cmus-remote -Q | grep 'file ' | cut -d ' ' -f2-)

# Path to cache cover
cover="$HOME/.cache/cmus_cover.jpg"

# Extract album art (requires ffmpeg or ffmpegthumbnailer)
ffmpeg -y -i "$file" -an -vcodec copy "$cover" 2>/dev/null

# Send notification with cover
notify-send -i "$cover" "$title" "$artist"

