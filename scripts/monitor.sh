#!/bin/bash

mon=$1

if [ ${mon} == "dual" ]; then
    notify-send -i /usr/share/icons/Papirus/48x48/devices/computer.svg "Screen update" "Switching to dual monitor..."
    sleep 2
    # set layout for dual monitor at home
    xrandr --output eDP-1 --mode 2880x1800 --pos 4816x1474 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --primary --mode 3440x1440 --pos 0x0 --rotate normal --output DP-4 --off

    # built in screen has higher dpi, so scale the bigger one
    xrandr --output DP-3 --scale 1.4
elif [ ${mon} == "single" ]; then
    notify-send -i /usr/share/icons/Papirus/48x48/devices/computer.svg "Screen update" "Switching to single monitor..."
    sleep 2
    # set layout for built in display
    xrandr --output eDP-1 --mode 2880x1800 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off
fi

# reload wallpaper etc
$HOME/dots/scripts/reload_desktop.sh
