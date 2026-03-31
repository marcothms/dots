export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
 
plugins=(git colored-man-pages rust ssh-agent)

zstyle :omz:plugins:ssh-agent helper sshaskpass

bindkey ^F forward-word
bindkey ^B backward-word

source $ZSH/oh-my-zsh.sh

[ -f ~/.shellrc.alias ] && source ~/.shellrc.alias
[ -f ~/.shellrc.local ] && source ~/.shellrc.local
