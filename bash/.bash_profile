# .bash_profile
echo Hello, $LOGNAME!

# Get the aliases and functions
if [ -f "$HOME/.bashrc"]; then
	. "$HOME/.bashrc"
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

