# git
alias g="git"
alias gs="git status"
alias gl="git log --color"
alias gd="git diff --color"
alias gdh="git diff --color HEAD"
alias gc="git commit"
alias gm="git commit -m"

# ruby
alias r="rake"

# rails
alias t="touch tmp/restart.txt"
alias td="tail -f log/development.log"
alias bers="bundle exec rspec"
alias rt="ruby -Itest"

# utils
alias c="cd"
alias ..="cd .."
alias v="vim"
alias e="vim"
alias 9="kill -9"
alias cl=clear
alias irbc="irb -r irb/completion"
alias lsh="ls -l --human-readable"
alias lss="du -sh"
alias cb=clipboard
alias unrare="unrar e -kb -o+"
alias mount.iso="mount -t iso9660 -o loop"

if [ `uname -s` == "Darwin" ]; then
  alias l="ls -CFG"
else
  alias l="ls -CF --color=auto"
fi
