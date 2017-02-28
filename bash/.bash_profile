function parse_git_branch {
  b=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"`
  if [ "$b" != "" ]; then
    echo "[$b]"
  fi
}

PS1="\$(wdalias)\[\e[1;32m\]\$(parse_git_branch)\[\e[0m\]% "

export PATH="$HOME/bin:$PATH"

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
alias mps="iex -S mix phoenix.server"
# projects
alias dotfiles="cd ~/src/wojtekmach/dotfiles"
alias hexpm="cd ~/src/hexpm"
alias hex_web="cd ~/src/hexpm/hex_web"
alias ecto="cd ~/src/elixir-ecto/ecto"
alias be="cd ~/src/clubcollect/billing-engine"
alias cb="cd ~/src/clubcollect/clubbase"

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# direnv
eval "$(direnv hook bash)"
