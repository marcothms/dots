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

# keyboard layout
setxkbmap -layout za

# start programs
fcitx -d &
nextcloud &
dunst &
#picom &
nm-applet &

# fcitx exports
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'
export WINIT_UNIX_BACKEND=x11

# path
export PATH=$PATH:$HOME/scripts:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin

# university wants me to use intellij, but dwm rightfully hates it
export _JAVA_AWT_WM_NONREPARENTING=1

# wallpaper
feh --bg-scale $HOME/data/nextcloud/wallpaper/wallpaper.png
#asetroot $HOME/data/nextcloud/wallpaper/animated/current/ -t 100 &

dwmblocks &
exec dwm 2> ~/.dwm.log
