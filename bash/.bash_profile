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
# export ECTO_EDITOR="itermvim"
export ELIXIR_EDITOR="itermvim +__LINE__ __FILE__"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/src/elixir-lang/elixir/.mix/escripts:$PATH"
export PATH=/Users/wojtek/.asdf/installs/elixir/1.3.4-otp-19/.mix/escripts:$PATH
export MIX_ARCHIVES="$HOME/.mix/archives"
export MIX_ESCRIPTS="$HOME/.mix/escripts"

if [ -f $HOME/.cargo/env ]; then
  source $HOME/.cargo/env
fi

# aliases
alias vi="vim "
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
alias gt="git tag -l --sort=-v:refname "
## elixir
alias iexm="iex -S mix"
alias iexs="iex -S mix server"
alias mps="iex -S mix phx.server"
alias mc="mix compile"
alias tm="MIX_ENV=test mix "
alias tmc="MIX_ENV=test mix compile "
alias xref="time mix compile.xref"
## projects
alias wojtekmach="cd ~/src/wojtekmach"
alias dotfiles="cd ~/src/wojtekmach/dotfiles"
alias hex="cd ~/src/hexpm/hex"
alias hex_core="cd ~/src/hexpm/hex_core"
alias hex_core_example="cd ~/src/hexpm/hex_core_example"
alias mini_repo="cd ~/src/hexpm/mini_repo"
alias hexpm="cd ~/src/hexpm/hexpm"
alias hexregistry="cd ~/src/hexpm/hex_registry"
alias ecto="cd ~/src/elixir-ecto/ecto"
alias ectoplasma="cd ~/src/wojtekmach/ectoplasma"
alias plug="cd ~/src/elixir-lang/plug"
alias phoenix="cd ~/src/phoenixframework/phoenix"
alias cd-elixir="cd ~/src/elixir-lang/elixir"
alias flow="cd ~/src/elixir-lang/flow"
alias gen_stage="cd ~/src/elixir-lang/gen_stage"
alias cd-rebar3="cd ~/src/erlang/rebar3"
alias cd-changelog="cd ~/src/wojtekmach/changelog"
alias foo="cd ~/src/elixir-lang/foo"
alias decimal="cd ~/src/other/decimal"
alias cd-erlang="cd ~/src/erlang/otp"
alias cd-ex_doc="cd ~/src/elixir-lang/ex_doc"
alias cd-shipit="cd ~/src/wojtekmach/shipit"
alias dotlocal="cd ~/src/wojtekmach/dotlocal"
alias resourceful="cd ~/src/wojtekmach/resourceful"

# asdf
source $HOME/.asdf.sh
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
. ~/.git-completion.bash
export PATH="$HOME/bin:$PATH"

# direnv
eval "$(direnv hook bash)"

if [ -f ~/.bash_profile.local ]; then
  . ~/.bash_profile.local
fi

export ERL_AFLAGS="-kernel shell_history enabled"
export GPG_TTY=$(tty)
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
