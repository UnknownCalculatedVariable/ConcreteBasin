#!/usr/bin/env bash

COVER_PATH="$HOME/.cache/cmus-cover.jpg"
LAST_FILE=""

while true; do
    FILE=$(cmus-remote -Q 2>/dev/null | awk '/file/ {$1=""; print substr($0,2)}')

    if [[ "$FILE" != "$LAST_FILE" && -n "$FILE" ]]; then
        ffmpeg -y -i "$FILE" -an -vcodec copy "$COVER_PATH" 2>/dev/null

        if [[ -f "$COVER_PATH" ]]; then
		echo "(button :onclick \"desktop/scripts/music/cmus-workspace.sh\" :class \"music_button\" (image :path \"$COVER_PATH\" :image-width 110 :image-height 30 :class \"image-image\"))"
        fi

        LAST_FILE="$FILE"
    fi

    sleep 0.5
done

