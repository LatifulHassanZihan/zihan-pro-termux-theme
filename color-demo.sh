#!/bin/bash

# Zihan Pro Termux Theme - Color Demonstration Script
# This script demonstrates all six color schemes and the key symbolic elements.

# Color definitions from zihan-pro.sh (256-color codes)
# Scheme definitions: [Accent_FG, Base_BG, Highlight_FG] (256-color codes)
declare -a SCHEMES
SCHEMES[0]="196 232 220" # Fire Red: Red, Dark Gray, Gold
SCHEMES[1]="82 232 255"  # Forest Green: Green, Dark Gray, White
SCHEMES[2]="226 232 196" # Solar Yellow: Yellow, Dark Gray, Red
SCHEMES[3]="51 232 82"   # Ocean Blue: Cyan, Dark Gray, Green
SCHEMES[4]="201 232 226" # Sunset Purple: Magenta, Dark Gray, Yellow
SCHEMES[5]="46 232 201"  # Electric Cyan: Bright Green, Dark Gray, Magenta

SCHEME_NAME=("Fire Red" "Forest Green" "Solar Yellow" "Ocean Blue" "Sunset Purple" "Electric Cyan")

# ANSI Escape Codes
RESET="\e[0m"

# Function to display a single scheme
display_scheme() {
    local index=$1
    local name=${SCHEME_NAME[$index]}
    local scheme_colors=${SCHEMES[$index]}
    IFS=' ' read -r ACCENT_FG BASE_BG HIGHLIGHT_FG <<< "$scheme_colors"

    local FG_ACCENT="\e[38;5;${ACCENT_FG}m"
    local FG_HIGHLIGHT="\e[38;5;${HIGHLIGHT_FG}m"
    local BG_BASE="\e[48;5;${BASE_BG}m"

    echo -e "\n${FG_HIGHLIGHT}--- Scheme ${index}: ${name} ---${RESET}"

    # Geometric Launch Sequence Example
    local width=40
    local line_h=$(printf '═%.0s' $(seq 1 $((width - 2))))
    local line_m=$(printf '█%.0s' $(seq 1 $((width - 2))))
    local line_s=$(printf '▒%.0s' $(seq 1 $((width - 2))))

    echo -e "${FG_ACCENT}╔${line_h}╗${RESET}"
    echo -e "${FG_ACCENT}║${FG_HIGHLIGHT}${line_m}${FG_ACCENT}║${RESET}"
    echo -e "${FG_ACCENT}║${FG_HIGHLIGHT}  Zihan Pro Terminal Theme  ${FG_ACCENT}║${RESET}"
    echo -e "${FG_ACCENT}║${FG_HIGHLIGHT}  Active Scheme: ${name}  ${FG_ACCENT}║${RESET}"
    echo -e "${FG_ACCENT}║${FG_HIGHLIGHT}${line_s}${FG_ACCENT}║${RESET}"
    echo -e "${FG_ACCENT}╚${line_h}╝${RESET}"

    # Personalized Information Panel Example
    local user_info="Latiful Hassan Zihan (@alwayszihan)"
    local system_info="Termux on Android | Linux 5.10.0"
    local date_time="Date: $(date +'%Y-%m-%d %H:%M:%S')"

    echo -e "\n${FG_HIGHLIGHT}╔${line_h}╗${RESET}"
    echo -e "${FG_HIGHLIGHT}║${FG_ACCENT}  ${user_info}  ${FG_HIGHLIGHT}║${RESET}"
    echo -e "${FG_HIGHLIGHT}║${FG_ACCENT}  ${system_info}  ${FG_HIGHLIGHT}║${RESET}"
    echo -e "${FG_HIGHLIGHT}║${FG_ACCENT}  ${date_time}  ${FG_HIGHLIGHT}║${RESET}"
    echo -e "${FG_HIGHLIGHT}╚${line_h}╝${RESET}"

    # Status Dashboard Example
    echo -e "\n${FG_HIGHLIGHT}--- SYSTEM STATUS ---${RESET}"
    echo -e "${FG_HIGHLIGHT}♔ ${FG_ACCENT}Session:${RESET} Active ${FG_HIGHLIGHT}♬${RESET} | ${FG_HIGHLIGHT}Security:${RESET} ${FG_ACCENT}\$${RESET} Secure"
    echo -e "${FG_HIGHLIGHT}♖ ${FG_ACCENT}CPU Load:${RESET} ${FG_ACCENT}45%${RESET} | ${FG_HIGHLIGHT}♗ ${FG_ACCENT}Memory:${RESET} ${FG_HIGHLIGHT}62%${RESET}"
    echo -e "${FG_HIGHLIGHT}♙ ${FG_ACCENT}Storage:${RESET} ${FG_HIGHLIGHT}♄ LOW${RESET} | ${FG_HIGHLIGHT}Operation:${RESET} ${FG_ACCENT}♩${RESET} In Progress"

    # Progress Bar Example
    local bar_current=75
    local bar_total=100
    local bar_length=15
    local filled_bar=""
    local empty_bar=""
    local filled_len=$((bar_current * bar_length / bar_total))
    local empty_len=$((bar_length - filled_len))

    for ((i=0; i<filled_len; i++)); do filled_bar="${filled_bar}█"; done
    for ((i=0; i<empty_len; i++)); do empty_bar="${empty_bar}░"; done

    echo -e "${FG_HIGHLIGHT}Progress Bar:${RESET} \e[38;5;${ACCENT_FG}m${filled_bar}${RESET}\e[38;5;240m${empty_bar}${RESET} ${bar_current}%"

    # Prompt Example
    local user_host="${FG_ACCENT}zihan@termux${RESET}"
    local current_dir="${FG_HIGHLIGHT}~/projects/zihan-pro${RESET}"
    local prompt_indicator="${FG_ACCENT}⟫${RESET}"
    echo -e "\n${BG_BASE}[${user_host}] ${FG_HIGHLIGHT}∴ ${current_dir} ${prompt_indicator} ${RESET}"
    echo -e "Command executed ${FG_ACCENT}∆${RESET} with result ${FG_HIGHLIGHT}∑${RESET} and no error ${FG_ACCENT}⌀${RESET}"
}

clear
echo "--- Zihan Pro Theme: Comprehensive Color Demonstration ---"

# Loop through all 6 schemes
for i in {0..5}; do
    display_scheme $i
done

echo -e "\n--- End of Demonstration ---${RESET}"
echo "Run this script on your Termux to see the full effect."
