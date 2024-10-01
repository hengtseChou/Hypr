#!/bin/bash
#  ____                               _           _
# / ___|  ___ _ __ ___  ___ _ __  ___| |__   ___ | |_
# \___ \ / __| '__/ _ \/ _ \ '_ \/ __| '_ \ / _ \| __|
#  ___) | (__| | |  __/  __/ | | \__ \ | | | (_) | |_
# |____/ \___|_|  \___|\___|_| |_|___/_| |_|\___/ \__|
#
export HYPRSHOT_DIR="$HOME/Pictures/Screenshots"
NAME="Screenshot from $(date "+%Y-%m-%d %H-%M-%S").png"

option1="Selected Area"
option2="Pick Window"
option3="Pick Monitor"

options="$option1\n$option2\n$option3"

choice=$(echo -e "$options" | rofi -dmenu -replace -config $HOME/Dotfiles/rofi/config-screenshot.rasi -i -no-show-icons -l 3 -width 30 -p "Take Screenshot")

case $choice in
$option1)
    hyprshot -m region -f "$NAME"
    ;;
$option2)
    hyprshot -m window -f "$NAME"
    ;;
$option3)
    hyprshot -m output -f "$NAME"
    ;;
*)
    notify-send "Screenshot script" "No option chosen. Screenshot script exited."
    ;;
esac
