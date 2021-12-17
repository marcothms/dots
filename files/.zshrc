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

alias nssh='SSH_AUTH_SOCK= ssh'

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
    #     ____      ____
    #    / __/___  / __/
    #   / /_/_  / / /_
    #  / __/ / /_/ __/
    # /_/   /___/_/ key-bindings.zsh
    #
    # - $FZF_TMUX_OPTS
    # - $FZF_CTRL_T_COMMAND
    # - $FZF_CTRL_T_OPTS
    # - $FZF_CTRL_R_OPTS
    # - $FZF_ALT_C_COMMAND
    # - $FZF_ALT_C_OPTS

    # Key bindings
    # ------------

    # The code at the top and the bottom of this file is the same as in completion.zsh.
    # Refer to that file for explanation.
    if 'zmodload' 'zsh/parameter' 2>'/dev/null' && (( ${+options} )); then
    __fzf_key_bindings_options="options=(${(j: :)${(kv)options[@]}})"
    else
    () {
	__fzf_key_bindings_options="setopt"
	'local' '__fzf_opt'
	for __fzf_opt in "${(@)${(@f)$(set -o)}%% *}"; do
	if [[ -o "$__fzf_opt" ]]; then
	    __fzf_key_bindings_options+=" -o $__fzf_opt"
	else
	    __fzf_key_bindings_options+=" +o $__fzf_opt"
	fi
	done
    }
    fi

    'emulate' 'zsh' '-o' 'no_aliases'

    {

    [[ -o interactive ]] || return 0

    # CTRL-T - Paste the selected file path(s) into the command line
    __fsel() {
    local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
	-o -type f -print \
	-o -type d -print \
	-o -type l -print 2> /dev/null | cut -b3-"}"
    setopt localoptions pipefail no_aliases 2> /dev/null
    eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
	echo -n "${(q)item} "
    done
    local ret=$?
    echo
    return $ret
    }

    __fzfcmd() {
    [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
	echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
    }

    fzf-file-widget() {
    LBUFFER="${LBUFFER}$(__fsel)"
    local ret=$?
    zle reset-prompt
    return $ret
    }
    zle     -N   fzf-file-widget
    bindkey '^T' fzf-file-widget

    # Ensure precmds are run after cd
    fzf-redraw-prompt() {
    local precmd
    for precmd in $precmd_functions; do
	$precmd
    done
    zle reset-prompt
    }
    zle -N fzf-redraw-prompt

    # ALT-C - cd into the selected directory
    fzf-cd-widget() {
    local cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
	-o -type d -print 2> /dev/null | cut -b3-"}"
    setopt localoptions pipefail no_aliases 2> /dev/null
    local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
    if [[ -z "$dir" ]]; then
	zle redisplay
	return 0
    fi
    if [ -z "$BUFFER" ]; then
	BUFFER="cd ${(q)dir}"
	zle accept-line
    else
	print -sr "cd ${(q)dir}"
	cd "$dir"
    fi
    local ret=$?
    unset dir # ensure this doesn't end up appearing in prompt expansion
    zle fzf-redraw-prompt
    return $ret
    }
    zle     -N    fzf-cd-widget
    bindkey '\ec' fzf-cd-widget

    # CTRL-R - Paste the selected command from history into the command line
    fzf-history-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
    selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' |
	FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
    local ret=$?
    if [ -n "$selected" ]; then
	num=$selected[1]
	if [ -n "$num" ]; then
	zle vi-fetch-history -n $num
	fi
    fi
    zle reset-prompt
    return $ret
    }
    zle     -N   fzf-history-widget
    bindkey '^R' fzf-history-widget

    } always {
    eval $__fzf_key_bindings_options
    'unset' '__fzf_key_bindings_options'
    }
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
