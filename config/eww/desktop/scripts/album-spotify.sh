#!/bin/bash

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
