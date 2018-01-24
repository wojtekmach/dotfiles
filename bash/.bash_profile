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
export PATH="$HOME/.mix:$PATH"
export MIX_ARCHIVES="$HOME/.mix/archives"

# aliases
alias ..="cd .."
alias iex="iex -pa $MIX_ARCHIVES/**/ebin/ "
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
alias mps="[ -d assets ] && iex -S mix phx.server || iex -S mix phoenix.server"
alias mc="mix compile"
alias tm="MIX_ENV=test mix "
alias tmc="MIX_ENV=test mix compile "
alias xref="time mix compile.xref"
## projects
alias wojtekmach="cd ~/src/wojtekmach"
alias dotfiles="cd ~/src/wojtekmach/dotfiles"
alias hex="cd ~/src/hexpm/hex"
alias mini_hex="cd ~/src/hexpm/mini_hex"
alias hexpm="cd ~/src/hexpm/hexpm"
alias hextar="cd ~/src/hexpm/hex_tar"
alias hexregistry="cd ~/src/hexpm/hex_registry"
alias ecto="cd ~/src/elixir-ecto/ecto"
alias plug="cd ~/src/elixir-lang/plug"
alias phoenix="cd ~/src/phoenixframework/phoenix"
alias cd-elixir="cd ~/src/elixir-lang/elixir"
alias foo="cd ~/src/elixir-lang/foo"
alias cd-erlang="cd ~/src/erlang/otp"
alias cd-ex_doc="cd ~/src/elixir-lang/ex_doc"
alias shipit="cd ~/src/wojtekmach/shipit"

# asdf
source $HOME/.asdf.sh
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# direnv
eval "$(direnv hook bash)"

if [ -f ~/.bash_profile.local ]; then
  . ~/.bash_profile.local
fi

export ERL_AFLAGS="-kernel shell_history enabled"
export EDITOR=subl
