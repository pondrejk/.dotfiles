# silence bash deprecation
export BASH_SILENCE_DEPRECATION_WARNING=1

# custom prompt
setopt PROMPT_SUBST
PROMPT='%F{yellow}◠◡%f %F{cyan}%1d%f '

# Custom completions dir

typeset -gaU fpath=($fpath /Users/pondrejk/.zsh_completions)

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
alias ll='ls -la'
alias rzrc='. ~/.zshrc'
alias catzrc='cat ~/.zshrc'
alias catgit='cat ~/.gitconfig'
alias g='grep'
alias l='less'
alias doc='cd $HOME/Documents'
alias dw='cd $HOME/Downloads'
alias dot='cd $HOME/.dotfiles'
alias drp='cd $HOME/Dropbox'
alias q='cd $HOME/Documents/QE'

alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# planck
alias planck='cd $HOME/Documents/qmk_firmware/'
alias planck_build='sudo make planck/rev4:pondrejk:dfu'

# robotello
alias rob='cd $HOME/Documents/robottelo'
alias rci='cd $HOME/Documents/robottelo-ci'
alias nail='cd $HOME/Documents/nailgun'
alias air='cd $HOME/Documents/airgun'
alias at='cd $HOME/Documents/automation-tools'
alias gitk='gitk -a &'

# projects
alias prj='cd $HOME/Documents/PROJECTS'

# ssh
alias sshr='ssh -AX -l root -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

# git
alias g-="git checkout -"
alias gpm="git pull --rebase upstream master"

# foreman
alias fm='cd $HOME/Documents/foreman'
alias fk='cd $HOME/Documents/forklift'
alias kat='cd $HOME/Documents/katello'

# podman
alias podmankill='podman kill $(podman ps -q)'
alias podmanrm='podman rm -v $(podman ps -a -q -f status=exited)'
alias podmanrmi='podman rmi $(podman images -f "dangling=true" -q)'
alias podmanclean='podmanrm && podmanrmi'

# report of commits from the last week
alias wreport='git lg --author=pondrejk --since=1.week'

# grep history
alias hgrep='history|grep'

# taskwarrior
alias t='task'

# required by libvirt-vagrant
export VAGRANT_DEFAULT_PROVIDER=libvirt

# changing the path to virtualenvwrapper.sh depending on where it was installed by pip
source ~/virtualenvwrapper.sh
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
source <(fzf --zsh)

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

gitapply () {
 curl $1 | git apply
}

# which host is tested
alias ho="yq e '.server.hostnames' settings.local.yaml"

# robottelo logs
alias rlogs="tail -f logs/*"

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

eval "$(~/.local/bin/mise activate)"

source ~/.zsh_env_files

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pondrejk/Documents/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/pondrejk/Documents/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pondrejk/Documents/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/pondrejk/Documents/google-cloud-sdk/completion.zsh.inc'; fi
[ -f "/Users/pondrejk/.config/claude-code-vertex/env.sh" ] && . "/Users/pondrejk/.config/claude-code-vertex/env.sh"
