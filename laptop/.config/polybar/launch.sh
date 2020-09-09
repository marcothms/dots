killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for mon in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ "$1" = "laptop" ]; then
      MONITOR=$mon polybar --reload main &
    fi
  done
else
    echo "No Bars loaded."
fi
