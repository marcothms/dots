# ~/.zshrc
#
# ~ M. Thomas

# ============================== Prompt
autoload -Uz vcs_info
autoload -U colors && colors
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

ICON="%(?.%{$fg[green]%}.%{$fg[red]%})λ>"
DIR="%{$fg[blue]%}%~"
GIT="%{$fg[red]%}\$vcs_info_msg_0_"
HOSTN="%{$fg[yellow]%}%m "

export PROMPT="${HOSTN}${DIR}${GIT} ${BREAK}${ICON}%{$reset_color%} "
zstyle ':vcs_info:git:*' formats ' (%b )'

# show info in title bar
case $TERM in
  (*xterm* | rxvt | alacritty)
    # This is seen when the shell prompts for input.
    function precmd {
      print -Pn "\e]0;%m: %~\a"
    }
    # This is seen while the shell waits for a command to complete.
    function preexec {
      printf "\033]0;$(hostname): %s\a" "$1"
    }
    ;;
esac

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
export FZF_DEFAULT_OPTS='
       --layout=reverse
       --color=fg:#5c6a72,bg:#FDF6E3,hl:#8da101
       --color=fg+:#5c6a72,bg+:#eee8d5,hl+:#8da101
       --color=info:#5c6a72,prompt:#5c6a72,pointer:#5c6a72
       --color=marker:#5c6a72,spinner:#5c6a72,header:#5c6a72'

if [[ -d ~/.vim/plugged/fzf ]]; then
  [[ -x $(which fzf 2> /dev/null) ]] || PATH=$PATH:$HOME/.vim/plugged/fzf/bin
  source ~/.vim/plugged/fzf/shell/completion.zsh
  source ~/.vim/plugged/fzf/shell/key-bindings.zsh
  bindkey '^F' fzf-file-widget
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

# ============================== Source other definitions
[ -f ~/.shellrc.local ] && source ~/.shellrc.local
[ -f ~/.shellrc.alias ] && source ~/.shellrc.alias

# nix
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
