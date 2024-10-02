#!/bin/bash
if [ -z $(pidof waybar) ]; then
	waybar -c $HOME/Hypr/waybar/config -s $HOME/Hypr/waybar/style.css &
else
	pkill waybar
fi
