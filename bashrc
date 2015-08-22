source $HOME/.bashrc.local
source $HOME/.bash_aliases
source $HOME/.bash_aliases.local
source $HOME/.bash_completion.d/*.sh
source $HOME/.bash_functions

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_51.jdk/Contents/Home"
export EC2_HOME="$HOME/opt/ec2-api-tools"

complete -C $HOME/.bash_completion.d/rake_autocomplete.rb -o default rake

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# SSL
export SSL_CERT_FILE=$HOME/etc/cacert.pem

# utf-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=UTF-8

# ls
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# vi
export EDITOR="vim"
stty -ixon

# ctags
export CTAGS="-f .tags"

# bash
export PS1="\$(wdalias)\[\e[1;32m\]\$(parse_git_branch)\[\e[0m\]% "
set -o emacs

### Docker
export DOCKER_HOST=tcp://$(boot2docker ip 2> /dev/null):2376
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
export PATH="/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/.usr/bin:$PATH"
export PATH=$HOME/.rvm/bin:$PATH
export PATH=$HOME/src/vendor/elixir/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin/:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
for i in `echo $HOME/opt/**/bin`; do
  export PATH=$i:$PATH
done

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

function pkill2() {
  local pid
  pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
  kill -9 $pid
  echo -n "Killed $1 (process $pid)"
}
