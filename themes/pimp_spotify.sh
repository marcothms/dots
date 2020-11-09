#!/bin/sh

path=$(pwd)

cp -r $path/Onepunch ~/.config/spicetify/Themes/.

spicetify config current_theme Onepunch
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify backup apply
spicetify apply
