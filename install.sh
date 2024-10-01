#!/bin/bash
if ! command -v paru 2>&1 >/dev/null
then
    echo ":: error: paru is not installed. exiting."
    exit 1
fi

utils=(
	eza
	wob
	brightnessctl
	pamixer
	imagemagick
	cliphist
	polkit-gnome
)

apps=(
	alacritty
	fastfetch
	fontconfig
	hyprland
	hypridle
	hyprlock
	hyprpaper
	xdg-desktop-portal-hyprland
	hyprshot
	rofi-wayland
	starship
	swaync
	waybar
	wlogout
)

theming=(
	colloid-icon-theme-git
	colloid-gtk-theme-git
)

fonts=(
	ttf-ubuntu-font-family
	ttf-ubuntu-mono-nerd
	noto-fonts-cjk
	noto-fonts-emoji
	ttf-jetbrains-mono-nerd
)

echo ":: installing utilies..."
paru -S --needed "${utils[@]}"
echo ":: installing apps..."
paru -S --needed "${apps[@]}"
echo ":: installing theme..."
paru -S --needed "${theming[@]}"
echo ":: installing fonts..."

source ./symlink.sh

symlink $PWD/alacritty --to-config
symlink $PWD/fontconfig --to-config
symlink $PWD/gtk/gtk-3.0 --to-config
symlink $PWD/gtk/gtk-4.0 --to-config
symlink $PWD/gtk/xsettingsd --to-config
symlink $PWD/gtk/.gtkrc-2.0 --to-home
symlink $PWD/gtk/.Xresources --to-home
symlink $PWD/hypr --to-config
symlink $PWD/rofi --to-config
symlink $PWD/starship/starship.toml --to-config
symlink $PWD/swaync --to-config
symlink $PWD/waybar --to-config
symlink $PWD/wlogout --to-config

fc-cache -fv

gsettings set org.gnome.desktop.interface gtk-theme 'Colloid-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Colloid-Dark'
gsettings set org.gnome.desktop.interface font-name 'Ubuntu 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 12'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-size 24
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
ln -sf /usr/share/themes/Colloid-Grey-Dark/gtk-4.0/{assets,gtk.css} ~/.config/gtk-4.0

sed -i 's|\$dotfiles = ".*"|$dotfiles = "'"$PWD"'"|' ./hypr/hyprland.conf
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/hyprlock.conf
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/hyprpaper.conf
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./waybar/config
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./waybar/modules.jsonc
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./wlogout/wlogout.sh
sed -i 's|dotfiles="[^"]*"|dotfiles="'"$PWD"'"|' ./.zshrc
