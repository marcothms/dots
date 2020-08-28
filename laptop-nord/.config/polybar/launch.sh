killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for mon in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ "$1" = "laptop" ]; then
      MONITOR=$mon polybar --reload workspaces &
      MONITOR=$mon polybar --reload music &
      MONITOR=$mon polybar --reload status &
      MONITOR=$mon polybar --reload tray &
    fi
    if [ "$1" = "all" ]; then
      MONITOR=$mon polybar --reload all &
    fi
  done
else
    echo "No Bars loaded."
fi
