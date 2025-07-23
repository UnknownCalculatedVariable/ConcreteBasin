#!/bin/bash

album_path="$HOME/.cache/album.png"

while true; do
    art_url=$(playerctl metadata mpris:artUrl 2>/dev/null)
    
    if [[ -n "$art_url" ]]; then
        fixed_url=$(echo "$art_url" | sed 's|open.spotify.com/image|i.scdn.co/image|')
        curl -s -o "$album_path" "$fixed_url"
    fi
    
    echo " (box :class \"image\" 
    (image :path \"$album_path\" :image-width 400 :image-height 450 :class \"image-image\")"
    
    sleep 2
done

