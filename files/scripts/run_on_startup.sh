#!/bin/sh

# set keyboard layout
setxkbmap -layout za

# start programs
fcitx -d &
nextcloud &
dunst &
picom &
nm-applet &

# wallpaper
feh --bg-scale $HOME/data/nextcloud/Wallpaper/wallpaper.png

# adjust screens on nazarick
~/scripts/fix_screens.sh

# launch polybar
~/scripts/polybar.sh &
