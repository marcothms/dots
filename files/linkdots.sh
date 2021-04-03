#!/usr/bin/env bash

# Make sure the paths are correct
path=$(pwd)

# --- home --- #
home_files=".bashrc .zshrc .gitconfig .tmux .tmux.conf .vimrc .Xresources .xinitrc"
for file in $home_files
do
	rm -rf $HOME/$file
	ln -sf $path/$file $HOME/$file
done

# scripts
rm -rf $HOME/scripts
ln -sf $path/scripts $HOME/scripts

# emacs
mkdir -p $HOME/.emacs.d
ln -sf $path/init.el $HOME/.emacs.d/init.el

# startx
chmod +x $HOME/.xinitrc
ln -sf $HOME/.xinitrc $HOME/.xsession

# --- .config --- #
conf_files="alacritty dunst nvim picom.conf ranger zathura"
for file in $conf_files
do
	rm -rf $HOME/.config/$file
	ln -sf $path/.config/$file $HOME/.config/$file
done
