killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for mon in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$mon polybar --reload workspaces &
      MONITOR=$mon polybar --reload music &
      MONITOR=$mon polybar --reload tray &
    if [ $mon = "eDP"  ]; then
      MONITOR=$mon polybar --reload info_laptop &
    else
      MONITOR=$mon polybar --reload info &
    fi
  done
else
    echo "No Bars loaded."
fi
