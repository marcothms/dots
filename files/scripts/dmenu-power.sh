#!/bin/sh

FONT="Product Sans:pixelsize=15:antialias=true:rgba=rgb"
BGCOL="#000000"
FGCOL="#ffffff"
SELBGCOL="#98c379"
SELFGCOL="#000000"

COMMANDS="
poweroff\n
reboot\n
lock\n
"

command=$(echo -e $COMMANDS | \
    dmenu -fn "$FONT" -nb $BGCOL -nf $FGCOL -sb $SELBGCOL -sf $SELFGCOL)
[ "$command" = "" ] && exit 1
if [ "$command" = "lock" ]; then
    lock.sh && exit 0
else
    systemctl $command && exit 0
fi
