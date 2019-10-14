# .bash_profile
echo Hello, $LOGNAME!

# Get the aliases and functions
if [ -f "$HOME/.bashrc"]; then
	. "$HOME/.bashrc"
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
