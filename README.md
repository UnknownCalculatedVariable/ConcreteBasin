# ConcreteBasin

![Friday 09-05-25 07:40:18.png](screenshots/Friday%2009-05-25%2007:40:18.png)
![Friday 09-05-25 07:40:28.png](screenshots/Friday%2009-05-25%2007:40:28.png)
![Friday 09-05-25 07:40:39.png](screenshots/Friday%2009-05-25%2007:40:39.png)
![Friday 09-05-25 07:40:53.png](screenshots/Friday%2009-05-25%2007:40:53.png)

## About

ConcreteBasin is a personalized desktop environment configuration for Linux, focusing on a visually appealing and highly functional setup. It leverages a combination of tools to create a cohesive and efficient workflow, with a strong emphasis on keyboard-driven interaction and dynamic theming.

## Features

-   **Dynamic Theming:** Utilizes `pywal` to generate color schemes from your wallpaper, applying them to various components like the terminal, status bar, and application launcher.
-   **Custom Widgets:** Employs `eww` (Elkowar's Wacky Widgets) to create a custom status bar and desktop widgets, providing at-a-glance information about your system.
-   **Application Launcher:** Uses `rofi` for a fast and customizable application launcher, script runner, and menu system.
-   **Terminal:** Configured with `alacritty`, a fast, GPU-accelerated terminal emulator.
-   **Notifications:** Styled and managed by `mako`, a lightweight notification daemon.
-   **Scripting:** A collection of shell scripts to automate tasks, manage system settings, and integrate the various components.

## Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/ConcreteBasin.git
    ```
2.  **Install the dependencies:**
    -   `alacritty`
    -   `eww`
    -   `rofi`
    -   `mako`
    -   `pywal`
    -   `sway` or `i3`
    -   `nerd-fonts` (specifically JetBrainsMono Nerd Font)
3.  **Copy the configuration files:**
    ```bash
    cp -r ConcreteBasin/config/* ~/.config/
    ```
4.  **Copy the scripts:**
    ```bash
    cp -r ConcreteBasin/scripts/* ~/.local/bin/
    ```
5.  **Set a wallpaper:**
    Use the `wpsel` script to select a wallpaper, which will also trigger `pywal` to set the color scheme.
    ```bash
    wpsel
    ```
6.  **Reload your window manager:**
    Restart `sway` or `i3` to apply the changes.

## Usage

-   **Application Launcher:** Press `Super + D` to open the `rofi` application launcher.
-   **System Menu:** Press `Super + X` to open a system menu with options for power, updates, and backups.
-   **Wallpaper Selector:** Run `wpsel` to choose a new wallpaper and update the system theme.
-   **Notes Manager:** Run `notes-manager` to browse and open notes in your Obsidian vault.
--   **E-Book Manager:** Run `e-book-manager` to browse and open e-books.

## Configuration

-   **Alacritty:** `~/.config/alacritty/alacritty.toml`
-   **Eww:** `~/.config/eww/`
-   **Rofi:** `~/.config/rofi/`
-   **Mako:** `~/.config/mako/`

## Scripts

The `scripts` directory contains various utility scripts:

-   `bckp`: Backs up the configuration files to the repository.
-   `battery-warning`: Displays a warning when the battery is low.
-   `e-book-manager`: A `rofi`-based e-book browser.
-   `mk_eww`: A helper script to create new `eww` widgets.
-   `notes-manager`: A `rofi`-based note-taking helper for Obsidian.
-   `sink_sel.sh`: A `rofi`-based audio output selector.
-   `wal`: A wrapper for `pywal`.
-   `wpsel`: A `rofi`-based wallpaper selector.

