# executed on login

# set xresources
xrdb -merge $HOME/.Xresources

# keyboard
setxkbmap eu
# setxkbmap -option caps:none
# xmodmap -e "keycode 66 = grave asciitilde"
setxkbmap -option caps:swapescape

# energy options
xset s off
xset -dpms
xset s noblank

# keyboard repeat
xset r rate 300 50

# no mouse accel
xset m 1

# path
export PATH=$PATH:$HOME/.dots/scripts:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$HOME/.local/bin

# editor
export EDITOR="vim"
export VISIAL=${EDITOR}

# fcitx
export GTK_IM_MODULE='xim'
export QT_IM_MODULE='ibus'
export SDL_IM_MODULE='ibus'
export XMODIFIERS='@im=ibus'
export WINIT_UNIX_BACKEND=x11
