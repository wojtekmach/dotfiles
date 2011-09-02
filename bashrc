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

if [ -f ~/.bash_functions ]; then
  . ~/.bash_functions
fi

source ~/.bash_completion.d/*

export PATH=$HOME/.usr/bin:$PATH
export PATH=$HOME/.bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/.rbenv/shims:$PATH

export PS1="\$(wdalias)\$(parse_git_branch)% "
export EDITOR="gvim"

set -o vi

if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi
