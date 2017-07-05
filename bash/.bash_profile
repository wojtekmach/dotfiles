function parse_git_branch {
  b=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"`
  if [ "$b" != "" ]; then
    echo "[$b]"
  fi
}

PS1="\$(wdalias)\[\e[1;32m\]\$(parse_git_branch)\[\e[0m\]% "

# colors
export TERM='xterm-color'
alias ls='ls -G'
alias ll='ls -lG'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# exports
export EDITOR="vim"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# aliases
alias ..="cd .."
## git
alias gaa="git add --all "
alias gb="git branch "
alias gbc="git rev-parse --abbrev-ref HEAD "
alias gc="git commit --verbose "
alias gd="git diff "
alias gdh="git diff HEAD "
alias gl="git l "
alias gs="git status "
## elixir
alias iexm="iex -S mix"
alias mps="iex -S mix phoenix.server"
alias mc="mix compile"
alias tm="MIX_ENV=test mix "
alias tmc="MIX_ENV=test mix compile "
alias t="mix test "
alias xref="time mix compile.xref"
## projects
alias wojtekmach="cd ~/src/wojtekmach"
alias dotfiles="cd ~/src/wojtekmach/dotfiles"
alias hex="cd ~/src/hexpm/hex"
alias mini_hex="cd ~/src/wojtekmach/mini_hex"
alias hexpm="cd ~/src/hexpm/hexpm"
alias ecto="cd ~/src/elixir-ecto/ecto"
alias plug="cd ~/src/elixir-lang/plug"
alias phoenix="cd ~/src/phoenixframework/phoenix"
alias cd-elixir="cd ~/src/elixir-lang/elixir"
alias cc="cd ~/src/clubcollect"
alias be="cd ~/src/clubcollect/billing-engine"
alias cb="cd ~/src/clubcollect/clubbase"
alias groundhog="cd ~/src/clubcollect/groundhog"
alias purpose="cd ~/src/clubcollect/purpose"
alias shipit="cd ~/src/wojtekmach/shipit"

# asdf
source $HOME/.asdf.sh
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# direnv
eval "$(direnv hook bash)"
