#!/bin/bash

date=$(date +'%A, %d.%m %R')

battery=$(cat /sys/class/power_supply/BAT1/capacity)

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
echo $battery"% "$conservation $sep $powermode $sep $wifi $sep $date
