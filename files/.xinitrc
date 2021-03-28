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

# start some nice programs
# TODO: is this needed?
#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#        [ -x "$f" ] && . "$f"
#    done
#    unset f
#fi

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
