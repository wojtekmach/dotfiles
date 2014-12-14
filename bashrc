source $HOME/.bashrc.local
source $HOME/.bash_aliases
source $HOME/.bash_aliases.local
source $HOME/.bash_completion.d/*
source $HOME/.bash_functions

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# utf-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=UTF-8

# ls
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# vi
export EDITOR="vim"
which mvim > /dev/null && export EDITOR="mvim"
stty -ixon

# ctags
export CTAGS="-f .tags"

# bash
export PS1="\$(wdalias)\[\e[1;32m\]\$(parse_git_branch)\[\e[0m\]% "
set -o emacs

### Docker
export DOCKER_HOST=tcp://192.168.59.103:2375
export DOCKER_HOST=tcp://$(boot2docker ip 2> /dev/null):2375
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/wojtek/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# Node
export NODE_PATH="/usr/local/lib/node_modules"

# Homebrew
if [ -d $HOME/.homebrew/Cellar ]; then
  export HOMEBREW_ROOT=$HOME/.homebrew
elif [ -d /usr/local/Cellar ]; then
  export HOMEBREW_ROOT=/usr/local
fi

# Ruby
source $HOME/.rvm/scripts/rvm

# Go
export GOPATH=$HOME/src/go

# PATH
export PATH="/usr/local/bin:/usr/local/sbin:$HOME/.bin:$HOME/.usr/bin:$PATH"
export PATH=$HOME/.rvm/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin/:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
for i in `echo $HOME/opt/**/bin`; do
  export PATH=$i:$PATH
done
