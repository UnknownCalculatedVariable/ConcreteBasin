#!/usr/bin/env bash

# Rofi-Obsidian Navigator - Fixed Obsidian URI Version
# Properly opens files in Obsidian using obsidian:// URI scheme

set -euo pipefail
IFS=$'\n\t'

# Configuration
VAULT_DIR="$HOME/Notes/ThinkDock"
VAULT_NAME="ThinkDock"  # Must match your Obsidian vault name
DAILY_NOTES_DIR="$VAULT_DIR/Notes/Daily"
EDITOR_CMD="vim"
TERMINAL_CMD="alacritty"
OBSIDIAN_CMD="obsidian"
ROFI_CONFIG="$HOME/.config/rofi/config.rasi"

# Cleanup function
cleanup() {
    pkill -f "rofi.*ThinkDock" || true
    exit 0
}

trap cleanup EXIT INT TERM

current_date() {
    date +"%Y-%m-%d"
}

daily_note_name() {
    echo "$(current_date).md"
}

create_note() {
    local note_path="$1"
    
    if [[ -z "$note_path" ]]; then
        note_path="$DAILY_NOTES_DIR/$(daily_note_name)"
    elif [[ ! "$note_path" =~ \.md$ ]]; then
        note_path="${note_path}.md"
    fi

    mkdir -p "$(dirname "$note_path")"
    touch "$note_path"
    echo "$note_path"
}

show_contents() {
    local current_dir="$1"
    
    # Get directories
    local dirs=()
    while IFS= read -r dir; do
        dirs+=(" $(basename "$dir")")
    done < <(find "$current_dir" -mindepth 1 -maxdepth 1 -type d -not -path '*/.*' | sort)
    
    # Get markdown files
    local files=()
    while IFS= read -r file; do
        files+=(" $(basename "$file")")
    done < <(find "$current_dir" -mindepth 1 -maxdepth 1 -type f -name "*.md" -not -path '*/.*' | sort)
    
    # Combine with navigation options
    local menu_items=(
        ".. (Go up)"
        " Create new note"
        "${dirs[@]}"
        "${files[@]}"
    )
    
    printf '%s\n' "${menu_items[@]}"
}

navigate() {
    local current_dir="${1:-$VAULT_DIR}"
    
    while true; do
        local selected=$(show_contents "$current_dir" | rofi -dmenu -p "ThinkDock: ${current_dir#$VAULT_DIR/}" -config "$ROFI_CONFIG")

        # Exit completely if ESC is pressed
        if [[ -z "$selected" ]]; then
            cleanup
        elif [[ "$selected" == ".. (Go up)" ]]; then
            current_dir="$(dirname "$current_dir")"
        elif [[ "$selected" == " Create new note" ]]; then
            create_note_interactive "$current_dir"
            cleanup
        elif [[ "$selected" =~ ^[[:space:]]+(.*)$ ]]; then
            current_dir="$current_dir/${BASH_REMATCH[1]}"
        elif [[ "$selected" =~ ^[[:space:]]+(.*\.md)$ ]]; then
            choose_editor "$current_dir/${BASH_REMATCH[1]}"
            cleanup
        fi
    done
}

create_note_interactive() {
    local base_dir="${1:-$VAULT_DIR}"
    
    local note_name=$(rofi -dmenu -p "Note name (blank for daily note)" -config "$ROFI_CONFIG")
    
    local note_path
    if [[ -z "$note_name" ]]; then
        note_path="$DAILY_NOTES_DIR/$(daily_note_name)"
    else
        note_path="$base_dir/${note_name%.md}.md"
    fi
    
    if [[ -e "$note_path" ]]; then
        local response=$(echo -e "Yes\nNo" | rofi -dmenu -p "Note exists. Open anyway?" -config "$ROFI_CONFIG")
        [[ "$response" == "Yes" ]] && choose_editor "$note_path"
    else
        note_path=$(create_note "$note_path")
        choose_editor "$note_path"
    fi
}

choose_editor() {
    local file_path="$1"
    local relative_path="${file_path#$VAULT_DIR/}"
    local choice=$(echo -e "Obsidian\nVim (Markdown)\nCancel" | rofi -dmenu -p "Open with:" -config "$ROFI_CONFIG")
    
    case "$choice" in
        Obsidian)
            xdg-open "obsidian://open?path=${file_path}&vault=${VAULT_NAME}" &
            ;;
        "Vim (Markdown)")
            # Open in Alacritty with Vim, using Markdown-friendly settings
            $TERMINAL_CMD -e bash -c "vim -c 'set syntax=markdown' \
                -c 'set conceallevel=2' \
                -c 'set wrap' \
                -c 'set linebreak' \
                -c 'set nonumber' \
                '$file_path'" &
            ;;
        *)
            return
            ;;
    esac
}

main() {
    # Check dependencies
    for cmd in rofi "$EDITOR_CMD" "$OBSIDIAN_CMD" xdg-open "$TERMINAL_CMD"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "Error: $cmd is not installed" >&2
            exit 1
        fi
    done

    mkdir -p "$VAULT_DIR" "$DAILY_NOTES_DIR"

    navigate "$VAULT_DIR"
}

main "$@"
