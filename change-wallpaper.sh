#!/bin/bash
set -e

# Check if no arguments are provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 <file_path>"
  exit 1
fi

file_path="$1"
filename=$(basename -- "$file_path")
extension="${filename##*.}"

# Check if the file exists
if [ ! -e "$file_path" ]; then
  echo "Error: file '$file_path' does not exist"
  exit 1
fi

# Check if the file format is supported
supported_formats=("jpeg" "png" "gif" "pnm" "tga" "tiff" "webp" "bmp" "farbfeld" "jpg")

if [[ ! " ${supported_formats[@]} " =~ " $extension " ]]; then
  echo "Error: file format '$extension' is not supported"
  exit 1
fi

hypr="$HOME/Hypr/hypr"
wallpaper_dir="$HOME/Hypr/wallpapers"
current_wallpaper="$wallpaper_dir/current_wallpaper.$extension"

# remove old wallpaper
rm "$wallpaper_dir/current_wallpaper."*
cp -f "$file_path" "$wallpaper_dir/$filename"
cp -f "$wallpaper_dir/$filename" "$current_wallpaper"
echo ":: Copied $PWD/$file_path to $wallpaper_dir."
echo ":: Creating blurred wallpaper using current wallpaper..."
magick "$current_wallpaper" -resize 75% "$wallpaper_dir/blurred_wallpaper.png"
magick "$current_wallpaper" -blur 50x30 "$wallpaper_dir/blurred_wallpaper.png"
echo ":: Setting up hyprpaper config..."
killall hyprpaper
wal_tpl=$(cat $hypr/hyprpaper.tpl)
output=${wal_tpl//WALLPAPER/$current_wallpaper}
echo "$output" >$hypr/hyprpaper.conf
hyprpaper &>/dev/null &
disown
echo ":: Done."
