if [ -f $HOME/.bash_aliases ]; then
  source $HOME/.bash_aliases
fi

# git - http://www.jukie.net/~bart/blog/20071219221358
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions
setopt prompt_subst
export __CURRENT_GIT_BRANCH=
parse_git_branch() {
  git-branch --no-color 2> /dev/null \
  | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) -- /'
}
preexec_functions+='zsh_preexec_update_git_vars'
zsh_preexec_update_git_vars() {
  case "$(history $HISTCMD)" in 
      *git*)
      export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
      ;;
  esac
}
chpwd_functions+='zsh_chpwd_update_git_vars'
zsh_chpwd_update_git_vars() {
  export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
}
get_git_prompt_info() {
  echo $__CURRENT_GIT_BRANCH
}

export PROMPT="%~$(get_git_prompt_info)%% "
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

set -o vi

if [ -f $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi

if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi
