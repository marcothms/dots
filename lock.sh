# requires swaylock-effects

FG="5c6a72"
RED="f85552"
BLUE="3a94c5"
YELLOW="dfa000"
GREEN="8da101"

swaylock \
	-F \
	--image /tmp/lock.png \
	--indicator-idle-visible \
	--clock --timestr "%I:%M" --datestr "" \
	--font "SFMono Nerd Font" \
	--indicator-radius 80 \
	--fade-in 0.2 \
	--line-uses-inside \
	--line-uses-ring \
	--key-hl-color "606e01" \
	--bs-hl-color $RED \
	--ring-color $GREEN \
	--separator-color $GREEN \
	--ring-clear-color $YELLOW \
	--text-clear-color "00000000" \
	--ring-ver-color $BLUE \
	--text-ver-color "00000000" \
	--ring-wrong-color $RED \
	--text-wrong-color "00000000" \
	--text-color $GREEN
