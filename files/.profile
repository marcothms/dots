# executed on login

# set xresources
xrdb -merge $HOME/.Xresources

# map CAPS to ~
setxkbmap -option caps:none
xmodmap -e "keycode 66 = grave asciitilde"

# path
export PATH=$PATH:$HOME/scripts:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$HOME/.local/bin

# ssh
export SSH_AUTH_SOCK=/tmp/mthomas-agent.sock

# editor
export EDITOR="vim"
export VISIAL=${EDITOR}

# fcitx exports
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'
export WINIT_UNIX_BACKEND=x11
