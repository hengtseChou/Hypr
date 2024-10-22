#!/bin/bash
if ! command -v paru 2>&1 >/dev/null; then
	echo ":: Error: paru is not installed. Exiting."
	exit 1
fi

utils=(
	bat
	brightnessctl
	cliphist
	eza
	fd
	figlet
	fzf
	hypridle
	imagemagick
	pamixer
	polkit-gnome
	power-profiles-daemon
	tree
	wob
	xdg-desktop-portal-hyprland
	waybar-wttrbar
	zoxide
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
	pwvucontrol
	rofi-wayland
	starship
	swaync
	waybar
	wlogout
)

fonts=(
	noto-fonts-cjk
	noto-fonts-emoji
	ttf-jetbrains-mono-nerd
	ttf-ubuntu-font-family
	ttf-ubuntu-mono-nerd
)

theming=(
	colloid-gtk-theme-git
	colloid-icon-theme-git
)

echo ":: Installing apps..."
paru -S --needed "${apps[@]}"
echo ":: Installing utilies..."
paru -S --needed "${utils[@]}"
echo ":: Installing fonts..."
paru -S --needed "${fonts[@]}"

read -p ":: Skip theming? (y/N): " skip_theming
skip_theming=${skip_theming:-N}
if [[ "$skip_theming" =~ ^([nN][oO]?|[yY][eE][sS]?)$ ]]; then
	echo ":: Installing theme..."
	paru -S --needed "${theming[@]}"
	gsettings set org.gnome.desktop.interface gtk-theme 'Colloid-Dark'
	gsettings set org.gnome.desktop.interface icon-theme 'Colloid-Dark'
	gsettings set org.gnome.desktop.interface font-name 'Ubuntu 12'
	gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 12'
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	gsettings set org.gnome.desktop.interface cursor-size 24
	gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
	mkdir -p ~/.config/gtk-4.0/
	ln -sf /usr/share/themes/Colloid-Grey-Dark/gtk-4.0/{assets,gtk.css} ~/.config/gtk-4.0
else
	echo ":: Skipping theme installation."
fi

echo ":: Install oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate

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
symlink $PWD/.zshrc --to-home

fc-cache -f

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
