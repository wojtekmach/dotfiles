export PROMPT="%~%% "

if [ -f $HOME/.bash_aliases ]; then
  source $HOME/.bash_aliases
fi

if [ -f $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi
