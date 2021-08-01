#!/bin/sh

# desktop or laptop?
if [ `hostname` == "nazarick" ];then
    xrandr --output DP-2 --mode 3440x1440 --rate 99.98 --primary
    xrandr --output DP-1 --off
    feh --bg-fill $HOME/data/nextcloud/wallpaper/wallpaper219.png
else
    feh --bg-scale $HOME/data/nextcloud/wallpaper/wallpaper169.png
    #asetroot $HOME/data/nextcloud/wallpaper/animated/current/ -t 100 &
fi
