#!/bin/sh

# dunst
systemctl restart --user dunst

# bar
killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done
$HOME/dots/scripts/polybar/polybar.sh

# wallpaper
feh --bg-fill $HOME/data/Seafile/images/wallpaper/wallpaper.png

# for some reason xmodmap and xset settings reset sometimes
source $HOME/.profile

# notification
notify-send -i /usr/share/icons/Papirus/48x48/status/state_running.svg "i3wm" "Reloaded desktop"
