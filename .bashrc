# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

. ~/.bash_aliases

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}
_rakecomplete() {
  COMPREPLY=($(compgen -W "`rake -s -T 2> /dev/null | awk '{{print $2}}'`" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}
complete -o default -o nospace -F _rakecomplete rake

if [[ -s /home/wojtek/.rvm/scripts/rvm ]] ; then source /home/wojtek/.rvm/scripts/rvm ; fi

export PATH=$HOME/.opt/bin:$PATH
export PS1="\$(prompt_pwd)\$(parse_git_branch)% "
export PROMPT_BASEDIR=/home/wojtek/.prompt_basedir
export EDITPR="gvim"
