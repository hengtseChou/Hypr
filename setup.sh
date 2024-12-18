#!/bin/bash
if ! command -v paru 2>&1 >/dev/null; then
  echo ":: Error: paru is not installed. Exiting."
  exit 1
fi

apps=(
  alacritty
  fastfetch
  fontconfig
  greetd-tuigreet
  hyprland
  hyprlock
  hyprpaper
  rofi-wayland
  swaync
  waybar
  wlogout
  zsh
)

utils=(
  brightnessctl
  cliphist
  eza
  fd
  figlet
  fzf
  gum
  hypridle
  hyprshot
  imagemagick
  networkmanager
  pamixer
  polkit-gnome
  power-profiles-daemon
  pwvucontrol
  starship
  udiskie
  xdg-desktop-portal-hyprland
  wttrbar
  zoxide
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

echo -e "\n----- Hyprland configuration script -----\n"
echo ":: Installing apps..."
paru -S --needed "${apps[@]}"
echo -e ":: Done. Proceeding to the next step...\n"

echo ":: Installing utilies..."
paru -S --needed "${utils[@]}"
echo -e ":: Done. Proceeding to the next step...\n"

echo ":: Installing fonts..."
paru -S --needed "${fonts[@]}"
echo -e ":: Done. Proceeding to the next step...\n"

read -p ":: Skip theming? (y/N): " skip_theming
skip_theming=${skip_theming:-N}
if [[ "$skip_theming" =~ ^([yY])$ ]]; then
  echo ":: Skipping theme installation"
  echo -e ":: Proceeding to the next step...\n"
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
  echo -e ":: Done. Proceeding to the next step...\n"
fi

if [[ "$SHELL" != "/bin/zsh" ]]; then
  echo ":: Setting up default shell..."
  chsh -s /bin/zsh
  echo -e ":: Done. Proceeding to the next step...\n"
else
  echo ":: Setting up default shell: Already set to zsh"
  echo -e ":: Proceeding to the next step...\n"
fi

echo ":: Setting up configuration files..."
echo "" && sleep 3
sudo systemctl enable greetd.service
sudo cp ./greetd/config.toml /etc/greetd/config.toml
echo ":: Copied $PWD/greetd/config.toml to /etc/greetd/config.toml"
echo "" && sleep 0.5

./symlink.sh $PWD/alacritty --to-config
echo "" && sleep 0.5
./symlink.sh $PWD/hypr --to-config
echo "" && sleep 0.5
./symlink.sh $PWD/starship/starship.toml --to-config
echo "" && sleep 0.5
./symlink.sh $PWD/swaync --to-config
echo "" && sleep 0.5
./symlink.sh $PWD/zsh --to-config
echo "" && sleep 0.5
./symlink.sh $PWD/zsh/.zshrc --to-home
echo "" && sleep 0.5

echo ":: Setting up fontconfig..."
fc-cache -f
gsettings set org.gnome.desktop.interface font-name 'Ubuntu 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 12'

# sed -i 's|\$dotfiles = ".*"|$dotfiles = "'"$PWD"'"|' ./hypr/hyprland.conf
# sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/hyprlock.conf
# sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/hyprpaper.conf
# sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/scripts/power-profiles.sh
# sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/scripts/screenshot.sh
# sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./hypr/scripts/toggle-waybar.sh
# sed -i 's|\~/Hypr|'"$PWD"'|' ./rofi/config.rasi
# sed -i 's|\~/Hypr|'"$PWD"'|' ./rofi/config-cliphist.rasi
# sed -i 's|\~/Hypr|'"$PWD"'|' ./rofi/config-power.rasi
# sed -i 's|\~/Hypr|'"$PWD"'|' ./rofi/config-screenshot.rasi
# sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./waybar/config
# sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./waybar/modules.jsonc
# sed -i 's|\$HOME/Hypr|'"$PWD"'|' ./wlogout/wlogout.sh
# sed -i 's|dotfiles="[^"]*"|dotfiles="'"$PWD"'"|' ./zsh/.zshrc

echo -e "\n:: Hypr configuration completed.\n"
