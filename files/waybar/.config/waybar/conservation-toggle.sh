location='/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'
val=$(cat $location)

if [ "X$val" == "X1" ]; then
  echo 0 | sudo tee $location
  notify-send "Battery" "Disabled conservation mode" -i battery
else
  echo 1 | sudo tee $location
  notify-send "Battery" "Enabled conservation mode" -i battery
fi
