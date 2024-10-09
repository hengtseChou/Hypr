#!/bin/bash
#  _   _           _       _
# | | | |_ __   __| | __ _| |_ ___  ___
# | | | | '_ \ / _` |/ _` | __/ _ \/ __|
# | |_| | |_) | (_| | (_| | ||  __/\__ \
#  \___/| .__/ \__,_|\__,_|\__\___||___/
#       |_|
#

updates_pacman=$(checkupdates | wc -l)
updates_aur=$(paru -Qua | grep -v "\[ignored\]" | wc -l)
updates=$((updates_pacman + updates_aur))
printf '{"text": "%s", "alt": "%s", "tooltip": "%s Updates"}' "$updates" "$updates" "$updates"
