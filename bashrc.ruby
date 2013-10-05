function use_rvm {
  source "$HOME/.rvm/scripts/rvm"
}

if [ -n "$HOMEBREW_ROOT" ]; then
  export PATH="$HOMEBREW_ROOT/bin:$HOMEBREW_ROOT/sbin:$PATH"

  # chruby

  if [ -d $HOMEBREW_ROOT/share/chruby ]; then
    source $HOME/.homebrew/share/chruby/chruby.sh
    source $HOME/.homebrew/share/chruby/auto.sh
    chruby 2.0
  else
    use_rvm
  fi
else
  use_rvm
fi
