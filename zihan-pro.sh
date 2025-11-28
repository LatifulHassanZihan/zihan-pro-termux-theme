#!/bin/bash

# Zihan Pro Termux Theme - Core Script
# Designed for dynamic color rotation and technical elegance.

# --- 1. Color Definitions and Rotation Logic ---

# Define the six color schemes: [Primary, Secondary, Tertiary]
# Primary: Foreground/Accent, Secondary: Background/Base, Tertiary: Prompt/Highlight
# Colors are standard ANSI 8-bit codes for simplicity and compatibility,
# but we will use the user's requested hex colors for the main foreground/background
# via Termux properties if possible, or fall back to ANSI for script elements.
# For script elements, we use the 256-color palette (e.g., \e[38;5;XXXm) for better control.

# We will use the user's requested hex colors for the main foreground/background
# via Termux properties if possible, but for the script's internal elements (like the dashboard),
# we will use the 256-color palette for consistency across terminals.

# The script will primarily use the 256-color palette for its own output
# and rely on the user to set the main Termux colors via the install script.

# Color Palette (256-color codes for the script's output)
# Note: These are approximations of the requested hex values in the 256-color space.
C_RED="196"    # Bright Red
C_GREEN="82"   # Neon Green
C_YELLOW="226" # Bright Yellow
C_CYAN="51"    # Bright Cyan
C_MAGENTA="201" # Bright Magenta
C_WHITE="255"  # Pure White
C_GOLD="220"   # Gold

# Scheme definitions: [Accent_FG, Base_BG, Highlight_FG] (256-color codes)
declare -a SCHEMES
SCHEMES[0]="196 232 220" # Fire Red: Red, Dark Gray, Gold
SCHEMES[1]="82 232 255"  # Forest Green: Green, Dark Gray, White
SCHEMES[2]="226 232 196" # Solar Yellow: Yellow, Dark Gray, Red
SCHEMES[3]="51 232 82"   # Ocean Blue: Cyan, Dark Gray, Green
SCHEMES[4]="201 232 226" # Sunset Purple: Magenta, Dark Gray, Yellow
SCHEMES[5]="46 232 201"  # Electric Cyan: Bright Green, Dark Gray, Magenta

# Color Rotation Logic: Select scheme based on current minute modulo 6
SCHEME_INDEX=$(( $(date +%M) % 6 ))
SCHEME_NAME=("Fire Red" "Forest Green" "Solar Yellow" "Ocean Blue" "Sunset Purple" "Electric Cyan")

# Parse the selected scheme
IFS=' ' read -r ACCENT_FG BASE_BG HIGHLIGHT_FG <<< "${SCHEMES[$SCHEME_INDEX]}"

# ANSI Escape Codes
# \e[38;5;${COLOR}m : Set foreground color
# \e[48;5;${COLOR}m : Set background color
# \e[0m : Reset all attributes
FG_ACCENT="\e[38;5;${ACCENT_FG}m"
FG_HIGHLIGHT="\e[38;5;${HIGHLIGHT_FG}m"
BG_BASE="\e[48;5;${BASE_BG}m"
RESET="\e[0m"

# --- 2. System Information Functions ---

# Function to get CPU usage (simple approximation)
get_cpu_load() {
    # Get the average load over the last minute (first number from uptime)
    # This is a simple, non-invasive way to get a load indicator.
    LOAD_AVG=$(uptime | awk -F'load average: ' '{print $2}' | cut -d, -f1 | tr -d ' ')
    # Simple threshold for color-coding
    if (( $(echo "$LOAD_AVG > 1.0" | bc -l) )); then
        echo -e "${FG_ACCENT}" # High load
    elif (( $(echo "$LOAD_AVG > 0.5" | bc -l) )); then
        echo -e "${FG_HIGHLIGHT}" # Medium load
    else
        echo -e "${FG_HIGHLIGHT}" # Low load
    fi
    # Display as percentage for elegance (assuming 1.0 is 100% for a single core)
    PERCENT=$(echo "$LOAD_AVG * 100" | bc -l | cut -d. -f1)
    echo -n "CPU: ${PERCENT}%"
    echo -e "${RESET}"
}

# Function to get Memory usage
get_mem_usage() {
    # Get total and free memory in KB
    MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    MEM_FREE=$(grep MemFree /proc/meminfo | awk '{print $2}')
    MEM_USED_KB=$((MEM_TOTAL - MEM_FREE))
    MEM_USED_PERCENT=$((MEM_USED_KB * 100 / MEM_TOTAL))

    # Color-coded warning
    if [ "$MEM_USED_PERCENT" -gt 80 ]; then
        echo -e "${FG_ACCENT}" # Red/Accent for high usage
    elif [ "$MEM_USED_PERCENT" -gt 50 ]; then
        echo -e "${FG_HIGHLIGHT}" # Highlight for medium usage
    else
        echo -e "${FG_HIGHLIGHT}" # Highlight for low usage
    fi
    echo -n "MEM: ${MEM_USED_PERCENT}%"
    echo -e "${RESET}"
}

# Function to get Storage Warning (using Astrological Symbols)
get_storage_warning() {
    # Check root filesystem usage
    STORAGE_PERCENT=$(df -h / | grep / | awk '{print $5}' | tr -d '%')

    if [ "$STORAGE_PERCENT" -gt 90 ]; then
        # Critical: Uranus (♅)
        echo -e "${FG_ACCENT}♅ CRITICAL${RESET}"
    elif [ "$STORAGE_PERCENT" -gt 75 ]; then
        # Low: Saturn (♄)
        echo -e "${FG_HIGHLIGHT}♄ LOW${RESET}"
    else
        # Normal: No symbol
        echo -e "${FG_HIGHLIGHT}⌀ OK${RESET}" # Using Diameter symbol for No-Op/Normal
    fi
}

