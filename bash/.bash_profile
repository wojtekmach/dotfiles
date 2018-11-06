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
export MIX_ARCHIVES="$HOME/.mix/archives"
export MIX_ESCRIPTS="$HOME/.mix/escripts"

if [ -f $HOME/.cargo/env ]; then
  source $HOME/.cargo/env
fi

# aliases
alias vi="vim "
alias git="hub "
alias ..="cd .."
alias iex="iex -pa $MIX_ARCHIVES/**/ebin/ "
## git
alias git="hub "
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
alias bob="cd ~/src/hexpm/bob"
alias mini_repo="cd ~/src/hexpm/mini_repo"
alias hexpm="cd ~/src/hexpm/hexpm"
alias ecto="cd ~/src/elixir-ecto/ecto"
alias ecto_sql="cd ~/src/elixir-ecto/ecto_sql"
alias postgrex="cd ~/src/elixir-ecto/postgrex"
alias mariaex="cd ~/src/elixir-ecto/mariaex"
alias myxql="cd ~/src/elixir-ecto/myxql"
alias db_connection="cd ~/src/elixir-ecto/db_connection"
alias ecto="cd ~/src/elixir-ecto/ecto"
alias ectoplasma="cd ~/src/wojtekmach/ectoplasma"
alias plug="cd ~/src/elixir-plug/plug"
alias plug_cowboy="cd ~/src/elixir-plug/plug_cowboy"
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
source /usr/local/opt/asdf/asdf.sh
source $HOME/.asdf.sh
export PATH="$HOME/bin:$PATH"

# direnv
eval "$(direnv hook bash)"

if [ -f ~/.bash_profile.local ]; then
  . ~/.bash_profile.local
fi

export ERL_AFLAGS="-kernel shell_history enabled"
export GPG_TTY=$(tty)
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"

# bash-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[ -f /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash ] && . /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash
