#!/bin/bash

# options to be displayed
option0=" Lock"
option1=" Logout"
option2=" Reboot"
option3=" Shutdown"

# options passed into variable
options="$option0\n$option1\n$option2\n$option3"

chosen="$(echo -e "$options" | rofi -lines 8 -dmenu -p "")"

case $chosen in
    $option0)
        ~/scripts/lock-laptop;;
    $option1)
        i3-msg exit;;
    $option2)
        systemctl reboot;;
    $option3)
        systemctl poweroff;;
esac
