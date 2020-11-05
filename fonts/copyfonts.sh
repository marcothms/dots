#!/bin/sh

# Make sure the paths are correct
path=$(pwd)

cp $path/*.ttf $HOME/.local/share/fonts/.
echo "Fonts copied, reloading cache..."

fc-cache -v
echo "Done!"
