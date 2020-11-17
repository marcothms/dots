#!/bin/sh

if [ `hostname` = "nazarick" ]; then
    xrandr --output DP-3 --right-of DP-1 --primary
fi
