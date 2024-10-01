#!/bin/bash
if [ -z $(pidof waybar) ]; then
	waybar -c $HOME/Dotfiles/waybar/config -s $HOME/Dotfiles/waybar/style.css &
else
	pkill waybar
fi
