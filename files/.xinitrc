#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

# merge in defaults and keymaps
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# keyboard layout
setxkbmap -layout za

# start programs
fcitx -d &
nextcloud &
dunst &
picom &
nm-applet &

# wallpaper
feh --bg-scale $HOME/data/nextcloud/wallpaper/wallpaper.png
#asetroot $HOME/data/nextcloud/wallpaper/animated/current/ -t 50 &

dwmblocks &
exec dwm 2> ~/.dwm.log
