#!/bin/bash

FILES_DIR=$HOME/dots/files
OPTS=$1

echo "You are about to stow all config files."
echo "Do you want to proceed? [y]"
read proceed

if [ "${proceed}" != "y" ]; then
    echo "Exiting!"
    exit
fi

echo "Switching to ${FILES_DIR}"
cd $FILES_DIR

echo "STOWING..."
stow ${OPTS} -v --ignore="init.org" --target="$HOME" *
echo "DONE!"
