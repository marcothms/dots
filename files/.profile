# executed on login

# path
export PATH=$PATH:$HOME/scripts:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin:$HOME/.local/bin

# ssh
export SSH_AUTH_SOCK=/tmp/marc-agent.sock

# editor
export EDITOR="vim"
export VISIAL=${EDITOR}

# keyboard layout
setxkbmap -layout za

# fcitx exports
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'
export WINIT_UNIX_BACKEND=x11

# gtk and qt theme - requires https://github.com/hargonix/Pop-gruvbox/ in ~/.themes
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_THEME=Pop-gruvbox:light
export QT_QPA_PLATFORMTHEME="gtk2"
