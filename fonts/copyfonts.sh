#!/bin/sh

# Make sure the paths are correct
path=$(pwd)
fontpattern="*.*tf"

cp $path/$fontpattern $HOME/.local/share/fonts/.

echo "Fonts copied, reloading cache..."

fc-cache -v
echo "Done!"
