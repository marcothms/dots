# ~/.zshrc
#
# ~ M. Thomas

# ============================== Prompt
autoload -Uz vcs_info
autoload -U colors && colors
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

ICON="%(?.%{$fg[green]%}.%{$fg[red]%})󱞩"
DIR="%{$fg[blue]%}%~"
GIT="%{$fg[red]%}\$vcs_info_msg_0_"
HOSTN="%{$fg[yellow]%}%m "
NEWLINE=$'\n'

export PROMPT="${HOSTN}${DIR}${GIT}${NEWLINE}${ICON}%{$reset_color%} "
zstyle ':vcs_info:git:*' formats ' (%b )'

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
[ -f ~/.shellrc.alias ] && source ~/.shellrc.alias
[ -f ~/.shellrc.local ] && source ~/.shellrc.local
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
