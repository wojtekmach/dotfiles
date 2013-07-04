if [ -f $HOME/.bash_aliases ]; then
  source $HOME/.bash_aliases
fi

git_prompt() {
  ref=$(git symbolic-ref HEAD 2>/dev/null| cut -d'/' -f3)
  echo $ref
 }
setopt prompt_subst
autoload -U promptinit
promptinit

export PROMPT="%~$(git_prompt)%% "
export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

set -o vi

if [ -f $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm use 1.9.3-p194 &> /dev/null

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
