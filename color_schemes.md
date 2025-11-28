# Zihan Pro Termux Theme - Color Schemes

The "Zihan Pro" theme will feature six distinct, high-contrast color schemes that automatically rotate based on the session timestamp. Each scheme is designed to be vibrant, dynamic, and maintain excellent readability.

| Scheme Name | Primary Color (Foreground/Accent) | Secondary Color (Background/Base) | Tertiary Color (Prompt/Highlight) | Key Aesthetic |
| :--- | :--- | :--- | :--- | :--- |
| **1. Fire Red** | `#FF5555` (Bright Red) | `#1A0000` (Deep Black-Red) | `#FFD700` (Gold) | Aggressive, High-Energy, Warning |
| **2. Forest Green** | `#8AFF8A` (Neon Green) | `#001A00` (Deep Black-Green) | `#FFFFFF` (Pure White) | Organic, Secure, Growth |
| **3. Solar Yellow** | `#FFFF55` (Bright Yellow) | `#1A1A00` (Deep Black-Yellow) | `#FF5555` (Bright Red) | Warm, Alert, Intellectual |
| **4. Ocean Blue** | `#55FFFF` (Bright Cyan) | `#00001A` (Deep Black-Blue) | `#8AFF8A` (Neon Green) | Calm, Technical, Depth |
| **5. Sunset Purple** | `#FF55FF` (Bright Magenta) | `#1A001A` (Deep Black-Purple) | `#FFFF55` (Bright Yellow) | Sophisticated, Mystical, Twilight |
| **6. Electric Cyan** | `#55FF55` (Bright Green) | `#001A1A` (Deep Black-Cyan) | `#FF55FF` (Bright Magenta) | Futuristic, Electric, Dynamic |

## Symbolic Elements Design

The theme will use a combination of geometric, mathematical, and symbolic characters to create a sophisticated and functional aesthetic.

### 1. Geometric Launch Sequence (ASCII Art)

A geometric pattern using box-drawing characters will be displayed on launch. It will be color-coded based on the active scheme.

**Characters:** `╔`, `═`, `╗`, `║`, `╚`, `╝`, `█`, `▓`, `▒`, `░`

### 2. Prompt System (`PS1`)

The prompt will combine arrows and mathematical notation for a clean, elegant, and functional look.

**Structure:** `[USER@HOST] ∴ [CURRENT_DIR] ⟫`
**Symbols:**
*   **∴ (Therefore):** Separator for context, implying a logical flow.
*   **⟫ (Right Double Angle Quotation Mark):** The final prompt indicator, replacing the standard `$` or `#`.

### 3. Status Dashboard (System Monitoring)

The dashboard will use chess and musical symbols for a unique, elegant display of system status.

| System Metric | Symbol | Color-Coded Status |
| :--- | :--- | :--- |
| **User/Session Status** | `♔` (White King) | Green (Active), Yellow (Idle), Red (Error) |
| **CPU Load** | `♖` (White Rook) | Block-element progress bar (e.g., `█▒░`) |
| **Memory Usage** | `♗` (White Bishop) | Percentage with color-coded warning (Green/Yellow/Red) |
| **Storage Warning** | Astrological Symbols (`♄`, `♅`, `♆`) | `♄` (Saturn) for Low Storage, `♅` (Uranus) for Critical |
| **Operation Feedback** | Musical Symbols (`♪`, `♬`, `♩`) | `♬` (Success), `♩` (In Progress), `♪` (Notification) |

### 4. Intelligent Visual Indicators

| Indicator | Symbol | Purpose |
| :--- | :--- | :--- |
| **Progress Bar** | Block Elements (`█`, `▓`, `▒`, `░`) | Visual representation of long-running task progress. |
| **Security Status** | Currency Symbols (`$`, `€`, `¥`) | `$`: Secure, `€`: Elevated Privileges, `¥`: Restricted/Warning |
| **Error Handling** | Logical Symbols (`∆`, `∑`, `⌀`) | `∆` (Delta): Change/Modification, `∑` (Summation): Total Count, `⌀` (Diameter): Null/Empty/No-Op |
| **Personalized Panel** | `Latiful Hassan Zihan (@alwayszihan)` | Displayed with a unique, custom-colored border. |

The theme script will use `tput` and ANSI escape codes to apply these colors and symbols dynamically. The color rotation will be based on the current minute modulo 6 (`$(date +%M) % 6`) to ensure a fresh scheme on every launch.
