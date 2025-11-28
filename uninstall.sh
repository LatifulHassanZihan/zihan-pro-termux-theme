#!/bin/bash

# Zihan Pro Termux Theme - Uninstallation Script

THEME_DIR="$HOME/zihan-pro-termux-theme"
BASHRC="$HOME/.bashrc"

echo "--- Zihan Pro Theme Uninstallation ---"

# 1. Remove theme initialization from .bashrc
if grep -q "Zihan Pro Theme Initialization" "$BASHRC"; then
    echo "Removing theme initialization from $BASHRC..."
    # Use sed to remove the block of lines added by the install script
    sed -i '/# --- Zihan Pro Theme Initialization ---/,/# --------------------------------------/d' "$BASHRC"
    echo "Theme initialization removed from $BASHRC."
else
    echo "Theme initialization not found in $BASHRC. Skipping."
fi

# 2. Remove theme directory and files
if [ -d "$THEME_DIR" ]; then
    echo "Removing theme directory: $THEME_DIR"
    rm -rf "$THEME_DIR"
    echo "Theme files removed."
else
    echo "Theme directory not found. Skipping file removal."
fi

echo "--- Uninstallation Complete ---"
echo "Please restart Termux or run 'source $BASHRC' to revert to your previous configuration."
