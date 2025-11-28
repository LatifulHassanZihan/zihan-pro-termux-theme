#!/bin/bash

# Zihan Pro Uninstaller

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Removing Zihan Pro Dynamic Theme...${NC}"

# Restore backups
restore_backup() {
    local file=$1
    local backup=$(ls -t "$HOME/.termux/backup/$(basename $file).backup."* 2>/dev/null | head -1)
    
    if [ -n "$backup" ]; then
        cp "$backup" "$file"
        echo -e "${GREEN}✓ Restored $file${NC}"
    else
        rm -f "$file"
        echo -e "${YELLOW}⚠ Removed $file (no backup)${NC}"
    fi
}

# Remove theme from bashrc
if [ -f "$HOME/.bashrc" ]; then
    sed -i '/ZIHAN PRO DYNAMIC COLOR THEME/,/^# ======/d' "$HOME/.bashrc"
    echo -e "${GREEN}✓ Removed theme from .bashrc${NC}"
fi

# Restore termux properties
restore_backup "$HOME/.termux/termux.properties"

# Remove demo script
rm -f "$HOME/color-demo.sh"

# Reload settings
termux-reload-settings

echo -e "${GREEN}Zihan Pro theme completely removed!${NC}"
echo -e "${YELLOW}Restart Termux to see changes.${NC}"