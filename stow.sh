#!/bin/bash

# Utility script to stow or un-stow configuration

set -e

for i in "$1"
do
case $i in
    -s|--stow)
    echo "Stowing configuration for $2"
    stow -v -d files -t $HOME $2
    ;;
    -u|--unstow)
    echo "Deleting configuration for $2"
    stow -D -v -d files -t $HOME $2
    ;;
    *)
    echo "Use $0 --stow <folder_name> to deploy configuration"
    echo "Use $0 --unstow <folder_name> to remove configuration"
    exit -1
    ;;
esac
done
