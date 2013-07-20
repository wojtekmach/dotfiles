if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_aliases.local ]; then
    . ~/.bash_aliases.local
fi

if [ -f ~/.bash_functions ]; then
  . ~/.bash_functions
fi

if [ -d ~/.bash_completion.d ]; then
  source ~/.bash_completion.d/*
fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# PATH

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.usr/bin:$PATH"
export PATH="$HOME/Code/vendor/mruby/bin:$PATH"

export PS1="\$(wdalias)\$(parse_git_branch)% "
export EDITOR="vim"
which -s mvim && export EDITOR="mvim"

# enable color support of ls

if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# vi

set -o vi
stty -ixon

# rvm

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# BEGIN Ruboto PATH setup
export ANDROID_HOME="/Users/wojtek/android-sdk-macosx"
export PATH="/Users/wojtek/android-sdk-macosx/tools:$PATH"
export PATH="/Users/wojtek/android-sdk-macosx/platform-tools:$PATH"
export PATH="/Users/wojtek/android-sdk-macosx/build-tools/17.0.0:$PATH"
export PATH="/Users/wojtek/.rvm/share/npm/bin:$PATH"
# END Ruboto PATH setup

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# export TOKAIDO_TMPDIR="/tmp/tokaido"
