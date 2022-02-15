#!/bin/bash

mon=$1

# when using a laptop, i want to easily switch screens
if [ "$(hostname)" = "itomori" ]; then
    if [ ${mon} == "external" ]; then
	notify-send -i /usr/share/icons/Papirus/48x48/status/notification-display-brightness-high.svg "Screen update" "Switching to external monitor..."
	sleep 2
	# set layout for external monitor
	$HOME/.screenlayout/external.sh

	# built in screen has higher dpi, so scale the bigger one
	xrandr --output DP-1 --scale 1.4
	xrandr --output DP-2 --scale 1.4
	xrandr --output DP-3 --scale 1.4
	xrandr --output DP-4 --scale 1.4
    elif [ ${mon} == "single" ]; then
	notify-send -i /usr/share/icons/Papirus/48x48/status/notification-display-brightness-high.svg "Screen update" "Switching to single monitor..."
	sleep 2
	# set layout for built in display
	xrandr --output eDP-1 --mode 2880x1800 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off
    fi
fi

# reload wallpaper etc
$HOME/.dots/scripts/reload_desktop.sh
