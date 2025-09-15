#!/bin/bash

# E-Book Browser with Rofi - Improved Version
# Allows browsing and opening e-books from ~/E-Books

EBOOK_DIR="$HOME/E-Book"

# Check if the directory exists
if [ ! -d "$EBOOK_DIR" ]; then
    rofi -e "E-Books directory not found: $EBOOK_DIR"
    exit 1
fi

# Function to find all e-books recursively
find_ebooks() {
    find "$EBOOK_DIR" -type f \( \
        -iname "*.pdf" -o \
        -iname "*.epub" -o \
        -iname "*.mobi" -o \
        -iname "*.azw" -o \
        -iname "*.azw3" -o \
        -iname "*.djvu" \)
}

# Function to try opening with epr in Alacritty
try_epr() {
    local file="$1"
    if command -v epr >/dev/null 2>&1 && command -v alacritty >/dev/null 2>&1; then
        # Open epr in Alacritty
        alacritty -e epr "$file" &
        return 0
    else
        # If epr or alacritty not available, try zathura as fallback
        if command -v zathura >/dev/null 2>&1; then
            rofi -e "EPR or Alacritty not available, trying Zathura instead"
            zathura "$file" &
            return 0
        else
            return 1
        fi
    fi
}

# Function to display e-books and handle selection
show_ebooks() {
    # Get list of e-books
    ebooks=$(find_ebooks)
    
    if [ -z "$ebooks" ]; then
        rofi -e "No e-books found in $EBOOK_DIR"
        exit 0
    fi
    
    # Display e-books in rofi (show relative paths)
    selected=$(echo "$ebooks" | sed "s|$EBOOK_DIR/||" | rofi -dmenu -i -p "Select E-Book:")
    
    if [ -n "$selected" ]; then
        full_path="$EBOOK_DIR/$selected"
        
        # Verify the file exists
        if [ ! -f "$full_path" ]; then
            rofi -e "File not found: $full_path"
            exit 1
        fi
        
        # Show open options
        option=$(echo -e "EPR (Terminal)\nFoliate (GUI)\nZathura (Terminal fallback)" | rofi -dmenu -i -p "Open with:")
        
        case $option in
            "EPR (Terminal)")
                if ! try_epr "$full_path"; then
                    rofi -e "Failed to open with terminal readers. Try Foliate or install Alacritty/Zathura"
                fi
                ;;
            "Foliate (GUI)")
                if command -v com.github.johnfactotum.Foliate >/dev/null 2>&1; then
                    com.github.johnfactotum.Foliate "$full_path" &
                elif command -v foliate >/dev/null 2>&1; then
                    foliate "$full_path" &
                else
                    rofi -e "Foliate not found. Install with: yay -S foliate"
                fi
                ;;
            "Zathura (Terminal fallback)")
                if command -v zathura >/dev/null 2>&1; then
                    zathura "$full_path" &
                else
                    rofi -e "Zathura not found. Install with: yay -S zathura zathura-pdf-poppler"
                fi
                ;;
            *)
                # User canceled or invalid option
                ;;
        esac
    fi
}

# Main execution
show_ebooks