if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    # only show on internal display
    if [ "$m" == "eDP-1" ]; then
      pos="right"
    fi
    MON=$m TRAYPOS=$pos polybar --reload bar &
    pos=
  done
else
  polybar --reload bar &
fi
