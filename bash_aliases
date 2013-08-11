# cd aliases
alias code="cd $HOME/Code"
alias vendor="cd $HOME/Code/vendor"
alias dotfiles="cd $HOME/Code/vendor/dotfiles"
alias vendor-rails="cd $HOME/Code/vendor/rails"
alias vendor-ruby="cd $HOME/Code/vendor/ruby"

# git
alias g="git"
alias gs="git status"
alias gl="git l"
alias gd="git diff --color"
alias gdw="git diff --color --word-diff=color"
alias gdh="git diff --color --cached"
alias gdhw="gdh --word-diff=color"
alias gdc="git diff --cached"
alias gc="git commit --verbose"
alias gm="gs -m"
alias gb="git branch"
alias ga="git add"
alias gap="git add -p"
alias gaa="git add --all"
alias gaap="git add --all -p"
alias push="git push"
alias pull="git pull --ff-only"
alias pullr="git pull --rebase"
alias co="git checkout"

# rails
alias tt="touch tmp/restart.txt"
alias tfd="tail -f log/development.log"
alias tft="tail -f log/test.log"
alias tfp="tail -f log/production.log"
alias be="bundle exec"
alias bers="bundle exec rspec"
alias rt="ruby -Itest"

# utils
alias tf="tail -f"
alias ..="cd .."
alias v="vim"
alias e="vim"
alias 9="kill -9"
alias p9="pkill -9 -f"
alias cl=clear
alias irbc="irb -r irb/completion"
alias xargs="xargs "

alias ls="ls -CFG"
alias lsh="ls -l --human-readable"
alias lss="du -sh"
alias cb=clipboard
alias unrare="unrar e -kb -o+"
alias mount.iso="mount -t iso9660 -o loop"

alias time="time "
alias frspec="FAST_SPEC=1 rspec"
alias pyg=pygmentize
