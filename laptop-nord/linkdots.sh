#!/bin/sh

# Make sure the paths are correct
path=$(pwd)

# Scripts
rm -rf $HOME/scripts
ln -sf $path/scripts $HOME/scripts

# Home directory
ln -sf $path/.dir_colors $HOME/.dir_colors
ln -sf $path/.gitconfig $HOME/.gitconfig
ln -sf $path/.tmux.conf $HOME/.tmux.conf
ln -sf $path/.vimrc $HOME/.vimrc
ln -sf $path/.Xresources $HOME/.Xresources
ln -sf $path/.zshrc $HOME/.zshrc

# .config directory
rm -rf $HOME/.config/alacritty
ln -sf $path/.config/alacritty $HOME/.config/alacritty

rm -rf $HOME/.config/dunst
ln -sf $path/.config/dunst $HOME/.config/dunst

rm -rf $HOME/.config/i3
ln -sf $path/.config/i3 $HOME/.config/i3

rm -rf $HOME/.config/nvim
ln -sf $path/.config/nvim $HOME/.config/nvim

rm -rf $HOME/.config/picom.conf
ln -sf $path/.config/picom.conf $HOME/.config/picom.conf

rm -rf $HOME/.config/polybar
ln -sf $path/.config/polybar $HOME/.config/polybar

rm -rf $HOME/.config/ranger
ln -sf $path/.config/ranger $HOME/.config/ranger

rm -rf $HOME/.config/rofi
ln -sf $path/.config/rofi $HOME/.config/rofi
