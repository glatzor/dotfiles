eval $(lesspipe)

# Use colors in the git prompt
export GIT_PS1_SHOWCOLORHINTS=1
# Append + for staged and * for unstaged changes
export GIT_PS1_SHOWDIRTYSTATE=1
# Append $ if there are stashed changes
export GIT_PS1_SHOWSTASHSTATE=1
# Append $ if there are untracked changes
#export GIT_PS1_SHOWUNTRACKEDFILES=1

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

function prompt_command() {
	export PS1='\[\033[0;33m\]\u@\h:\w\[\033[0m\]\$ '
	# Set the window title to the current user, hostname and working dir
	# Ignore my own user name for local shells
	if [ "${USER}" != "renate" -o ! -z "$SSH_CLIENT" ]; then
		echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"
	else 
		echo -ne "\033]0;${HOSTNAME}: ${PWD}\007"
		# Optionally include the git branch if we are located in a
		# git repository and not in the home directory
		GIT_DIR="$(git rev-parse --git-dir 2>/dev/null)"
		if [ -e /usr/bin/git -a "$PWD" != "$HOME" \
		     -a "$GIT_DIR" != "$HOME/.git" ]; then
			__git_ps1 '\[\033[0;33m\]\w\[\033[0m\]' \
				'\[\033[0m\]\$ ' '(%s)'
		else
			export PS1='\[\033[0;33m\]\w\[\033[0m\]\$ '
		fi
	fi
}
PROMPT_COMMAND="prompt_command"

alias ls="ls --color=tty"

export EMAIL="sebi@glatzor.de"
export DEBMAIL="devel@glatzor.de"

export PATH="~/bin:$PATH"

# The used mail indexer is required by the muttjump command
export MUTTJUMP_INDEXER="notmuch"

# Append commands to the bash history instead of replacing it on exit
shopt -s histappend
