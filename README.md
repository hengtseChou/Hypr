
- **Window Manager •** [Hyprland](https://github.com/hyprwm/Hyprland)
- **Display Manager •** [tuigreet](https://github.com/apognu/tuigreet)
- **Launcher •** [rofi-wayland](https://github.com/lbonn/rofi)
- **Panel •** [Waybar](https://github.com/Alexays/Waybar)
- **Panel Font •** [Ubuntu Mono Nerd Font](https://archlinux.org/packages/extra/any/ttf-ubuntu-mono-nerd/) + [Noto Sans Mono CJK TC](https://archlinux.org/packages/extra/any/noto-fonts-cjk/)
- **Notification •** [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)
- **Screenshot Util •** [Hyprshot](https://github.com/Gustash/Hyprshot)
- **Clipboard Manager •** [cliphist](https://github.com/sentriz/cliphist)
- **Wallpaper Engine •** [hyprpaper](https://github.com/hyprwm/hyprpaper)
- **Lock Screen •** [hyprlock](https://github.com/hyprwm/hyprlock)
- **Logout Menu •** [wlogout](https://github.com/ArtsyMacaw/wlogout)
- **Fonts •** [Ubuntu](https://archlinux.org/packages/extra/any/ttf-ubuntu-font-family/) + [Noto Sans/Serif CJK TC](https://archlinux.org/packages/extra/any/noto-fonts-cjk/)
- **Theme •** [Colloid-gtk-theme](https://github.com/vinceliuice/Colloid-gtk-theme) (with gtk-4.0 tweaks)
- **Icons •** [Colloid-icon-theme](https://github.com/vinceliuice/Colloid-icon-theme)
- **Terminal •** [alacritty](https://github.com/alacritty/alacritty)
- **Terminal Font •** [JetBrains Mono Nerd Font](https://archlinux.org/packages/extra/any/ttf-jetbrains-mono-nerd/)
- **Shell •** [zsh](https://www.zsh.org/) + [oh-my-zsh](https://ohmyz.sh/) + [starship](https://github.com/starship/starship)

This setup is based on [ML4W Dotfiles](https://github.com/mylinuxforwork/dotfiles) and [win10-style-waybar](https://github.com/TheFrankyDoll/win10-style-waybar), with some opinionated touch.

# Screenshots

![](https://i.imgur.com/PwJSEH6.png)

![](https://i.imgur.com/nSPtbNT.png)

![](https://i.imgur.com/3M0tmSa.png)

# Installation

```
cd Hypr
./install.sh
```

The script will install packages required for this setup and symlink to the corresponding directories. Some apps as seen in alias from `.zshrc` or keybindings from `hypr/hyprland.conf` may consider optional and therefore not be included.
