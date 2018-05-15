# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# custom prompt
STARTCOLOR='\[\033[0;34m\]'
YELLOW='\[\033[0;33m\]'
CYAN='\[\033[0;36m\]'
RED='\[\033[0;31m\]'
ENDCOLOR='\[\033[0;37m\]'
export PS1="$CYAN \u$YELLOW ◠◡ $STARTCOLOR\h $CYAN\W $YELLOW$ENDCOLOR"


# User specific aliases and functions

# mkdir, cd into it
mkcd () {
    mkdir -p "$*"
    cd "$*"
}

# General Aliases, Moving Around
alias hist='cat ~/.bash_history'
alias ..='cd ..'
alias cd..='cd ..'
alias fox='firefox --new-tab'
alias rbrc='. ~/.bashrc'
alias catbrc='cat ~/.bashrc'
alias catgit='cat ~/.gitconfig'
alias g='grep'
alias l='less'
alias doc='cd $HOME/Documents'
alias dw='cd $HOME/Downloads'
alias drp='cd $HOME/Dropbox'
alias drpd='~/.dropbox-dist/dropboxd &'

# two names for dotfiles dir :/
ls ~/.dotfiles >/dev/null 2>&1 && alias dot='cd ~/.dotfiles'
ls ~/dotfiles >/dev/null 2>&1 && alias dot='cd ~/dotfiles'

# planck
alias planck='cd $HOME/Documents/qmk_firmware/'
alias planck_build='sudo make planck/rev4:pondrejk:dfu'

# beaker ansible
alias bans='cd $HOME/Documents/beaker_ansible_devtools/beaker_ansible/'
alias bans-refresh='./beaker_ansible_inventory.rb -r'
alias bans-run='ansible-playbook ../../beaker_playbooks/basic-setup.yml -i beaker_ansible_inventory.rb'

# robotello
alias rob='cd $HOME/Documents/robottelo'
alias rci='cd $HOME/Documents/robottelo-ci'
alias nail='cd $HOME/Documents/nailgun'
alias at='cd $HOME/Documents/automation-tools'
alias gitk='gitk -a &'

# foreman
alias fm='cd $HOME/Documents/foreman'
alias fk='cd $HOME/Documents/forklift'
alias kat='cd $HOME/Documents/katello'

# docker
alias dockerkill='docker kill $(docker ps -q)'
alias dockerrm='docker rm -v $(docker ps -a -q -f status=exited)'
alias dockerrmi='docker rmi $(docker images -f "dangling=true" -q)'
alias dockerclean='dockerrm && dockerrmi'

# xclip settings
alias xclip='xclip -selection c'
alias pxclip='eval "$(fc -ln -1) | xclip"'

# report of commits from the last week
alias wreport='git lg --author=pondrejk --since=1.week'
alias glolx='git log "$1" | xclip -selection c'

# Batch convert pdf files to txt
alias pdftotextall='for file in *.pdf; do pdftotext "$file" "$file.txt"; done'

# grep history
alias hgrep='history|grep'

# required by libvirt-vagrant
export VAGRANT_DEFAULT_PROVIDER=libvirt

# acrobot login
alias acrobot='ssh tester@ccs-apps.gsslab.brq.redhat.com'

#django bash completion
source $HOME/.django_bash_completion.sh

# changing the path to virtualenvwrapper.sh depending on where it was installed by pip
source /usr/bin/virtualenvwrapper.sh
WORKON_HOME=~/Envs

# local server in currnt directory
alias server-here='http-server -a localhost -p 8000'

# make zip from directory
fzip () {
    zip -r $1.zip $1
}

# fuzzy finder setup
source /usr/share/fzf/shell/key-bindings.bash

# cheat alias and vars
alias ch='cheat'
export CHEAT_EDITOR='/usr/bin/vim'
export CHEATCOLORS=true

# ansible without cowsay
export ANSIBLE_NOCOWS=1
