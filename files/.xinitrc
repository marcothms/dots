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

# gtk and qt theme - requires https://github.com/hargonix/Pop-gruvbox/ in ~/.themes
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_THEME=Pop-gruvbox:light
export QT_QPA_PLATFORMTHEME="gtk2"

# start programs
fcitx5 -d &
nextcloud &
nm-applet &
dunst &

# fcitx exports
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'
export WINIT_UNIX_BACKEND=x11

# university wants me to use intellij, but dwm rightfully hates it
export _JAVA_AWT_WM_NONREPARENTING=1

# desktop or laptop?
if [ `hostname` == "nazarick" ];then
    xrandr --output DP-2 --mode 3440x1440 --rate 99.98 --primary
    xrandr --output DP-1 --off
    feh --bg-fill $HOME/data/nextcloud/wallpaper/wallpaper219.png
else
    feh --bg-scale $HOME/data/nextcloud/wallpaper/wallpaper169.png
    #asetroot $HOME/data/nextcloud/wallpaper/animated/current/ -t 100 &
fi
