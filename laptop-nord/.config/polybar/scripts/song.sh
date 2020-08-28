#!/bin/sh

length=20

function scroll () {
	prefix="$1"
	scrolling="$2"
	temp="$(echo "$scrolling"| sed "s/^\(.\{$length\}\)\(.*\)$/\1[\2]/"| sed "s/\[ *\]$//"| sed "s/\[.*\]$//")"
	suffix="$3"
	if [ "$(echo -n $scrolling |wc -c)" -gt $length ]; then
		echo "$prefix%{T7}$temp%{T-}$suffix"
		sleep 0.5

		zscroll -l $length \
        		--delay 0.2 \
			--before-text "$prefix%{T7}" \
			--after-text "%{T-}$suffix" \
			--scroll-padding "     " \
			--update-check true "echo '$(get_title)'" &

		wait
	else
		echo "$prefix%{T8} $temp %{T-}$suffix"
	fi
} #

function get_artist () {
	echo "$(playerctl -p spotify metadata --format "{{ artist }}"| sed -e "s/[[(]....*[])]*//g" | sed "s/ *$//"| sed "s/^\(.\{$length\}[^ ]*\)\(.*\)$/\1[\2]/"| sed "s/\[ *\]$//"| sed "s/\[.*\]$/.../")"
} #

function get_title () {
	echo "$(playerctl -p spotify metadata --format "{{title}}" | sed 's/'\''/\\'\''/g')"
} #

[ ! -z "$(playerctl -p spotify status 2>/dev/null)" ] \
	&& artist=$(get_artist) \
	&& title=$(get_title) \
	&& ([ -z "$artist$title" ] && scroll "" "Spotify is not connected on this pc" "" || scroll "%{F#79e6f3}$artist%{F#FFF} [" "$title" "]%{F-}" ) \
	|| exit 1
