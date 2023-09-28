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
    echo "Unknown option (neither -s, not -u), exiting."
    exit -1
    ;;
esac
done
