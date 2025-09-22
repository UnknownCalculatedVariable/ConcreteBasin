# Main Bar + Screenshot Menu

## File Structure:
```
├── bar
│   ├── css
│   │   ├── bar.css
│   │   ├── battery-indicator.css
│   │   ├── globals.css
│   │   ├── _includes.css
│   │   ├── power-menu.css
│   │   ├── screenshot-selector.css
│   │   ├── utility-menu.css
│   │   ├── vertical-clock.css
│   │   ├── wifi-indicator.css
│   │   └── workspaces.css
│   ├── _includes.yuck
│   ├── scripts
│   │   ├── do-screenshot-full.sh
│   │   ├── do-screenshot-section.sh
│   │   ├── get-battery-icon.sh
│   │   ├── get-battery-percent.sh
│   │   ├── get-hour.sh
│   │   ├── get-minute.sh
│   │   ├── get-wifi-icon.sh
│   │   ├── get-workspaces.sh
│   │   ├── toggle-gammastep.sh
│   │   └── toggle-wifi.sh
│   ├── vars
│   │   ├── deflisten
│   │   │   ├── battery-icon.yuck
│   │   │   ├── battery-percent.yuck
│   │   │   ├── hour.yuck
│   │   │   ├── _includes.yuck
│   │   │   ├── minute.yuck
│   │   │   ├── wifi-icon.yuck
│   │   │   └── workspaces.yuck
│   │   ├── defpoll
│   │   │   ├── date.yuck
│   │   │   └── _includes.yuck
│   │   ├── defvar
│   │   │   ├── _includes.yuck
│   │   │   ├── power-menu-revealer.yuck
│   │   │   └── utility-menu-revealer.yuck
│   │   └── _includes.yuck
│   ├── widgets
│   │   ├── battery-indicator.yuck
│   │   ├── _includes.yuck
│   │   ├── layout
│   │   │   ├── bar.yuck
│   │   │   ├── bottom.yuck
│   │   │   └── top.yuck
│   │   ├── power-menu.yuck
│   │   ├── screenshot-selector.yuck
│   │   ├── utility-menu.yuck
│   │   ├── vertical-clock.yuck
│   │   ├── wifi-indicator.yuck
│   │   └── workspaces.yuck
│   └── windows
│       ├── bar.yuck
│       ├── _includes.yuck
│       └── screenshot.yuck
├── desktop
│   ├── css
│   │   ├── album.css
│   │   ├── clock.css
│   │   ├── _includes.css
│   │   └── picture.css
│   ├── _includes.yuck
│   ├── scripts
│   │   ├── get-album-cmus.sh
│   │   ├── get-album.sh
│   │   ├── get-album-spotify.sh
│   │   ├── music
│   │   │   ├── get-album-top.sh
│   │   │   ├── get-cmus-progress.sh
│   │   │   ├── get-play-icon.sh
│   │   │   └── toggle-player.sh
│   │   └── README.md
│   ├── vars
│   │   ├── album.yuck
│   │   ├── _includes.yuck
│   │   ├── music-album.yuck
│   │   ├── music-icon.yuck
│   │   └── music-progress.yuck
│   ├── widgets
│   │   ├── album.yuck
│   │   ├── _includes.yuck
│   │   ├── picture-progress.yuck
│   │   └── picture.yuck
│   └── windows
│       ├── album.yuck
│       ├── _includes.yuck
│       ├── music-progress.yuck
│       └── music.yuck
├── eww.css
└── eww.yuck
```
