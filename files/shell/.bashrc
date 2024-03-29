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

# ============================== Jump Words
bind '"\en": forward-word'
bind '"\ep": backward-word'

# ============================== Source other definitions
[ -f ~/.shellrc.alias ] && source ~/.shellrc.alias
[ -f ~/.shellrc.local ] && source ~/.shellrc.local