# Function to create a block-element progress bar
# Usage: progress_bar <current> <total> <length> <color_code>
progress_bar() {
    local current=$1
    local total=$2
    local length=$3
    local color=$4
    local percent=$((current * 100 / total))
    local filled_len=$((percent * length / 100))
    local empty_len=$((length - filled_len))
    local filled_bar=""
    local empty_bar=""

    # Filled part (using full block █)
    for ((i=0; i<filled_len; i++)); do
        filled_bar="${filled_bar}█"
    done

    # Empty part (using light shade ░)
    for ((i=0; i<empty_len; i++)); do
        empty_bar="${empty_bar}░"
    done

    echo -e "\e[38;5;${color}m${filled_bar}${RESET}\e[38;5;240m${empty_bar}${RESET}"
}

# --- 3. Visual Elements Display ---

# Geometric Launch Sequence
display_launch_sequence() {
    local width=40
    local line_h=$(printf '═%.0s' $(seq 1 $((width - 2))))
    local line_m=$(printf '█%.0s' $(seq 1 $((width - 2))))
    local line_s=$(printf '▒%.0s' $(seq 1 $((width - 2))))

    echo -e "${FG_ACCENT}╔${line_h}╗${RESET}"
    echo -e "${FG_ACCENT}║${FG_HIGHLIGHT}${line_m}${FG_ACCENT}║${RESET}"
    echo -e "${FG_ACCENT}║${FG_HIGHLIGHT}  Zihan Pro Terminal Theme  ${FG_ACCENT}║${RESET}"
    echo -e "${FG_ACCENT}║${FG_HIGHLIGHT}  Active Scheme: ${SCHEME_NAME[$SCHEME_INDEX]}  ${FG_ACCENT}║${RESET}"
    echo -e "${FG_ACCENT}║${FG_HIGHLIGHT}${line_s}${FG_ACCENT}║${RESET}"
    echo -e "${FG_ACCENT}╚${line_h}╝${RESET}"
}

# Personalized Information Panel
display_info_panel() {
    local user_info="Latiful Hassan Zihan (@alwayszihan)"
    local system_info="Termux on Android | $(uname -sro)"
    local date_time="Date: $(date +'%Y-%m-%d %H:%M:%S')"
    local width=40
    local line_h=$(printf '═%.0s' $(seq 1 $((width - 2))))

    echo -e "\n${FG_HIGHLIGHT}╔${line_h}╗${RESET}"
    echo -e "${FG_HIGHLIGHT}║${FG_ACCENT}  ${user_info}  ${FG_HIGHLIGHT}║${RESET}"
    echo -e "${FG_HIGHLIGHT}║${FG_ACCENT}  ${system_info}  ${FG_HIGHLIGHT}║${RESET}"
    echo -e "${FG_HIGHLIGHT}║${FG_ACCENT}  ${date_time}  ${FG_HIGHLIGHT}║${RESET}"
    echo -e "${FG_HIGHLIGHT}╚${line_h}╝${RESET}"
}

# Status Dashboard
display_status_dashboard() {
    local cpu_load_color=$(get_cpu_load | cut -d' ' -f1)
    local mem_usage_color=$(get_mem_usage | cut -d' ' -f1)
    local storage_status=$(get_storage_warning)

    # Simple progress bar example (e.g., 60% full)
    local bar_current=60
    local bar_total=100
    local bar_length=10
    local progress_bar_display=$(progress_bar $bar_current $bar_total $bar_length $ACCENT_FG)

    echo -e "\n${FG_HIGHLIGHT}--- SYSTEM STATUS ---${RESET}"
    echo -e "${FG_HIGHLIGHT}♔ ${FG_ACCENT}Session:${RESET} Active ${FG_HIGHLIGHT}♬${RESET} | ${FG_HIGHLIGHT}Security:${RESET} ${FG_ACCENT}\$${RESET} Secure"
    echo -e "${FG_HIGHLIGHT}♖ ${FG_ACCENT}CPU Load:${RESET} $(get_cpu_load | cut -d' ' -f2-) | ${FG_HIGHLIGHT}♗ ${FG_ACCENT}Memory:${RESET} $(get_mem_usage | cut -d' ' -f2-)"
    echo -e "${FG_HIGHLIGHT}♙ ${FG_ACCENT}Storage:${RESET} ${storage_status} | ${FG_HIGHLIGHT}Progress:${RESET} ${progress_bar_display} ${bar_current}%"
    echo -e "${FG_HIGHLIGHT}---------------------${RESET}\n"
}

# --- 4. Prompt System (PS1) ---

set_prompt() {
    # Get current user and host
    local user_host="${FG_ACCENT}\u@\h${RESET}"
    # Get current working directory
    local current_dir="${FG_HIGHLIGHT}\w${RESET}"
    # Final prompt indicator: ⟫
    local prompt_indicator="${FG_ACCENT}⟫${RESET}"

    # PS1: [USER@HOST] ∴ [CURRENT_DIR] ⟫
    export PS1="\[${FG_ACCENT}\]\[${BG_BASE}\][${user_host}] ${FG_HIGHLIGHT}∴ ${current_dir} ${prompt_indicator} "
}

# --- 5. Execution ---

# Only run if not an interactive shell (to avoid re-running on every command)
if [ -z "$PS1" ]; then
    return
fi

# Clear screen and display elements
clear
display_launch_sequence
display_info_panel
display_status_dashboard
set_prompt

# Optional: Add enhanced command aliases with visual feedback
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias status='clear && display_status_dashboard' # Custom command for real-time status check

# Final cleanup (reset colors after the script runs, before the prompt is displayed)
echo -e "${RESET}"
