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
alias dev='cd $HOME/Documents/develsetup'
alias drp='cd $HOME/Dropbox'
alias q='cd $HOME/Documents/QE'
alias drpd='~/.dropbox-dist/dropboxd &'
alias sc='cd $HOME/Documents/scripts'
alias fam='cd $HOME/Documents/foreman-ansible-modules'

alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias ports='netstat -tulanp'
alias calc='bc -l -q'

# two names for dotfiles dir :/
ls ~/.dotfiles >/dev/null 2>&1 && alias dot='cd ~/.dotfiles'
ls ~/dotfiles >/dev/null 2>&1 && alias dot='cd ~/dotfiles'

# planck
alias planck='cd $HOME/Documents/qmk_firmware/'
alias planck_build='sudo make planck/rev4:pondrejk:dfu'

# robotello
alias rob='cd $HOME/Documents/robottelo'
alias rci='cd $HOME/Documents/robottelo-ci'
alias nail='cd $HOME/Documents/nailgun'
alias air='cd $HOME/Documents/airgun'
alias testfm='cd $HOME/Documents/testfm'
alias at='cd $HOME/Documents/automation-tools'
alias gitk='gitk -a &'

# projects
alias prj='cd $HOME/Documents/PROJECTS'
alias site='cd $HOME/Documents/PROJECTS/pondrejk.net'
alias lex='cd $HOME/Documents/PROJECTS/LEXICS'
alias elw='cd $HOME/Documents/PROJECTS/elwar-source'
alias ink='cd $HOME/Documents/PROJECTS/InkVisitor'
alias ehr='cd $HOME/Documents/PROJECTS/early-heresy-map'

# ssh
alias sshr='ssh -AX -l root -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

# git
alias g-="git checkout -"
alias gpm="git pull --rebase upstream master"

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

# taskwarrior
alias t='task'

# required by libvirt-vagrant
export VAGRANT_DEFAULT_PROVIDER=libvirt

# changing the path to virtualenvwrapper.sh depending on where it was installed by pip
source /usr/local/bin/virtualenvwrapper.sh
WORKON_HOME=~/Envs

# local server in current directory, accepts optional port argument
server_here () {
  if [ $# -eq 0 ]; then
    http-server -a localhost -p 8000
  else
    http-server -a localhost -p $1
  fi
}

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

# del from line, expects input "path:line"
rmln () {
  IFS=':' read -ra ADDR <<< "$1"
  sed -i -e "${ADDR[1]}d" "${ADDR[0]}"
}

# fetch open PR branch and checkout to it
ghpr () {
  git fetch upstream pull/$1/head:$1
  git checkout $1
}

# quick jira-cli acces
jira () {
  cd $HOME/Documents/jira_ticket_cli
  workon jira-ticket-master
}

# quick satlab
satlab () {
  cd $HOME/Documents/satlab-ansible
  workon satlab-deploy
}

# quick broker
brk () {
  cd $HOME/Documents/broker
  workon broker
}

# quick label studio
label () {
  cd $HOME/Documents/QE/labeling-experiment
  workon labelstudio
  label-studio start
}

# quick uef server 
uef () {
  workon uef
  uvicorn main:app --reload
}

cobr () {
  git fetch upstream $1
  git branch --track $1 upstream/$1
}

# which host is tested
alias ho="yq e '.server.hostnames' settings.local.yaml"

# vimx allows copying to clipboard from cmdline
# alias vim='vimx'
alias vim='nvim'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export EDITOR=/usr/bin/vim
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION=us-east5
export ANTHROPIC_VERTEX_PROJECT_ID=itpc-gcp-core-pe-eng-claude
export PATH=$PATH:$HOME/.npm-global/bin
