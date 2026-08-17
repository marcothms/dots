#!/bin/bash

set -e

CURRENT=$(pwd)

cd $HOME/.oh-my-zsh
git reset --hard 1> /dev/null
git apply $HOME/.dots/patches/*

cd ${CURRENT}
