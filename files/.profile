# executed on login

# set xresources
xrdb -merge $HOME/.Xresources

# map CAPS to ~
setxkbmap -option caps:none
xmodmap -e "keycode 66 = grave asciitilde"

# path
export PATH=$PATH:$HOME/scripts:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$HOME/.local/bin

# editor
export EDITOR="vim"
export VISIAL=${EDITOR}

# fcitx exports
export GTK_IM_MODULE='xim'
export QT_IM_MODULE='ibus'
export SDL_IM_MODULE='ibus'
export XMODIFIERS='@im=ibus'
export WINIT_UNIX_BACKEND=x11
