#!/bin/bash

date=$(date +'%A, %d. %b %R')

battery=$(cat /sys/class/power_supply/BAT1/capacity)
if [ $(cat /sys/class/power_supply/BAT1/status) = 'Discharging' ]; then
    bat_rem=" ▼ "$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep "time to empty" | cut -f14- -d ' ')
else
    bat_rem=" ⯅ "$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep "time to full" | cut -f15- -d ' ')
fi

if [ $(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode) = '1' ]; then
    conservation='on'
else
    conservation='off'
fi

wifi=$(iwgetid -r)
if [ -z $wifi ]; then
    wifi='no wifi'
fi

powermode=$(cat /sys/firmware/acpi/platform_profile)

sep='-'
echo $battery"%"$bat_rem $sep $conservation $sep $powermode $sep $wifi $sep $date
