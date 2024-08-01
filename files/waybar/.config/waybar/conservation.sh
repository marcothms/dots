location='/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'
val=$(cat $location)

if [ "X$val" == "X1" ]; then
  echo "(On)"
else
  echo "(Off)"
fi
