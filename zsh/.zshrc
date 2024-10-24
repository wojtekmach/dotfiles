# prompt
function parse_git_branch {
  b=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"`
  if [ "$b" != "" ]; then
    echo "[\e[32m$b\e[0m]"
  fi
}

os=`uname -mv`
if echo $os | grep --silent "ARM64_T8101 x86_64"; then
  prompt_rosetta="(rosetta)"
else
  prompt_rosetta=""
fi

if [[ -n "${SSH_CLIENT}" ]]; then
  prompt_host="$(hostname):"
else
  prompt_host=""
fi

setopt PROMPT_SUBST
PROMPT='$prompt_rosetta$prompt_host%~$(parse_git_branch)%# '

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
# export ELIXIR_EDITOR="zed __LINE__:__FILE__"
export PLUG_EDITOR=$ELIXIR_EDITOR
export HEX_DIFF_COMMAND="git diff --color=always --no-index __PATH1__ __PATH2__"

# aliases
alias mba="mosh --server=/opt/homebrew/bin/mosh-server macbook-air-wojtek.local "
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# aliases directories
alias ..="cd .. "
alias ...="cd ../.."
alias cd-elixir="cd ~/src/elixir"
alias cd-ex_doc="cd ~/src/ex_doc"
alias cd-zig="cd ~/src/zig"
alias cd-livebook="cd ~/src/livebook"
alias cd-beam-build="cd ~/src/beam-build"
alias cd-beam-exe="cd ~/src/beam-exe"
alias cd-beam-run="cd ~/src/beam-run"
alias cd-rebar3="cd ~/src/rebar3"
alias cd-reqbin="cd ~/src/reqbin"

for i in \
  hex hexpm hex_core hexdocs hexdiff hexpreview hexpm-ops bob \
  ecto ecto_sql myxql postgrex tds connection db_connection \
  phoenix phoenix_{ecto,html,view,live_view,live_dashboard,live_reload,pubsub,playground} \
  plug plug_crypto \
  nimble_{csv,options,parsec,pool,publisher,totp,ownership} mox \
  lt \
  decimal mint finch dashbit kino goth \
  otp \
  req req_{athena,bigquery,github_oauth,hex,s3} \
  dotfiles mix_install_examples max easyxml easyhtml \
; do
  alias ${i}="cd ~/src/${i}"
done

alias vimrc="sh -c 'cd ~/src/dotfiles && vim vim/.vimrc'"
alias zshrc="cd ~/src/dotfiles && vim zsh/.zshrc"
alias ls="ls -G "
alias ms="iex -S mix phx.server --open "
alias i="iex --dot-iex '' "
alias rg="rg --hidden --glob '!.git' "
alias tarx="tar xzvf "
alias tarc="tar czvf "

# aliases livebook
alias notebooks="livebook server ~/src/notebooks"
alias private_notebooks="livebook server ~/src/private_notebooks"

# aliases git
alias g-="git switch - "
alias gaa="git add --all "
alias gamend="git commit --amend --no-edit "
alias gb="git branch "
alias gbc="git rev-parse --abbrev-ref HEAD "
alias gc="git commit --verbose "
alias gcl="git add --all . && git reset --hard"
alias gco="git checkout "
alias gd="git diff "
alias gdh="git diff HEAD "
alias gl="git l "
alias gpush="git push "
alias greword="git commit --amend --no-verify "
alias gs="git status "
alias gsw="git switch "
alias gt="git tag -l --sort=-v:refname "

# custom
if [ -f $HOME/.zshrc.local ]; then
  . $HOME/.zshrc.local
fi

# gcloud
if [ -d /opt/homebrew/Caskroom/google-cloud-sdk ]; then
  source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi
eval "$(~/bin/rtx activate zsh)"

. "/Users/wojtek/.local/share/rtx/installs/rust/1.78.0/env"
