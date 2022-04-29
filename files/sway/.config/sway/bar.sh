#!/bin/bash

date=$(date +'%A, %d.%m %R')
battery=$(cat /sys/class/power_supply/BAT1/capacity)

echo $battery"% <> "$date" <>"

