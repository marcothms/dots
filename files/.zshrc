#        __      _
#       / /     | |
#      / /______| |__  _ __ ___
#     / /_  / __| '_ \| '__/ __|
#  _ / / / /\__ \ | | | | | (__
# (_)_/ /___|___/_| |_|_|  \___|
#
# ~ M. Thomas

# ============================== Prompt
autoload -Uz vcs_info
autoload -U colors && colors
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

LN=$'\n'
ICON="%(?.%{$fg[green]%}.%{$fg[red]%})λ"
DIR="%{$fg[blue]%}%~"
GIT="%{$fg[red]%}\$vcs_info_msg_0_"

if [[ -n "$SSH_CONNECTION" ]]; then
    NAME="%B%{$fg[yellow]%}%m%b "
fi

case $TERM in
  (*xterm* | rxvt | alacritty)

    # Write some info to terminal title.
    # This is seen when the shell prompts for input.
    function precmd {
      print -Pn "\e]0;%(1j,%j job%(2j|s|) - ,)%~ - $TERM\a"
    }
    # Write command and arguments to terminal title.
    # This is seen while the shell waits for a command to complete.
    function preexec {
      printf "\033]0;%s\a" "$1 - $TERM"
    }

  ;;
esac

export PROMPT="${NAME}${DIR}${GIT} ${ICON}%{$reset_color%} "
zstyle ':vcs_info:git:*' formats '|%b '

# ============================== Aliases
alias c='clear'

alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias ll='ls -l'      #long list

alias rm='rm -i' # Ask before removal
alias cp='cp -i' # Ask before removal
alias mv='mv -i' # Ask before removal

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

# ============================== Completion
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*' menu select

autoload -Uz compinit
compinit -C
_comp_options+=(globdots)

# Case Insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## Directory navigation
setopt autocd autopushd

# ============================== History
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data inside tmux
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=5000

# ============================== ssh-agent
if ! [ -S $HOME/.ssh/mthomas-agent.sock ]; then
    echo "Starting ssh-agent"
    ssh-agent -a $HOME/.ssh/mthomas-agent.sock
    ssh-add
fi

# ============================== vi-Mode
bindkey -v
export KEYTIMEOUT=1

# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select

function vi_mode_prompt_info() {
  MODE_INDICATOR="%{$fg[green]%}<<<%{$reset_color%}"
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# Show mode indication on right side
RPS1='$(vi_mode_prompt_info)'
RPS2=$RPS1

# Enable backspace to delete in vi-mode
bindkey -v '^?' backward-delete-char

# ============================== fzf
export FZF_DEFAULT_COMMAND='find .'
export FZF_DEFAULT_OPTS='
       --layout=reverse
       --bind=tab:down
       --bind=btab:up
       --color=fg:#575f66,bg:#fafafa,hl:#458588
       --color=fg+:#575f66,bg+:#fafafa,hl+:#458588
       --color=info:#575f66,prompt:#575f66,pointer:#575f66
       --color=marker:#575f66,spinner:#575f66,header:#575f66'

## fzf Bindings in zsh (C-r and C-t)
if [[ -x $(which fzf 2> /dev/null) ]]
then
    source ~/scripts/key_bindings.zsh
else
    bindkey '^R' history-incremental-search-backward
fi

# ============================== Fancy Hacks
# Always use C-z for bg and fg
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
