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
  udiskie
  wob
  xdg-desktop-portal-hyprland
  wttrbar
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
  zsh
)

fonts=(
  noto-fonts-cjk
  noto-fonts-emoji
  ttf-jetbrains-mono-nerd
  ttf-ubuntu-font-family
  ttf-ubuntu-mono-nerd
)

theming=(
  adwaita-cursors
  gnome-themes-extra
  gtk3
  gtk4
  gtk-engine-murrine
  sassc
)

clear
echo ":: Installing apps..."
paru -S --needed "${apps[@]}"
echo ":: Done. Proceeding to the next step..."
time sleep 3

clear
echo ":: Installing utilies..."
paru -S --needed "${utils[@]}"
echo ":: Done. Proceeding to the next step..."
time sleep 3

clear
echo ":: Installing fonts..."
paru -S --needed "${fonts[@]}"
echo ":: Done. Proceeding to the next step..."
time sleep 3

clear
read -p ":: Skip theming? (y/N): " skip_theming
skip_theming=${skip_theming:-N}
if [[ "$skip_theming" =~ ^([yY])$ ]]; then
  echo ":: Skipping theme installation."
  echo ":: Proceeding to the next step..."
  time sleep 3
else
  echo ":: Installing theme..."
  paru -S --needed "${theming[@]}"
  git clone https://github.com/vinceliuice/Colloid-gtk-theme.git
  cd Colloid-gtk-theme
  ./install.sh
  cd ..
  git clone https://github.com/vinceliuice/Colloid-icon-theme.git
  cd Colloid-icon-theme
  ./install.sh
  cd ..
  gsettings set org.gnome.desktop.interface gtk-theme 'Colloid'
  gsettings set org.gnome.desktop.interface icon-theme 'Colloid'
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  gsettings set org.gnome.desktop.interface cursor-size 24
  gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
  echo ":: Done. Proceeding to the next step..."
  time sleep 3
fi

clear
chsh -s /bin/zsh

sudo systemctl enable greetd.service
sudo cp ./greetd/config.toml /etc/greetd/config.toml

source ./symlink.sh
symlink $PWD/alacritty --to-config
symlink $PWD/hypr --to-config
symlink $PWD/starship/starship.toml --to-config
symlink $PWD/swaync --to-config
symlink $PWD/zsh --to-config
symlink $PWD/zsh/.zshrc --to-home

fc-cache -f
gsettings set org.gnome.desktop.interface font-name 'Ubuntu 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 12'

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
sed -i 's|dotfiles="[^"]*"|dotfiles="'"$PWD"'"|' ./zsh/.zshrc

echo ":: Hypr configuration completed. "
echo ":: Please reboot your system."
