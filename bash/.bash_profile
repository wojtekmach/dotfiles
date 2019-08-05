function parse_git_branch {
  b=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"`
  if [ "$b" != "" ]; then
    echo "[$b]"
  fi
}

if [ -n "$SSH_CLIENT" ]; then
  ps1_host="\h:"
else
  ps1_host=""
fi
PS1="$ps1_host\$(wdalias)\[\e[1;32m\]\$(parse_git_branch)\[\e[0m\]% "

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
export PATH="$HOME/src/elixir/.mix/escripts:$PATH"
export PATH="$HOME/src/elixir/bin:$PATH"
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
alias amend="git commit --amend --no-edit "
## elixir
alias iexm="iex -S mix"
alias iexs="iex -S mix server"
alias mps="iex -S mix phx.server"
alias mc="mix compile"
alias tm="MIX_ENV=test mix "
alias tmc="MIX_ENV=test mix compile "
alias xref="time mix compile.xref"
## projects

# elixir
alias cd-elixir="cd ~/src/elixir"
alias cd-ex_doc="cd ~/src/ex_doc"
alias decimal="cd ~/src/decimal"
alias flow="cd ~/src/flow"
alias gen_stage="cd ~/src/gen_stage"
# hexpm
alias bob="cd ~/src/bob"
alias hex="cd ~/src/hex"
alias hex_core="cd ~/src/hex_core"
alias hex_core_example="cd ~/src/hex_core_example"
alias hexpm-ops="cd ~/src/hexpm-ops"
alias hexpm="cd ~/src/hexpm"
alias hexdocs="cd ~/src/hexdocs"
alias mini_repo="cd ~/src/mini_repo"
# erlang
alias cd-erlang="cd ~/src/otp"
alias cd-rebar3="cd ~/src/rebar3"
# ecto
alias db_connection="cd ~/src/db_connection"
alias ecto="cd ~/src/ecto"
alias ecto_sql="cd ~/src/ecto_sql"
alias mariaex="cd ~/src/mariaex"
alias myxql="cd ~/src/myxql"
alias postgrex="cd ~/src/postgrex"
# plug & phoenix
alias phoenix="cd ~/src/phoenix"
alias phoenix_ecto="cd ~/src/phoenix_ecto"
alias phoenix_html="cd ~/src/phoenix_html"
alias plug="cd ~/src/plug"
alias plug_cowboy="cd ~/src/plug_cowboy"
# mine
alias cd-shipit="cd ~/src/shipit"
alias dotfiles="cd ~/src/dotfiles"
alias dotlocal="cd ~/src/dotlocal"
alias ectoplasma="cd ~/src/ectoplasma"
alias resourceful="cd ~/src/resourceful"
alias calendar_interval="cd ~/src/calendar_interval"
# other
alias mint="cd ~/src/mint"
alias lockscreen="pmset displaysleepnow "

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
. $HOME/.asdf/completions/asdf.bash
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

# asdf-erlang
export CFLAGS="-O2"
export KERL_CONFIGURE_OPTIONS="--enable-hipe
                               --disable-debug
                               --disable-silent-rules
                               --without-javac
                               --enable-shared-zlib
                               --enable-dynamic-ssl-lib
                               --enable-sctp
                               --enable-smp-support
                               --enable-threads
                               --enable-kernel-poll
                               --enable-darwin-64bit
                               --enable-gettimeofday-as-os-system-time
                               --enable-dirty-schedulers
                               --with-ssl=/usr/local/opt/openssl"

# asdf
. $HOME/.asdf/asdf.sh
