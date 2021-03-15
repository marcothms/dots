#!/bin/sh

# set keyboard layout
setxkbmap -layout za

# start programs
fcitx -d &
nextcloud &
dunst &
picom &
nm-applet &

# adjust screens on nazarick
~/scripts/fix_screens.sh

# launch polybar
~/scripts/polybar.sh &

# wallpaper
# feh --bg-scale $HOME/data/nextcloud/Wallpaper/wallpaper.png
asetroot $HOME/data/nextcloud/wallpaper/animated/current/ -t 50 &
