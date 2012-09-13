# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

if [ -f ~/.bash_functions ]; then
  . ~/.bash_functions
fi

source ~/.bash_completion.d/*
source ~/.bashrc.local

export PATH="$HOME/.bin:$HOME/.usr/bin:$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/texbin:$HOME/Documents/Dev/vendor/julia/julia-c031eb03b7/bin/"
export NODE_PATH="/usr/local/lib/node_modules"
#export PATH="$HOME/.rbenv/bin:$PATH"
#export PATH="$HOME/.rbenv/shims:$PATH"
#eval "$(rbenv init -)"

export PS1="\$(wdalias)\$(parse_git_branch)% "
export EDITOR="mvim"

set -o vi
[[ -s "/Users/wojtek/.rvm/scripts/rvm" ]] && source "/Users/wojtek/.rvm/scripts/rvm"

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
