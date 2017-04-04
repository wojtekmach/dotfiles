function parse_git_branch {
  b=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"`
  if [ "$b" != "" ]; then
    echo "[$b]"
  fi
}

PS1="\$(wdalias)\[\e[1;32m\]\$(parse_git_branch)\[\e[0m\]% "

# exports
export EDITOR="vim"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# aliases
alias ..="cd .."
# git
alias gaa="git add --all "
alias gb="git branch "
alias gbc="git rev-parse --abbrev-ref HEAD "
alias gc="git commit --verbose "
alias gd="git diff "
alias gdh="git diff HEAD "
alias gl="git l "
alias gs="git status "
alias iexm="iex -S mix"
alias mps="iex -S mix phoenix.server"
# projects
alias dotfiles="cd ~/src/wojtekmach/dotfiles"
alias hex="cd ~/src/hexpm/hex"
alias hexpm="cd ~/src/hexpm/hexpm"
alias ecto="cd ~/src/elixir-ecto/ecto"
alias phoenix="cd ~/src/phoenixframework/phoenix"
alias cc="cd ~/src/clubcollect"
alias be="cd ~/src/clubcollect/billing-engine"
alias cb="cd ~/src/clubcollect/clubbase"

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# direnv
eval "$(direnv hook bash)"
