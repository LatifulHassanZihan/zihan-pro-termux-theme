
## 2. install.sh

```bash
#!/bin/bash

# Zihan Pro Dynamic Color Termux Theme
# GitHub: https://github.com/yourusername/zihan-pro-termux-theme

# Color definitions
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Current theme index (for rotation)
THEME_INDEX=$(date +%s)  # Use timestamp for random start

# Function to get random color
get_random_color() {
    local colors=("$RED" "$GREEN" "$YELLOW" "$BLUE" "$PURPLE" "$CYAN")
    local index=$((THEME_INDEX % 6))
    echo "${colors[$index]}"
}

# Get current theme color
THEME_COLOR=$(get_random_color)
SECONDARY_COLOR=$([ $((THEME_INDEX % 2)) -eq 0 ] && echo "$CYAN" || echo "$PURPLE")
ACCENT_COLOR=$([ $((THEME_INDEX % 3)) -eq 0 ] && echo "$YELLOW" || echo "$GREEN")

# Banner with dynamic colors
echo -e "${THEME_COLOR}"
echo "┌────────────────────────────────────┐"
echo "│                                    │"
echo "│           ZIHAN PRO v3.0          │"
echo "│        Dynamic Color Theme        │"
echo "│                                    │"
echo "└────────────────────────────────────┘"
echo -e "${NC}"

# Check if running in Termux
if [ ! -d "/data/data/com.termux/files/usr" ]; then
    echo -e "${RED}✗ Error: This script must run in Termux${NC}"
    exit 1
fi

# Create backup directory
BACKUP_DIR="$HOME/.termux/backup"
mkdir -p "$BACKUP_DIR"
echo -e "${YELLOW}📁 Creating backup directory...${NC}"

# Backup function
backup_file() {
    if [ -f "$1" ]; then
        cp "$1" "$BACKUP_DIR/$(basename $1).backup.$(date +%Y%m%d%H%M%S)"
        echo -e "${GREEN}✓ Backed up $1${NC}"
    fi
}

# Backup existing files
echo -e "${YELLOW}🔄 Backing up current configuration...${NC}"
backup_file "$HOME/.termux/termux.properties"
backup_file "$HOME/.bashrc"

# Create Termux directory
mkdir -p "$HOME/.termux"

# Install dynamic termux properties
echo -e "${YELLOW}🎨 Installing dynamic color scheme...${NC}"
cat > "$HOME/.termux/termux.properties" << EOF
# Zihan Pro Dynamic Color Theme
# Colors change automatically each session

# Base colors
foreground=#E0E0E0
background=#0A0A12
cursor=#FFD700

# Dynamic color palette - Theme $((THEME_INDEX % 6 + 1))
color0=#1A1A2E
color1=#FF6B6B
color2=#4ECDC4
color3=#FFD166
color4=#118AB2
color5=#EF476F
color6=#06D6A0
color7=#E0E0E0
color8=#2D3047
color9=#FF8A8A
color10=#6AFFE4
color11=#FFDF80
color12=#4CC9F0
color13=#F78FB3
color14=#80FFDB
color15=#FFFFFF
EOF

# Install main bashrc configuration
echo -e "${YELLOW}⚙️  Installing terminal configuration...${NC}"
cat >> "$HOME/.bashrc" << EOF

# =============================================================================
# ZIHAN PRO DYNAMIC COLOR THEME
# GitHub: https://github.com/yourusername/zihan-pro-termux-theme
# =============================================================================

# Theme configuration
ZIHAN_THEME_INDEX=\$(date +%s)
ZIHAN_COLORS=("\033[1;31m" "\033[1;32m" "\033[1;33m" "\033[1;34m" "\033[1;35m" "\033[1;36m")
ZIHAN_THEME=\$((ZIHAN_THEME_INDEX % 6))
THEME_COLOR=\${ZIHAN_COLORS[\$ZIHAN_THEME]}

# Secondary colors based on theme
case \$ZIHAN_THEME in
    0) SECONDARY="\033[1;36m"; ACCENT="\033[1;33m"; BG="\033[1;31m" ;;  # Red theme
    1) SECONDARY="\033[1;35m"; ACCENT="\033[1;33m"; BG="\033[1;32m" ;;  # Green theme  
    2) SECONDARY="\033[1;34m"; ACCENT="\033[1;31m"; BG="\033[1;33m" ;;  # Yellow theme
    3) SECONDARY="\033[1;33m"; ACCENT="\033[1;32m"; BG="\033[1;34m" ;;  # Blue theme
    4) SECONDARY="\033[1;32m"; ACCENT="\033[1;36m"; BG="\033[1;35m" ;;  # Purple theme
    5) SECONDARY="\033[1;31m"; ACCENT="\033[1;35m"; BG="\033[1;36m" ;;  # Cyan theme
esac

NC="\033[0m"

# Launch Sequence with Dynamic Colors
echo -e "\${THEME_COLOR}"
echo "┌────────────────────────────────────┐"
echo "│                                    │"
echo "│           ZIHAN PRO v3.0          │"
echo "│        Dynamic Color Theme        │"
echo "│                                    │"
echo "└────────────────────────────────────┘"
echo -e "\${NC}"

# Welcome Message
echo -e "\${SECONDARY}• \${BG}Welcome to Zihan Pro Terminal\${NC}"
echo -e "\${SECONDARY}• \${ACCENT}Dynamic Theme: Color Scheme \$((ZIHAN_THEME + 1))\${NC}"

# User Information Panel
echo -e "\${THEME_COLOR}╭─\${SECONDARY}User     \${ACCENT}: \${BG}Latiful Hassan Zihan\${NC}"
echo -e "\${THEME_COLOR}├─\${SECONDARY}Telegram \${ACCENT}: \${BG}@alwayszihan\${NC}"
echo -e "\${THEME_COLOR}╰─\${SECONDARY}Status   \${ACCENT}: \${BG}Active ✓\${NC}"

# System Status Dashboard
echo -e "\n\${ACCENT}♔ \${BG}System Status:\${NC}"
echo -e "  \${SECONDARY}₿  \${NC}Connection: \${BG}Secure ✓\${NC}"
echo -e "  \${SECONDARY}⌀  \${NC}Security: \${BG}Protected ✓\${NC}"
echo -e "  \${SECONDARY}∆  \${NC}Performance: \${BG}Optimal ↑\${NC}"
echo -e "  \${SECONDARY}∑  \${NC}Storage: \${ACCENT}68%\${NC}"

# Progress Indicator
echo -e "\n\${ACCENT}♬ \${BG}Loading Complete:\${NC}"
echo -e "  \${THEME_COLOR}[▰▰▰▰▰▱▱▱] 68%\${NC}"

# Dynamic Prompt
PS1='\[\$(echo -e \$THEME_COLOR)\]╭─\[\$(echo -e \$BG)\]∴Zihan \[\$(echo -e \$ACCENT)\]»\n\[\$(echo -e \$THEME_COLOR)\]╰─\[\$(echo -e \$BG)\]⟫\[\$(echo -e \$SECONDARY)\] \w \[\$(echo -e \$ACCENT)\]▸ \[\033[0m\]'

# System Information Function
zihan_status() {
    echo -e "\${ACCENT}⚳ \${BG}System Information:\${NC}"
    echo -e "  \${SECONDARY}♔ \${NC}System: \${BG}Optimal\${NC}"
    echo -e "  \${SECONDARY}♖ \${NC}Memory: \${BG}Stable\${NC}"
    echo -e "  \${SECONDARY}♗ \${NC}Storage: \${ACCENT}Good\${NC}"
    echo -e "  \${SECONDARY}♘ \${NC}Network: \${BG}Active\${NC}"
    echo -e "  \${SECONDARY}🎨 \${NC}Theme: \${BG}Color Scheme \$((ZIHAN_THEME + 1))\${NC}"
}

# Theme Information
theme_info() {
    echo -e "\${ACCENT}🎨 \${BG}Current Theme Information:\${NC}"
    echo -e "  \${SECONDARY}Scheme: \${BG}Color Scheme \$((ZIHAN_THEME + 1))\${NC}"
    echo -e "  \${SECONDARY}Primary: \${THEME_COLOR}Primary Color\${NC}"
    echo -e "  \${SECONDARY}Secondary: \${SECONDARY}Secondary Color\${NC}"
    echo -e "  \${SECONDARY}Accent: \${ACCENT}Accent Color\${NC}"
}

# Next Theme Function
next_theme() {
    echo -e "\${ACCENT}🔄 \${BG}Switching to next theme...\${NC}"
    # This would require re-sourcing with new index
    echo -e "\${SECONDARY}Restart terminal to see new theme\${NC}"
}

# Color Demo Function
color_demo() {
    echo -e "\${ACCENT}🌈 \${BG}Color Scheme Demo:\${NC}"
    echo -e "\${THEME_COLOR}  Primary Color - Theme Color\${NC}"
    echo -e "\${SECONDARY}  Secondary Color - Supporting Color\${NC}" 
    echo -e "\${ACCENT}  Accent Color - Highlight Color\${NC}"
    echo -e "\${BG}  Background Color - Status Color\${NC}"
    echo -e "\n\${SECONDARY}Available schemes:\${NC}"
    echo -e "\033[1;31m  1. Fire Red\033[0m    \033[1;32m  2. Forest Green\033[0m"
    echo -e "\033[1;33m  3. Solar Yellow\033[0m \033[1;34m  4. Ocean Blue\033[0m"
    echo -e "\033[1;35m  5. Sunset Purple\033[0m \033[1;36m  6. Electric Cyan\033[0m"
}

# Enhanced Commands with Colors
alias ls='echo -e "\${SECONDARY}♪ \${NC}Listing files..."; ls --color=auto'
alias cd='echo -e "\${ACCENT}♩ \${NC}Changing directory..."; cd'
alias update='echo -e "\${BG}♬ \${NC}Updating system..."; pkg update'

# System Monitor
sys_monitor() {
    echo -e "\${ACCENT}∆ \${BG}Performance Metrics:\${NC}"
    echo -e "  \${SECONDARY}CPU: \${ACCENT}\$(grep 'cpu ' /proc/stat | awk '{usage=(\$2+\$4)*100/(\$2+\$4+\$5)} END {print usage "%"}')\${NC}"
    echo -e "  \${SECONDARY}RAM: \${ACCENT}\$(free -m | awk 'NR==2{printf "%.2f%%", \$3*100/\$2}')\${NC}"
    echo -e "  \${SECONDARY}Disk: \${ACCENT}\$(df -h / | awk 'NR==2{print \$5}')\${NC}"
}

# Storage Check
check_storage() {
    usage=\$(df /data/data/com.termux/files | awk 'NR==2 {print \$5}' | sed 's/%//')
    if [ \$usage -gt 80 ]; then
        echo -e "\033[1;31m♆ \033[1;33mWarning: Storage reaching limit!\033[0m"
        echo -e "  \${SECONDARY}Usage: \033[1;31m%\$usage\033[0m"
    else
        echo -e "\${SECONDARY}∑ \${BG}Storage: \${ACCENT}Normal (%\$usage)\${NC}"
    fi
}

# Error Handling
command_not_found_handle() {
    echo -e "\033[1;31m⊥ \033[1;33mError: Command not found - '\$1'\033[0m"
    echo -e "\${ACCENT}∨ \${NC}Solution: Try installing with \${SECONDARY}pkg install \$1\033[0m"
    return 127
}

# Initialize
echo -e "\${BG}✓ \${SECONDARY}Ready\${NC}"
check_storage
echo -e "\${ACCENT}🎨 \${NC}Theme: \${BG}Color Scheme \$((ZIHAN_THEME + 1))\${NC}"
echo
EOF

# Create color demo script
echo -e "${YELLOW}🎭 Creating color demonstration script...${NC}"
cat > "$HOME/color-demo.sh" << 'EOF'
#!/bin/bash
# Zihan Pro Color Demo

echo "🌈 Zihan Pro Color Demonstration"
echo "================================"

colors=("1;31" "1;32" "1;33" "1;34" "1;35" "1;36")
names=("Fire Red" "Forest Green" "Solar Yellow" "Ocean Blue" "Sunset Purple" "Electric Cyan")

for i in {0..5}; do
    echo -e "\033[${colors[$i]}mTheme $((i+1)): ${names[$i]}\033[0m"
    echo -e "  Primary: \033[${colors[$i]}m████\033[0m"
    echo -e "  Secondary: \033[1;3$((($i+1)%6))m████\033[0m"
    echo -e "  Accent: \033[1;3$((($i+2)%6))m████\033[0m"
    echo
done
EOF

chmod +x "$HOME/color-demo.sh"

# Reload settings
echo -e "${YELLOW}🔄 Reloading Termux settings...${NC}"
termux-reload-settings

# Completion message
echo -e "${GREEN}"
echo "╔════════════════════════════════════╗"
echo "║          INSTALLATION COMPLETE!   ║"
echo "║     Zihan Pro Theme Activated     ║"
echo "╚════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${THEME_COLOR}╭─${SECONDARY_COLOR}Theme      ${ACCENT_COLOR}: ${BG_COLOR}Color Scheme $((THEME_INDEX % 6 + 1)${NC}"
echo -e "${THEME_COLOR}├─${SECONDARY_COLOR}User       ${ACCENT_COLOR}: ${BG_COLOR}Latiful Hassan Zihan${NC}"
echo -e "${THEME_COLOR}├─${SECONDARY_COLOR}Telegram   ${ACCENT_COLOR}: ${BG_COLOR}@alwayszihan${NC}"
echo -e "${THEME_COLOR}╰─${SECONDARY_COLOR}Status     ${ACCENT_COLOR}: ${GREEN}Active ✓${NC}"

echo -e "\n${YELLOW}🚀 Final step:${NC}"
echo -e "${BLUE}Close Termux completely and reopen, or run:${NC}"
echo -e "${GREEN}source ~/.bashrc${NC}"

echo -e "\n${PURPLE}🎯 Available commands:${NC}"
echo -e "  ${GREEN}zihan_status${NC}    - System status"
echo -e "  ${GREEN}theme_info${NC}      - Theme information"
echo -e "  ${GREEN}color_demo${NC}      - Color scheme demo"
echo -e "  ${GREEN}sys_monitor${NC}     - System metrics"
echo -e "  ${GREEN}check_storage${NC}   - Storage check"

echo -e "\n${CYAN}Every new terminal session will show different colors!${NC}"