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
        echo "(${branch_name} ) "
    fi
}

HOST="\[\033[0;33m\]\h\[\033[m\]"
GIT="\[\033[0;31m\]\$(git_branch)\[\033[m\]"
DIR="\[\033[0;34m\]\w\[\033[m\]"

PROMPT_COMMAND=__prompt_command
__prompt_command() {
  local EXIT="$?"
  export PS1="${HOST} ${DIR} ${GIT}"

  local red_lambda='\[\033[0;31m\]λ>\[\033[00m\] '
  local green_lambda='\[\033[0;32m\]λ>\[\033[00m\] '

  if [ $EXIT != 0 ]
  then
    PS1+=$red_lambda
  else
    PS1+=$green_lambda
  fi
}

# ============================== vi-Mode
set -o vi

# ============================== fzf
export FZF_DEFAULT_OPTS='
       --layout=reverse
       --color=fg:#5c6a72,bg:#FDF6E3,hl:#8da101
       --color=fg+:#5c6a72,bg+:#eee8d5,hl+:#8da101
       --color=info:#5c6a72,prompt:#5c6a72,pointer:#5c6a72
       --color=marker:#5c6a72,spinner:#5c6a72,header:#5c6a72'

if [[ -d ~/.vim/plugged/fzf ]]; then
  [[ -x $(which fzf 2> /dev/null )]] || PATH=$PATH:$HOME/.vim/plugged/fzf/bin
  source ~/.vim/plugged/fzf/shell/completion.bash
  source ~/.vim/plugged/fzf/shell/key-bindings.bash
  bind '"":"fzf-file-widget\n"'
fi

# ============================== Source other definitions
[ -f ~/.shellrc.local ] && source ~/.shellrc.local
[ -f ~/.shellrc.alias ] && source ~/.shellrc.alias
