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

# PATH

export PATH=$HOME/src/otp/release/bin:$PATH
# export PATH=$HOME/opt/erlang/current/bin:$PATH
# alias switch-erlang=$HOME/opt/erlang/switch-erlang
export PATH=$HOME/src/elixir/bin:$PATH
export PATH=$HOME/bin:$PATH

if [ -d /Applications/Postgres.app ]; then
  export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH
fi

# export ERL_TOP=$HOME/src/otp
# export PATH=$HOME/Downloads/heroku/bin:$PATH
# export PATH=$HOME/.beamup/bin:$PATH

# Elixir

export MIX_XDG=true
export ERL_AFLAGS="-kernel shell_history enabled"
export EDITOR="vim"
export ELIXIR_EDITOR="itermvim +__LINE__ __FILE__"
export PLUG_EDITOR=$ELIXIR_EDITOR

# ALIASES

if which ag > /dev/null; then
  alias rg="ag "
fi

if which hub > /dev/null; then
  alias git="hub "
fi

alias ls="ls -G "
alias ms="iex -S mix phx.server "
alias dashbit="cd ~/src/dashbit"
alias cd-elixir="cd ~/src/elixir"
alias cd-erlang="cd ~/src/otp"
alias hex="cd ~/src/hex"
alias hexpm="cd ~/src/hexpm"
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

