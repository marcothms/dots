#!/usr/bin/env bash

VERBOSE=$1

# Make sure the paths are correct
path=$(pwd)

# Scripts
rm -rf $HOME/scripts
ln -sf $path/scripts $HOME/scripts

# emacs
mkdir -p $HOME/.emacs.d
ln -sf $path/init.el $HOME/.emacs.d/init.el

# Home directory
home_files=".bashrc .zshrc .gitconfig .tmux.conf .vimrc .Xresources .xinitrc"
for file in $home_files
do
	ln -sf $path/$file $HOME/$file
	if [ "$VERBOSE" = "-v" ]; then
		echo "Linked from $path/$file to $HOME/$file"
	fi
done

# properly add startx files
chmod +x $HOME/.xinitrc
ln -s $HOME/.xinitrc $HOME/.xsession

# .config directory
conf_files="alacritty dunst i3 nvim picom.conf polybar ranger zathura"
for file in $conf_files
do
	rm -rf $HOME/.config/$file
	ln -sf $path/.config/$file $HOME/.config/$file
	if [ "$VERBOSE" = "-v" ]; then
		echo "Linked from $path/.config/$file to $HOME/.config/$file"
	fi
done
