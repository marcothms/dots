#!/bin/bash

FILES_DIR=$PWD/files
OPTS=$1

echo "You are about to stow all config files and fonts."
echo "Do you want to proceed? [y]"
read proceed

if [ "${proceed}" != "y" ]; then
    echo "Exiting!"
    exit
fi

echo "Stowing configs..."
cd $FILES_DIR
stow ${OPTS} -v --ignore="init.org" --target="$HOME" *
echo "Done!"

echo "Stowing fonts..."
cd ../
stow ${OPTS} -v --target="$HOME/.local/share/fonts" fonts
echo "Done!"
