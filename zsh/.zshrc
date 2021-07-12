# prompt
function parse_git_branch {
  b=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"`
  if [ "$b" != "" ]; then
    echo "[\e[32m$b\e[0m]"
  fi
}

if [ -n "$SSH_CLIENT" ]; then
  prompt_host="%m:"
else
  prompt_host=""
fi

setopt PROMPT_SUBST
PROMPT='$prompt_host%~$(parse_git_branch)%# '

# brew
if [ -d /opt/homebrew ]; then
  export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
  export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
  . $(brew --prefix asdf)/asdf.sh
fi

# kerl
export KERL_CONFIGURE_OPTIONS="--without-jinterface --without-odbc --without-hipe"
export KERL_BUILD_DOCS=yes

# PATH
export PATH=$HOME/bin:$PATH
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH
export PATH=/Applications/CMake.app/Contents/bin:$PATH

if [ -d /usr/local/Caskroom/google-cloud-sdk/ ]; then
  . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi

export ERL_TOP=$HOME/src/otp

# Elixir
export MIX_XDG=true
export MIX_HOME=$HOME/.local/share/mix
export PATH=$MIX_HOME/escripts:$PATH
export ERL_AFLAGS="-kernel shell_history enabled"
export EDITOR="vim"
export ELIXIR_EDITOR="itermvim +__LINE__ __FILE__"
export PLUG_EDITOR=$ELIXIR_EDITOR

# aliases
alias ..="cd .. "
alias cd-elixir="cd ~/src/elixir"
alias cd-erlang="cd ~/src/otp"
alias cd-ex_doc="cd ~/src/ex_doc"
alias cd-zig="cd ~/src/zig"
alias cd-livebook="cd ~/src/livebook"
alias cd-beam-build="cd ~/src/beam-build"
alias cd-beam-exe="cd ~/src/beam-exe"
alias cd-beam-run="cd ~/src/beam-run"

for i in \
  hex hexpm hex_core hexdocs hexdiff hexpreview hexpm-ops bob \
  ecto ecto_sql myxql postgrex connection db_connection \
  phoenix phoenix_ecto phoenix_html phoenix_view phoenix_live_view phoenix_live_dashboard phoenix_pubsub \
  decimal mint finch dashbit kino \
  dotfiles \
; do
  alias ${i}="cd ~/src/${i}"
done

alias vimrc="sh -c 'cd ~/src/dotfiles && vim vim/.vimrc'"
alias zshrc="cd ~/src/dotfiles && vim zsh/.zshrc"
alias ls="ls -G "
alias ms="iex -S mix phx.server "
alias rg="rg --hidden --glob '!.git' "

# livebook
alias notebooks="livebook server --open --root-path ~/src/notebooks"
alias private_notebooks="livebook server --open --root-path ~/src/private_notebooks"

# git
alias gaa="git add --all "
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
alias gpush="git push "

# custom

if [ -f $HOME/.zshrc.local ]; then
  . $HOME/.zshrc.local
fi
