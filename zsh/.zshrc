# PROMPT

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

# rust

. $HOME/.cargo/env

# asdf

. $HOME/.local/share/asdf/asdf.sh
export KERL_BUILD_DOCS=yes

# PATH

export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/share/mix/escripts:$PATH
export PATH=$HOME/opt/google-cloud-sdk/bin:$PATH

export ERL_TOP=$HOME/src/otp
# export PATH=$HOME/Downloads/heroku/bin:$PATH
# export PATH=$HOME/.beamup/bin:$PATH

# Elixir

export MIX_XDG=true
export MIX_HOME=$HOME/.local/share/mix
export ERL_AFLAGS="-kernel shell_history enabled"
export EDITOR="vim"
export ELIXIR_EDITOR="itermvim +__LINE__ __FILE__"
export PLUG_EDITOR=$ELIXIR_EDITOR

# ALIASES

alias ..="cd .. " 
alias dashbit="cd ~/src/dashbit"
alias cd-elixir="cd ~/src/elixir"
alias cd-erlang="cd ~/src/otp"
alias cd-ex_doc="cd ~/src/ex_doc"

for i in hex hexpm hex_core hexdocs hexdiff hexpreview hexpm-ops bob \
  ecto ecto_sql myxql postgrex \
  phoenix phoenix_ecto phoenix_html phoenix_view phoenix_live_view phoenix_live_dashboard phoenix_pubsub \
  decimal mint finch \
  dotfiles; do
  alias ${i}="cd ~/src/${i}"
done

alias vimrc="cd ~/src/dotfiles && vim vim/.vimrc"
alias zshrc="cd ~/src/dotfiles && vim zsh/.zshrc"
alias ls="ls -G "
alias ms="iex -S mix phx.server "

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

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/wojtek/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/wojtek/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/wojtek/opt/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/wojtek/opt/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# eval "$(direnv hook zsh)"
export PATH=~/src/bazel/bazel-bin/src:$PATH
