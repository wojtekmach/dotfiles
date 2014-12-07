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

# PATH
export PATH="/usr/local/bin:/usr/local/sbin:$HOME/.bin:$HOME/.usr/bin:$PATH"

# prompt
export PS1="\$(wdalias)\[\e[1;32m\]\$(parse_git_branch)\[\e[0m\]% "

# ls
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# vi
export EDITOR="vim"
which mvim > /dev/null && export EDITOR="mvim"
stty -ixon

# ctags
export CTAGS="-f .tags"

set -o emacs

for i in $HOME/.bashrc-*; do source $i ; done

export PATH=$HOME/.rvm/bin:$PATH
export PATH=$HOME/opt/elixir/bin:$PATH
export PATH=$GOPATH/bin:$PATH

paths=`echo $HOME/opt/**/bin | sed 's/\s/\n/g'`
for i in $paths; do
  export PATH=$i:$PATH
done

export DOCKER_HOST=tcp://192.168.59.103:2375
export DOCKER_HOST=tcp://$(boot2docker ip 2> /dev/null):2375
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/wojtek/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

export PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin/:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
