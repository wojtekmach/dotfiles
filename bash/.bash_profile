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
export ELIXIR_EDITOR="itermvim +__LINE__ __FILE__"
# export ECTO_EDITOR=$ELIXIR_EDITOR
export PLUG_EDITOR=$ELIXIR_EDITOR
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/src/elixir/.mix/escripts:$PATH"
export PATH="$HOME/src/elixir/bin:$PATH"
export MIX_ARCHIVES="$HOME/.mix/archives"
export MIX_ESCRIPTS="$HOME/.mix/escripts"
# export XDG_CONFIG_HOME=$HOME/.config
# export XDG_CACHE_HOME=$HOME/.cache
# export XDG_DATA_HOME=$HOME/.data

if [ -f $HOME/.cargo/env ]; then
  source $HOME/.cargo/env
fi

# aliases
alias vi="vim "
alias ..="cd .."
alias iex="iex -pa $MIX_ARCHIVES/**/ebin/ "
## git
alias g="hub "
alias git="hub "
alias gaa="g add --all "
alias gb="git branch "
alias gc="git commit --verbose "
alias gco="git checkout "
alias gcl="git add --all . && git reset --hard"
alias gd="git diff "
alias gdh="git diff HEAD "
alias g-="git checkout - "
alias gs="git status "
alias gbc="git rev-parse --abbrev-ref HEAD "
alias gl="git l "
alias gt="git tag -l --sort=-v:refname "
alias gamend="git commit --amend --no-edit "
alias greword="git commit --amend --no-verify "
alias gi="git issue"
alias gpr="git pr list"
# alias master="git checkout master "
# alias stash="git stash "
# alias unstash="git stash pop "
## elixir
alias iexmr="iex -S mix run"
# alias iexs="iex -S mix server"
# alias mps="iex -S mix phx.server"

## projects

# elixir
alias mc="m compile "
alias iexm="iex -S mix "
alias ms="iex -S mix phx.server "
alias tmc="MIX_ENV=test m compile "
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
alias phoenix_live_dashboard="cd ~/src/phoenix_live_dashboard"
alias phoenix_live_view="cd ~/src/phoenix_live_view"
alias plug="cd ~/src/plug"
alias plug_cowboy="cd ~/src/plug_cowboy"
# mine
alias cd-shipit="cd ~/src/shipit"
alias dotfiles="cd ~/src/dotfiles"
alias dotlocal="cd ~/src/dotlocal"
alias ectoplasma="cd ~/src/ectoplasma"
alias resourceful="cd ~/src/resourceful"
alias calendar_interval="cd ~/src/calendar_interval"
alias bash_profile="vi ~/.bash_profile"
alias bash_profile.local="vi ~/.bash_profile.local"
alias vimrc="vi ~/.vimrc"
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
# . $HOME/.asdf/completions/asdf.bash
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

# asdf-erlang
export CFLAGS="-O2"
export KERL_BUILD_DOCS=true
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
# . $HOME/.asdf/asdf.sh
source /usr/local/opt/asdf/asdf.sh

export BASH_SILENCE_DEPRECATION_WARNING=1

glg() {
  git log --oneline --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
