#!/bin/sh

SINK=$(pactl list short sinks | grep -n RUNNING | cut -d":"  -f1)
if [ "$SINK" = "" ]; then
  SINK=1
fi
NOW=$( pactl list sinks | grep '^[[:space:]]Volume:' | head -n $SINK | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )
MUTE=$(pactl list sinks | grep '^[[:space:]]Mute:'| head -n $SINK | tail -n 1 | awk -F ":" '{print $2}'| xargs)

if [ "$MUTE" = "yes" ]; then
  echo "$NOW%"
else
  echo "$NOW%"
fi

case $BLOCK_BUTTON in
          1) setsid -f st -c stpulse -n stpulse -e ncpamixer ;;
esac
