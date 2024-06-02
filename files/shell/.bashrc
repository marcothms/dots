# ~/.bashrc
#
# M. Thomas

# if not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# ============================== Prompt
git_branch() {
    if $(git rev-parse --git-dir > /dev/null 2>&1); then
        local branch_name=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
        if [[ $(uname) == "OpenBSD" ]]; then
            echo "(${branch_name}) "
        else
            echo "(${branch_name} ) "
        fi
    fi
}

nix_env() {
  if $(echo $PATH | grep "/nix/store" > /dev/null 2>&1); then
    echo "(nix)"
  fi
}

HOST="\[\033[0;33m\]\h\[\033[m\]"
GIT_NIX="\[\033[0;31m\]\$(git_branch)\$(nix_env)\[\033[m\]"
DIR="\[\033[0;34m\]\w\[\033[m\]"
NEWLINE=$'\n'

PROMPT_COMMAND=__prompt_command
__prompt_command() {
  local EXIT="$?"
  if [ $COLUMNS -lt 80 ]; then
    export PROMPT_DIRTRIM=1
  else
    export PROMPT_DIRTRIM=0
  fi
  export PS1="${HOST} ${DIR} ${GIT_NIX}${NEWLINE}"

  if [[ $(uname) == "OpenBSD" ]]; then
    local red_lambda='\[\033[0;31m\]>\[\033[00m\] '
    local green_lambda='\[\033[0;32m\]>\[\033[00m\] '
  else
    local red_lambda='\[\033[0;31m\]󱞩\[\033[00m\] '
    local green_lambda='\[\033[0;32m\]󱞩\[\033[00m\] '
  fi

  if [ $EXIT != 0 ]
  then
    PS1+=$red_lambda
  else
    PS1+=$green_lambda
  fi
}

# ============================== Auto Complete

# Press Tab to auto complete like zsh
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'

# Auto complete ssh hosts
_ssh()
{
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts=$(grep '^Host' ~/.ssh/config ~/.ssh/config.d/* 2>/dev/null | grep -v '[?*]' | cut -d ' ' -f 2-)

  COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
  return 0
}
complete -F _ssh ssh
complete -F _ssh s

# ============================== Jump Words
stty -ixon  # enable forward search with C-s
bind '"\en": forward-word'
bind '"\ep": backward-word'

# ============================== Source other definitions
[ -f ~/.shellrc.alias ] && source ~/.shellrc.alias
[ -f ~/.shellrc.local ] && source ~/.shellrc.local
