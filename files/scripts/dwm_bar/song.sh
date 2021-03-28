#!/bin/sh

function scroll () {
	prefix="$1"
	scrolling="$2"
	temp="$(echo "$scrolling"| sed "s/^\(.\{20\}\)\(.*\)$/\1[\2]/"| sed "s/\[ *\]$//"| sed "s/\[.*\]$//")"
	suffix="$3"
	if [ "$(echo -n $scrolling |wc -c)" -gt 30 ]; then
		echo "${prefix}${temp}${suffix}"
		sleep 0.5

		zscroll -l 30 \
        		--delay 0.2 \
			--before-text "$prefix" \
			--after-text "$suffix" \
			--scroll-padding "     " \
			--update-check true "echo '$(get_title)'" &

		wait
	else
		echo "$prefix $temp $suffix"
	fi
} #

function get_artist () {
	echo "$(playerctl -p spotify metadata --format "{{ artist }}"| sed -e "s/[[(]....*[])]*//g" | sed "s/ *$//"| sed "s/^\(.\{20\}[^ ]*\)\(.*\)$/\1[\2]/"| sed "s/\[ *\]$//"| sed "s/\[.*\]$/.../")"
} #

function get_title () {
	echo "$(playerctl -p spotify metadata --format "{{title}}" | sed 's/'\''/\\'\''/g')"
} #

[ ! -z "$(playerctl -p spotify status 2>/dev/null)" ] \
	&& artist=$(get_artist) \
	&& title=$(get_title) \
	&& ([ -z "$artist$title" ] && scroll "" "Spotify is not connected on this pc" "" || scroll "$artist - $title" ) \
	|| exit 1
