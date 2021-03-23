#!/usr/bin/env bash

# set keyboard layout
setxkbmap -layout za

# start programs
fcitx -d &
nextcloud &
dunst &
picom &
nm-applet &

# adjust screens on nazarick
$HOME/scripts/fix_screens.sh

# launch polybar
$HOME/scripts/polybar.sh &

# wallpaper
feh --bg-scale $HOME/data/nextcloud/wallpaper/wallpaper.png
#asetroot $HOME/data/nextcloud/wallpaper/animated/current/ -t 50 &
