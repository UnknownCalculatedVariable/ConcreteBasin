#!/bin/bash

# Check if Spotify is running
is_spotify_running() {
    playerctl -p spotify status >/dev/null 2>&1
}

# Check if CMUS is running
is_cmus_running() {
    cmus-remote -Q >/dev/null 2>&1
}

# Spotify version
run_spotify() {
    # Cache paths
    CACHE_DIR="$HOME/.cache/spotify_art"
    ALBUM_CACHE="$CACHE_DIR/album.png"
    LAST_ART_URL="$CACHE_DIR/last_art_url"

    # Ensure cache directory exists
    mkdir -p "$CACHE_DIR"

    # Create initial blank image
    create_blank_image() {
        convert -size 400x450 xc:transparent png:"$ALBUM_CACHE"
    }

    # Verify image integrity
    verify_image() {
        [[ -f "$1" ]] && identify -quiet "$1" >/dev/null 2>&1
    }

    # Download album art
    download_art() {
        local url="$1"
        local temp_file

        # Create temp file in the same directory for atomic replace
        temp_file=$(mktemp -p "$CACHE_DIR")

        # Download with timeout
        if curl -s --max-time 10 --connect-timeout 5 "$url" -o "$temp_file" 2>/dev/null && \
           verify_image "$temp_file"; then
            # Resize and replace atomically
            convert "$temp_file" -resize 400x450 png:"$temp_file" && \
            mv -f "$temp_file" "$ALBUM_CACHE"
            echo "$url" > "$LAST_ART_URL"
            return 0
        fi

        rm -f "$temp_file"
        return 1
    }

    # Output YUCK widget
    output_widget() {
        echo '(box :class "image" :halign "center" :valign "center"  (image :path "'"$ALBUM_CACHE"'" :image-width 200 :image-height 200 :class "image-image"))'
    }

    # Main update function
    update_art() {
        local art_url=$(playerctl -p spotify metadata mpris:artUrl 2>/dev/null)
        [[ -z "$art_url" ]] && return 1

        if [[ ! -f "$LAST_ART_URL" ]] || [[ "$art_url" != $(< "$LAST_ART_URL") ]]; then
            download_art "$art_url"
        fi
    }

    # Initialize
    if ! verify_image "$ALBUM_CACHE"; then
        create_blank_image
    fi

    # First run
    update_art
    output_widget

    # Event loop
    playerctl -p spotify -F metadata mpris:artUrl 2>/dev/null | while read -r _; do
        update_art || create_blank_image
        output_widget
    done
}

# CMUS version
run_cmus() {
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
}

# Main logic
if is_spotify_running; then
    run_spotify
elif is_cmus_running; then
    run_cmus
else
    # If neither player is running, exit with error
    echo "(box :class \"image\" :halign \"center\" :valign \"center\" (label :text \"No player running\" :class \"image-image\"))"
    exit 1
fi