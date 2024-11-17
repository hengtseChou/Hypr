- **Window Manager •** [Hyprland](https://github.com/hyprwm/Hyprland)
- **Display Manager •** [tuigreet](https://github.com/apognu/tuigreet)
- **Launcher •** [rofi-wayland](https://github.com/lbonn/rofi)
- **Panel •** [Waybar](https://github.com/Alexays/Waybar)
- **Panel Font •** [Ubuntu Mono Nerd Font](https://archlinux.org/packages/extra/any/ttf-ubuntu-mono-nerd/) + [Noto Sans Mono CJK TC](https://archlinux.org/packages/extra/any/noto-fonts-cjk/)
- **Notification •** [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)
- **Screenshot Util •** [Hyprshot](https://github.com/Gustash/Hyprshot)
- **Clipboard Manager •** [cliphist](https://github.com/sentriz/cliphist)
- **Wallpaper Engine •** [hyprpaper](https://github.com/hyprwm/hyprpaper)
- **Idle Daemon •** [hypridle](https://github.com/hyprwm/hypridle)
- **Lock Screen •** [hyprlock](https://github.com/hyprwm/hyprlock)
- **Logout Menu •** [wlogout](https://github.com/ArtsyMacaw/wlogout)
- **Fonts •** [Ubuntu](https://archlinux.org/packages/extra/any/ttf-ubuntu-font-family/) + [Noto Sans/Serif CJK TC](https://archlinux.org/packages/extra/any/noto-fonts-cjk/)
- **Theme •** [Colloid-gtk-theme](https://github.com/vinceliuice/Colloid-gtk-theme)
- **Icons •** [Colloid-icon-theme](https://github.com/vinceliuice/Colloid-icon-theme)
- **Terminal •** [Alacritty](https://github.com/alacritty/alacritty)
- **Terminal Font •** [JetBrains Mono Nerd Font](https://archlinux.org/packages/extra/any/ttf-jetbrains-mono-nerd/)
- **Shell •** [zsh](https://www.zsh.org/) + [zinit](https://github.com/zdharma-continuum/zinit) + [starship](https://github.com/starship/starship)

This setup is based on [ML4W Dotfiles](https://github.com/mylinuxforwork/dotfiles) and [win10-style-waybar](https://github.com/TheFrankyDoll/win10-style-waybar), with some opinionated touch.

# Screenshots

![screenshot1](https://i.imgur.com/PwJSEH6.png)

![screenshot2](https://i.imgur.com/nSPtbNT.png)

![screenshot3](https://i.imgur.com/3M0tmSa.png)

# Installation

```
git clone https://github.com/hengtseChou/Hypr.git
cd Hypr
./setup.sh
```

The script will install packages required for this setup and symlink to the corresponding directories. Some apps as seen in alias from `.zshrc` or keybindings from `hypr/hyprland.conf` may consider optional and therefore not be included.

# Keybinds

<div align="center">

| Keys                                                                                                                                 | Action                                            |
| :----------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------ |
| <kbd>Super</kbd> + <kbd>Enter</kbd>                                                                                                  | Open terminal                                     |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>Enter</kbd>                                                                                | Open launcher                                     |
| <kbd>Super</kbd> + <kbd>B</kbd>                                                                                                      | Open browser1                                     |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>B</kbd>                                                                                    | Open browser2                                     |
| <kbd>Super</kbd> + <kbd>E</kbd>                                                                                                      | Open file manager                                 |
| <kbd>Super</kbd> + <kbd>Q</kbd>                                                                                                      | Close active window                               |
| <kbd>Super</kbd> + <kbd>F</kbd>                                                                                                      | Toggle fullscreen mode                            |
| <kbd>Super</kbd> + <kbd>M</kbd>                                                                                                      | Toggle maximize mode                              |
| <kbd>Super</kbd> + <kbd>T</kbd>                                                                                                      | Toggle floating window                            |
| <kbd>Super</kbd> + <kbd>J</kbd>                                                                                                      | Toggle window split                               |
| <kbd>Super</kbd> + <kbd>P</kbd>                                                                                                      | Toggle pseudotiling                               |
| <kbd>Super</kbd> + <kbd>→</kbd><kbd>←</kbd><kbd>↑</kbd><kbd>↓</kbd> <br> <kbd>Super</kbd> + <kbd>LeftClick</kbd>                     | Move window                                       |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>→</kbd><kbd>←</kbd><kbd>↑</kbd><kbd>↓</kbd> <br> <kbd>Super</kbd> + <kbd>RightClick</kbd> | Resize window                                     |
| <kbd>Alt</kbd> + <kbd>Tab</kbd>                                                                                                      | Cycle through windows                             |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>→</kbd>                                                                                    | Switch to previous workspace (on focused monitor) |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>←</kbd>                                                                                    | Switch to next workspace (on focused monitor)     |
| <kbd>Super</kbd> + <kbd>R</kbd>                                                                                                      | Move Workspaces to focused monitor                |
| <kbd>Super</kbd> + <kbd>[0-9]</kbd>                                                                                                  | Move to workspace 1 to 10 (on focused monitor)    |
| <kbd>Super</kbd> + <kbd>End</kbd>                                                                                                    | Switch to empty workspace (on focused monitor)    |
| <kbd>Print</kbd>                                                                                                                     | Screenshot (region)                               |
| <kbd>Ctrl</kbd> + <kbd>Print</kbd>                                                                                                   | Screenshot (window)                               |
| <kbd>Shift</kbd> + <kbd>Print</kbd>                                                                                                  | Screenshot (monitor)                              |
| <kbd>Super</kbd> + <kbd>Backspace</kbd>                                                                                              | Launch logout screen                              |
| <kbd>Super</kbd> + <kbd>C</kbd>                                                                                                      | Launch clipboard manager                          |
| <kbd>Super</kbd> + <kbd>L</kbd>                                                                                                      | Launch lock screen                                |
| <kbd>Super</kbd> + <kbd>N</kbd>                                                                                                      | Toggle notifications center                       |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>W</kbd>                                                                                    | Toggle Waybar                                     |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>L</kbd>                                                                                    | Toggle Hypridle                                   |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>P</kbd>                                                                                    | Select power-profile                              |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>U</kbd>                                                                                    | Launch updater                                    |
| <kbd>XF86MonBrightnessUp</kbd>                                                                                                       | Increase brightness by 5%                         |
| <kbd>XF86MonBrightnessDown</kbd>                                                                                                     | Decrease brightness by 5%                         |
| <kbd>XF86AudioRaiseVolume</kbd>                                                                                                      | Raise volume by 5%                                |
| <kbd>XF86AudioLowerVolume</kbd>                                                                                                      | Lower volume by 5%                                |
| <kbd>XF86AudioMute</kbd>                                                                                                             | Toggle mute                                       |
| <kbd>XF86AudioPlay</kbd>                                                                                                             | Play or pause media                               |
| <kbd>XF86AudioPause</kbd>                                                                                                            | Pause media                                       |
| <kbd>XF86AudioNext</kbd>                                                                                                             | Next media track                                  |
| <kbd>XF86AudioPrev</kbd>                                                                                                             | Previous media track                              |
| <kbd>Lid Switch (on)</kbd>                                                                                                           | Turn clamshell mode on                            |
| <kbd>Lid Switch (off)</kbd>                                                                                                          | Turn clamshell mode off                           |

</div>
