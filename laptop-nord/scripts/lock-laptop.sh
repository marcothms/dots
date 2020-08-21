#!/bin/sh

blank="ffffff00"

nord0="2e3440"
nord1="3b4252"

frost2="eceff4"

blue2="88c0d0"
blue3="5e81ac"

red="bf616a"
yellow="ebcb8b"
green="a3be8c"

inside="${nord0}77"

i3lock \
    -i ~/data/wallpaper/forest_staircase.png \
    \
    --insidecolor=${inside} \
    --ringcolor=${nord0}ff \
    --linecolor=${blank} \
    --keyhlcolor=${green}ff \
    --bshlcolor=${red}ff \
    --separatorcolor=${blue3}ff \
    \
    --insidevercolor=${inside} \
    --ringvercolor=${yellow}ff \
    --verifcolor=${yellow}ff \
    \
    --insidewrongcolor=${inside} \
    --ringwrongcolor=${red}ff \
    --wrongcolor=${red}ff \
    \
    --layoutcolor=ECEFF4ff \
    --timecolor=ECEFF4ff \
    --datecolor=ECEFF4ff \
    \
    --clock \
    --indicator \
    \
    --timestr="%H:%M" \
    --datestr="%B %d, %Y" \
    --timepos="ix:iy-10" \
    \
    --timesize=17 \
    --datesize=13 \
    \
    --time-font="InconsolataLGC Nerd Font Mono" \
    --date-font="InconsolataLGC Nerd Font Mono" \
    \
    --veriftext="" \
    --noinputtext="" \
    --locktext="" \
    --wrongtext="" \
    \
    --ring-width 4 \
    --radius 100
