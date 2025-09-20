#!/bin/bash

# Define source and destination directories
CONFIG_SRC="$HOME/.config"
CONFIG_DEST="$HOME/Projects/git/ConcreteBasin/config"

SCRIPTS_SRC="$HOME/.local/bin"
SCRIPTS_DEST="$HOME/Projects/git/ConcreteBasin/scripts"

# Ensure destination directory exists
mkdir -p "$HOME/Projects/git/ConcreteBasin"

# Handle config directory
echo "Processing config files..."
if [ -d "$CONFIG_DEST" ]; then
    # Remove everything except .git directory
    find "$CONFIG_DEST" -mindepth 1 -maxdepth 1 -not -name '.git' -exec rm -rf {} +
else
    mkdir -p "$CONFIG_DEST"
fi

# Copy specified config directories
for dir in eww kitty sway mako rofi systemd; do
    if [ -d "$CONFIG_SRC/$dir" ]; then
        cp -r "$CONFIG_SRC/$dir" "$CONFIG_DEST/"
        echo "Copied $dir to config"
    else
        echo "Warning: $CONFIG_SRC/$dir does not exist"
    fi
done

# Handle scripts directory
echo -e "\nProcessing scripts..."
if [ -d "$SCRIPTS_DEST" ]; then
    rm -rf "$SCRIPTS_DEST"
fi
mkdir -p "$SCRIPTS_DEST"

# Copy scripts from .local/bin
if [ -d "$SCRIPTS_SRC" ]; then
    cp -r "$SCRIPTS_SRC"/* "$SCRIPTS_DEST/"
    echo "Copied scripts from $SCRIPTS_SRC to $SCRIPTS_DEST"
else
    echo "Warning: $SCRIPTS_SRC does not exist"
fi

echo -e "\nSync complete!"
