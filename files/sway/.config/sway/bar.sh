#!/bin/bash

date=$(date +'%A, %d. %b %I:%M %p')

battery=$(cat /sys/class/power_supply/BAT1/capacity)

if [ $(cat /sys/class/power_supply/BAT1/status) = 'Discharging' ]; then
    bat_rem="▼"

    if [ ${battery} -lt 6 ]; then
        notify-send -i battery "Battery" "Critical Battery State!\n ${battery}% remaining!"
    fi
else
    bat_rem="⯅"
fi

if [ $(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode) = '1' ]; then
    conservation='capped'
else
    conservation='uncapped'
fi

wifi=$(iwgetid -r)
if [ -z "$wifi" ]; then
    wifi='no wifi'
fi

powermode=$(cat /sys/firmware/acpi/platform_profile)

cpu_util=$(cat /proc/loadavg | awk '{print $1, $2, $3}')

if [ $(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}') = 'no' ]; then
    audio=" $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"
else
    audio="婢 muted"
fi

light=$(light -G | awk '{print int($1+0.5)'})"%"

sep=" "
echo "${sep}  ${light} ${sep} ${audio} ${sep}  ${wifi} ${sep}  ${powermode}: ${cpu_util} ${sep}  ${conservation} ${sep}  ${battery}% ${bat_rem} ${sep}  ${date}"

