#!/bin/sh

VERBOSE=$1

# Make sure the paths are correct
path=$(pwd)

# Scripts
rm -rf $HOME/scripts
ln -sf $path/scripts $HOME/scripts

# Home directory
home_files=".dir_colors .gitconfig .tmux.conf .vimrc .Xresources .zshrc .zsh_highlighting"
for file in $home_files
do
	ln -sf $path/$file $HOME/$file
	if [ "$VERBOSE" = "-v" ]; then
		echo "Linked from $path/$file to $HOME/$file"
	fi
done

# .config directory
conf_files="alacritty dunst i3 neofetch nvim picom.conf polybar ranger rofi"
for file in $conf_files
do
	rm -rf $HOME/.config/$file
	ln -sf $path/.config/$file $HOME/.config/$file
	if [ "$VERBOSE" = "-v" ]; then
		echo "Linked from $path/.config/$file to $HOME/.config/$file"
	fi
done
