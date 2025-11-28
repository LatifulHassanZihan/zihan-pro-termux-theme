#!/bin/bash

# Zihan Pro Termux Theme - Installation Script

THEME_DIR="$HOME/zihan-pro-termux-theme"
BASHRC="$HOME/.bashrc"
PROFILE="$HOME/.profile"
THEME_SCRIPT="zihan-pro.sh"

echo "--- Zihan Pro Theme Installation ---"

# 1. Create theme directory and copy files
if [ ! -d "$THEME_DIR" ]; then
    mkdir -p "$THEME_DIR"
fi

# Copy the core theme script
cp "$THEME_SCRIPT" "$THEME_DIR/"
chmod +x "$THEME_DIR/$THEME_SCRIPT"

echo "Theme script copied to $THEME_DIR/$THEME_SCRIPT"

# 2. Configure .bashrc to source the theme script
if ! grep -q "zihan-pro-termux-theme" "$BASHRC"; then
    echo "" >> "$BASHRC"
    echo "# --- Zihan Pro Theme Initialization ---" >> "$BASHRC"
    echo "if [ -f \"$THEME_DIR/$THEME_SCRIPT\" ]; then" >> "$BASHRC"
    echo "  source \"$THEME_DIR/$THEME_SCRIPT\"" >> "$BASHRC"
    echo "fi" >> "$BASHRC"
    echo "# --------------------------------------" >> "$BASHRC"
    echo "Theme initialization added to $BASHRC"
else
    echo "Theme initialization already present in $BASHRC. Skipping."
fi

# 3. Set Termux Color Properties (Optional but recommended for full effect)
# Termux uses a properties file to set the main terminal colors.
# We will set a neutral, dark background and let the script handle the dynamic foregrounds.
# The user will need to manually set the background/foreground in the Termux settings
# for the *full* effect, but we can provide a base.

# Note: Termux color properties are usually set in $PREFIX/etc/termux.properties
# which requires root or a special Termux API. For a non-root installation,
# we can only rely on the script's ANSI codes for the script's output.
# We will inform the user about the recommended manual settings.

echo ""
echo "--- IMPORTANT: Manual Configuration Recommended ---"
echo "For the full 'Zihan Pro' experience, please manually set your Termux color scheme to a dark, high-contrast base."
echo "Recommended settings (Termux Settings -> Style -> Color Preset):"
echo "  - Background: Very dark gray/black (e.g., #1A1A1A or #000000)"
echo "  - Foreground: Light gray/white (e.g., #CCCCCC or #FFFFFF)"
echo "The theme script will handle the dynamic color rotation for the prompt and dashboard elements."
echo ""

echo "--- Installation Complete ---"
echo "Please restart Termux or run 'source $BASHRC' to see the changes."
echo "Each new session will feature a different color scheme."
