#!/bin/sh

if [ -f "/sys/class/power_supply/BAT0/capacity" ];then
    echo $(cat /sys/class/power_supply/BAT0/capacity)%
else
    echo 100%
fi
