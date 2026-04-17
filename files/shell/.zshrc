export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="afowler"

COMPLETION_WAITING_DOTS="true"
 
plugins=(git colored-man-pages rust ssh-agent)

zstyle :omz:plugins:ssh-agent helper sshaskpass
zstyle :omz:update mode disabled

bindkey ^F forward-word
bindkey ^B backward-word

setopt globdots

source $ZSH/oh-my-zsh.sh

[ -f ~/.shellrc.alias ] && source ~/.shellrc.alias
[ -f ~/.shellrc.local ] && source ~/.shellrc.local

function set_zellij_tab_to_working_dir() {
    local current_dir=$PWD
    if [[ $current_dir == $HOME ]]; then
        current_dir="~"
    else
        current_dir=${current_dir##*/}
    fi
    command nohup zellij action rename-tab $current_dir >/dev/null 2>&1
}

[[ -n $ZELLIJ ]] && add-zsh-hook precmd set_zellij_tab_to_working_dir
