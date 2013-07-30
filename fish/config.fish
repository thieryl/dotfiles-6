# fish path {{{
set -x FISH ~/.config/fish
# }}}
# binary files are here {{{
set -x PATH ~/dotfiles/bin
set -x PATH $PATH ~/dotfiles/bin/local
set -x PATH $PATH /usr/local/bin
set -x PATH $PATH /usr/bin
set -x PATH $PATH /bin
set -x PATH $PATH /usr/sbin
set -x PATH $PATH /sbin
# }}}
# ENV variables{{{
setenv EDITOR vim
# }}}
# bin path in home {{{
set -x HOME_BIN_PATH ~/bin
# }}}
# alias {{{
# sudo
alias s='sudo'
alias yum='sudo yum'
alias apt-get='sudo apt-get'
alias pacman='sudo pacman'
alias service='sudo service'
alias systemctl='sudo systemctl'
alias swapoff='sudo swapoff'
alias swapon='sudo swapon'
# python
alias p2='python2'
alias p3='python3'
# vim
alias vi='vim'
# wget
alias wget='wget -c'
# }}}
