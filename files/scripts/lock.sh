#!/bin/bash

if [ `hostname` == "nazarick" ];then
    pic=$HOME/data/nextcloud/wallpaper/lock219.png
else
    pic=$HOME/data/nextcloud/wallpaper/lock169.png
fi

if [ $USER == "marc" ];then
    i3lock --nofork \
	   -i ${pic} \
	   --inside-color=#373445ff --ring-color=ffffffff --line-uses-inside \
	   --keyhl-color=d23c3dff --bshl-color=d23c3dff --separator-color=00000000 \
	   --insidever-color=fecf4dff --insidewrong-color=d23c3dff \
	   --ringver-color=ffffffff --ringwrong-color=ffffffff --ind-pos="x+86:y+86" \
	   --radius=15 --verif-text="" --wrong-text="" --noinput-text=""
else
   $HOME/scripts/lock-work.sh
fi
