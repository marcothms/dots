killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    echo $m
    MON=$m polybar --reload bar &
  done
else
  polybar --reload bar &
fi
