#!/bin/bash
# Get IDs for all the open windows
# ids=$($HOME/.scripts/get-window-id.sh a)
ids=$(xprop -root |grep _NET_CLIENT_LIST_STACKING\(WINDOW\) |cut -d"#" -f2| tr -d " "|tr "," " ")

for id in $ids
do names="$names $(xprop -id $id| grep WM_CLASS |tr -d '" '|cut -d "=" -f2|awk -F "," '{print $NF}')($id)"
done

flags='-m 0 -i -l 10 -p window -fn SFMono-10 -nb #2f383e -nf #d3c6aa -sb #93b259 -sf #2f383e'

# Show Open window class names as a dmenu option
target=$(echo $names | tr " " "\n" | dmenu $flags | grep -Eo "\(.*\)" | tr -d "()" )

# switch to chosen window
i3-msg [id="$target"] focus
