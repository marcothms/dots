# ============================== Prompt
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/|\1/'
}

HOST="\[\033[0;93m\]\h\[\033[m\]"
GIT="\[\033[1;91m\]\$(git_branch)\[\033[m\]"
ICON="\[\033[1;92m\]λ\[\033[m\]"
DIR="\[\033[1;94m\]\w\[\033[m\]"
export PS1="${HOST} ${DIR}${GIT} ${ICON} "

# ============================== Aliases
alias emacsnw="TERM=xterm-direct emacsclient -c -nw -a 'emacs -nw'"
alias s="cd ~/scripts/"
alias c='clear'

alias l='ls -lfh'     #size,show type,human readable
alias la='ls -lafh'   #long list,show almost all,show type,human readable
alias ll='ls -l'      #long list

alias rm='rm -i' # ask before removal
alias cp='cp -i' # ask before removal
alias mv='mv -i' # ask before removal

# ============================== SSH-Agent
if ! [ -S /tmp/marc-agent.sock ]; then
    echo "Starting ssh-agent"
    ssh-agent -a /tmp/marc-agent.sock
    ssh-add
fi

# ============================== vi-Mode
set -o vi

# ============================== Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# ============================== Source local definitions
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
