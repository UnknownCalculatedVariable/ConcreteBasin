# Eww Widgets Configuration

This is a configuration for Eww (Elkowar's Wacky Widgets), providing a vertical bar with system information and a desktop clock.

## Features

- **Vertical Bar:** A bar on the left side of the screen with the following widgets:
    - **Workspaces:** Shows the current workspaces and their status.
    - **Notes:** Buttons to launch Obsidian and Vim.
    - **Power Menu:** Buttons for shutdown, reboot, suspend, and logout.
    - **Volume Control:** A slider to control the system volume.
    - **Brightness Control:** A slider to control the screen brightness.
    - **Battery Indicator:** Shows the current battery percentage.
    - **Utilities:** Buttons for a color picker, screenshot tool, and night mode.
    - **Clock:** A vertical clock.
- **Desktop Clock:** A separate clock widget on the desktop.

## File Structure

```
.
├── eww.css
├── eww.yuck
├── bar
│   ├── css
│   │   ├── battery.css
│   │   ├── globals.css
│   │   ├── notes.css
│   │   ├── power.css
│   │   ├── utils.css
│   │   ├── vertical-clock.css
│   │   ├── volum.css
│   │   └── workspaces.css
│   ├── includes.yuck
│   ├── scripts
│   │   ├── battery.sh
│   │   ├── battery_status.sh
│   │   ├── cp.sh
│   │   ├── cpuF.sh
│   │   ├── currentB.sh
│   │   ├── currentV.sh
│   │   ├── gamastat.sh
│   │   ├── gams.sh
│   │   ├── ss.sh
│   │   └── workspaces.sh
│   ├── vars.yuck
│   ├── widgets.yuck
│   └── windows.yuck
├── clock
│   ├── css
│   │   └── clock.css
│   ├── includes.yuck
│   ├── listens.yuck
│   ├── scripts
│   │   ├── hour.sh
│   │   ├── minute.sh
│   │   └── second.sh
│   ├── widgets.yuck
│   └── windows.yuck
└── Icons
    ├── ob.png
    └── Obsidian.png
```

### `eww.yuck`

The main configuration file. It includes the `includes.yuck` files from the `bar` and `clock` directories.

### `eww.css`

The main stylesheet. It imports all the other CSS files.

### `bar/`

This directory contains all the files for the vertical bar.

- **`css/`**: Contains the CSS files for the bar widgets.
- **`includes.yuck`**: Includes the other `.yuck` files for the bar.
- **`scripts/`**: Contains scripts that provide information to the bar widgets.
- **`vars.yuck`**: Defines variables and listens for system events.
- **`widgets.yuck`**: Defines the widgets for the bar.
- **`windows.yuck`**: Defines the window for the bar.

### `clock/`

This directory contains all the files for the desktop clock.

- **`css/`**: Contains the CSS file for the clock.
- **`includes.yuck`**: Includes the other `.yuck` files for the clock.
- **`listens.yuck`**: Listens for the current time.
- **`scripts/`**: Contains scripts that provide the current time.
- **`widgets.yuck`**: Defines the widget for the clock.
- **`windows.yuck`**: Defines the window for the clock.

### `Icons/`

Contains icons used in the widgets.

## Usage

To use this configuration, you need to have `eww` installed. Then, you can run the following command in this directory:

```
eww open-many side clock
```

This will open the vertical bar and the desktop clock.
