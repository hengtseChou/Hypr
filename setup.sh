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
	power-profiles-daemon
	zoxide
	hypridle
	xdg-desktop-portal-hyprland
	waybar-wttrbar
)

apps=(
	alacritty
	fastfetch
	fontconfig
	greetd-tuigreet
	hyprland
	hyprlock
	hyprpaper
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

echo ":: installing apps..."
paru -S --needed "${apps[@]}"
echo ":: installing utilies..."
paru -S --needed "${utils[@]}"
echo ":: installing theme..."
paru -S --needed "${theming[@]}"
echo ":: installing fonts..."
paru -S --needed "${fonts[@]}"

sudo systemctl enable greetd.service
sudo cp ./greetd/config.toml /etc/greetd/config.toml

source ./symlink.sh
symlink $PWD/alacritty --to-config
symlink $PWD/fontconfig --to-config
symlink $PWD/hypr --to-config
symlink $PWD/rofi --to-config
symlink $PWD/starship/starship.toml --to-config
symlink $PWD/swaync --to-config
symlink $PWD/waybar --to-config
symlink $PWD/wlogout --to-config

fc-cache -f

gsettings set org.gnome.desktop.interface gtk-theme 'Colloid-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Colloid-Dark'
gsettings set org.gnome.desktop.interface font-name 'Ubuntu 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 12'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-size 24
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
mkdir -p ~/.config/gtk-4.0/
ln -sf /usr/share/themes/Colloid-Grey-Dark/gtk-4.0/{assets,gtk.css} ~/.config/gtk-4.0

sed -i 's|\$dotfiles = ".*"|$dotfiles = "'"$PWD"'"|' ./hypr/hyprland.conf
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/hyprlock.conf
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/hyprpaper.conf
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/scripts/power-profiles.sh
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/scripts/screenshot.sh
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/scripts/toggle-waybar.sh
sed -i 's|\~/Hypr|'"$PWD"'|' ./rofi/config.rasi
sed -i 's|\~/Hypr|'"$PWD"'|' ./rofi/config-cliphist.rasi
sed -i 's|\~/Hypr|'"$PWD"'|' ./rofi/config-power.rasi
sed -i 's|\~/Hypr|'"$PWD"'|' ./rofi/config-screenshot.rasi
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./waybar/config
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./waybar/modules.jsonc
sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./wlogout/wlogout.sh
sed -i 's|dotfiles="[^"]*"|dotfiles="'"$PWD"'"|' ./.zshrc
