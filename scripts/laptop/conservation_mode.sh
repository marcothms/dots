#!/bin/bash
status=`cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`

if [[ $status == 1 ]]; then
	notify-send -i /usr/share/icons/Papirus/48x48/devices/battery.svg "Conservation Mode" "Disabling conservation mode"
	echo 0 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode >/dev/null

elif [[ $status == 0 ]]; then
	notify-send -i /usr/share/icons/Papirus/48x48/devices/battery.svg "Conservation Mode" "Enabling conservation mode"
        echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode >/dev/null
fi
