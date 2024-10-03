#!/bin/bash
#  _   _           _       _
# | | | |_ __   __| | __ _| |_ ___  ___
# | | | | '_ \ / _` |/ _` | __/ _ \/ __|
# | |_| | |_) | (_| | (_| | ||  __/\__ \
#  \___/| .__/ \__,_|\__,_|\__\___||___/
#       |_|
#

updates=$(paru -Qu | grep -v "\[ignored\]" | wc -l)
printf '{"text": "%s", "alt": "%s", "tooltip": "%s Updates"}' "$updates" "$updates" "$updates"
