#!/bin/bash
#  _   _           _       _
# | | | |_ __   __| | __ _| |_ ___  ___
# | | | | '_ \ / _` |/ _` | __/ _ \/ __|
# | |_| | |_) | (_| | (_| | ||  __/\__ \
#  \___/| .__/ \__,_|\__,_|\__\___||___/
#       |_|
#
if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then
    updates_arch=0
fi

if ! updates_aur=$(paru -Qua | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))
printf '{"text": "%s", "alt": "%s", "tooltip": "%s Updates"}' "$updates" "$updates" "$updates"
