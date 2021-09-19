#!/usr/bin/env bash

# Make sure the paths are correct
path=$(pwd)

# --- home --- #
home_files="scripts .zshrc .gitconfig .tmux.conf .vimrc .profile"

for file in $home_files
do
	# rm, so folders also get updated
	rm -rf $HOME/$file
	ln -sf $path/$file $HOME/$file
done

# emacs
mkdir -p $HOME/.emacs.d
ln -sf $path/init.el $HOME/.emacs.d/init.el

# --- .config --- #
conf_files="alacritty zathura i3 i3status"

for file in $conf_files
do
	# rm, so folders also get updated
	rm -rf $HOME/.config/$file
	ln -sf $path/.config/$file $HOME/.config/$file
done
