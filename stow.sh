#!/bin/bash

FILES_DIR=$PWD/files
OPTS=$1

echo "You are about to stow all config files."
echo "Do you want to proceed? [y]"
read proceed

if [ "${proceed}" != "y" ]; then
    echo "Exiting!"
    exit
fi

echo "Stowing configs..."
cd $FILES_DIR
stow ${OPTS} -v --target="$HOME" *
echo "Done!"
