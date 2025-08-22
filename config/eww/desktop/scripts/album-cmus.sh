#!/usr/bin/env bash

COVER_PATH="$HOME/.cache/cmus-cover.jpg"
LAST_FILE=""

while true; do
    FILE=$(cmus-remote -Q 2>/dev/null | awk '/file/ {$1=""; print substr($0,2)}')

    if [[ "$FILE" != "$LAST_FILE" && -n "$FILE" ]]; then
        ffmpeg -y -i "$FILE" -an -vcodec copy "$COVER_PATH" 2>/dev/null

        if [[ -f "$COVER_PATH" ]]; then
            echo "(box :class \"image\" :halign \"center\" :valign \"center\" (image :path \"$COVER_PATH\" :image-width 200 :image-height 200 :class \"image-image\"))"
        fi

        LAST_FILE="$FILE"
    fi

    sleep 1
done

