#!/usr/bin/env bash


dir="$HOME/.config/rofi"
rofi_command="rofi -theme $dir/powermenu.rasi"

# Options
shutdown="Shutdown"
reboot="Reboot"
lock="Lock"
suspend="Suspend"
logout="Logout"

# Confirmation
confirm_exit() {
	rofi -dmenu\
	     -i\
	     -no-fixed-num-lines\
	     -p "Are You Sure? : "\
	     -theme $dir/confirm.rasi
}

# Message
msg() {
	rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
	ans=$(confirm_exit &)
	if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
		systemctl poweroff
	elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
		exit 0
	else
		msg
        fi
        ;;
    $reboot)
	ans=$(confirm_exit &)
	if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
		systemctl reboot
	elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
		exit 0
	else
		msg
        fi
        ;;
    $lock)
	xlock -mode maze
        ;;
    $suspend)
	ans=$(confirm_exit &)
	if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
		systemctl suspend
	elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
		exit 0
        else
		msg
        fi
        ;;
    $logout)
	ans=$(confirm_exit &)
	if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
		i3-msg exit
	elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
		exit 0
        else
		msg
        fi
        ;;
esac
