PS1="%~\$ "

alias ls="ls -G "

bindkey -s '\e[99~' ''
bindkey -s '\e[98~' ''
bindkey -s '\e[97~' ''

# prompt
function parse_git_branch {
  b=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"`
  if [ "$b" != "" ]; then
    echo "[\e[32m$b\e[0m]"
  fi
}
setopt PROMPT_SUBST
PROMPT='%~$(parse_git_branch)\$ '

# PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# mise
eval "$(mise activate zsh)"

# aliases
for i in ~/src/*; do
  name=${i:t}
  alias cd-$name="cd $i"
done

alias ls="ls -G "
alias ms="iex -S mix phx.server --open "

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

# .zshrc.local
if [ -f $HOME/.zshrc.local ]; then
  . $HOME/.zshrc.local
fi
