connected=$(xrandr --query | grep "DP-3" | grep " connected" | cut -d" " -f1)

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    # workaround to always show tray, when external mon is connected
    if [ "$m" == "eDP-1" ] && [ "$connected" == "DP-3" ]; then
      pos="none"
    fi
    MON=$m TRAYPOS=$pos polybar --reload bar &
    pos=
  done
else
  polybar --reload bar &
fi
