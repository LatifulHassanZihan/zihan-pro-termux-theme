# Zihan Pro Termux Theme

An exclusive, sophisticated terminal theme for Android Termux, "Zihan Pro" revolutionizes the command-line interface through a dynamic color system and technical elegance. This theme is designed to provide a fresh, visually engaging experience with every new terminal session.

## Features

*   **Dynamic Color Rotation:** Automatically cycles through six distinct, high-contrast color schemes based on the session timestamp, ensuring a unique look for every launch.
    1.  Fire Red
    2.  Forest Green
    3.  Solar Yellow
    4.  Ocean Blue
    5.  Sunset Purple
    6.  Electric Cyan
*   **Geometric Launch Sequence:** A clean, color-coded geometric pattern using box-drawing characters (`╔═╗`) provides immediate visual impact on startup.
*   **Symbolic Elegance:** Incorporates mathematical symbols (e.g., `∴`, `⟫`) and technical operators for a sophisticated, functional prompt system.
*   **Comprehensive Status Dashboard:** Features real-time system monitoring using elegant symbols:
    *   **Chess Symbols** (`♔`, `♖`, `♗`) for user session, CPU, and memory status.
    *   **Astrological Symbols** (`♄`, `♅`) for storage warnings.
    *   **Musical Symbols** (`♪`, `♬`, `♩`) for operation feedback.
*   **Intelligent Visual Indicators:** Includes block-element progress bars (`█▓▒░`), currency symbols for security status (`$`), and logical symbols for error handling (`∆`, `∑`, `⌀`).
*   **Personalized Information Panel:** Displays user credentials for **Latiful Hassan Zihan (@alwayszihan)** with a professional, custom-bordered design.
*   **Enhanced Command Aliases:** Provides visual feedback for common commands (`ls`, `cp`, `rm`) and a custom `status` command for real-time dashboard refresh.

## Installation

1.  **Clone the repository (or download the files):**
    \`\`\`bash
    git clone https://github.com/alwayszihan/zihan-pro-termux-theme.git
    cd zihan-pro-termux-theme
    \`\`\`

2.  **Run the installation script:**
    \`\`\`bash
    chmod +x install.sh
    ./install.sh
    \`\`\`

3.  **Restart Termux:** Close and reopen Termux, or run `source ~/.bashrc` to apply the changes immediately.

### Recommended Manual Configuration

For the theme's dynamic colors to stand out, it is highly recommended to set your main Termux color scheme to a dark, high-contrast base in the Termux settings:

*   **Background:** A very dark gray or black (e.g., `#1A1A1A` or `#000000`).
*   **Foreground:** A neutral light gray or white (e.g., `#CCCCCC` or `#FFFFFF`).

The theme script will handle the dynamic color rotation for the prompt and dashboard elements, which will override the default foreground/background colors for its output.

## Usage

The theme is automatically loaded on every new session.

*   **Dynamic Colors:** Simply open a new session to see a new color scheme.
*   **Real-time Status:** Use the custom alias `status` to clear the screen and display the system dashboard again.
    \`\`\`bash
    status
    \`\`\`
*   **Color Demo:** To see all six color schemes in action, run the demonstration script:
    \`\`\`bash
    ./color-demo.sh
    \`\`\`

## Uninstallation

To remove the theme and revert your `~/.bashrc` file:

\`\`\`bash
chmod +x uninstall.sh
./uninstall.sh
\`\`\`

## File Structure

\`\`\`
zihan-pro-termux-theme/
│
├── README.md           # This documentation file.
├── install.sh          # Script to install the theme and configure ~/.bashrc.
├── uninstall.sh        # Script to remove the theme and revert changes.
├── color-demo.sh       # Script to demonstrate all six color schemes.
└── zihan-pro.sh        # The core theme script containing the logic, dashboard, and prompt.
\`\`\`
