killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for mon in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$mon polybar --reload bottom &
    if [ $mon = "eDP"  ]; then
      MONITOR=$mon polybar --reload laptop &
    else
      MONITOR=$mon polybar --reload main &
    fi
  done
else
    notify-send "No screens for polybar were found"
fi
