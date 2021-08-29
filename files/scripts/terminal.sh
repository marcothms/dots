#!/bin/sh

if [ $USER == "marc" ]; then
    alacritty
else
    xterm
fi
