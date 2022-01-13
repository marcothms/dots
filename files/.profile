# executed on login

# set xresources
xrdb -merge $HOME/.Xresources

# map CAPS to ~
setxkbmap eu
setxkbmap -option caps:none
xmodmap -e "keycode 66 = grave asciitilde"

# energy options
xset s off
xset -dpms
xset s noblank

# keyboard repeat
xset r rate 300 50

# no mouse accel
xset m 1

# path
export PATH=$PATH:$HOME/dots/scripts:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$HOME/.local/bin

# editor
export EDITOR="nvim"
export VISIAL=${EDITOR}

# anthy
export GTK_IM_MODULE='xim'
export QT_IM_MODULE='ibus'
export SDL_IM_MODULE='ibus'
export XMODIFIERS='@im=ibus'
export WINIT_UNIX_BACKEND=x11

# ssh agent
eval $(systemctl --user show-environment | grep SSH_AUTH_SOCK)
export SSH_AUTH_SOCK
