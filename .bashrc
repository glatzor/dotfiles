# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Use colors in the git prompt
export GIT_PS1_SHOWCOLORHINTS=1
# Append + for staged and * for unstaged changes
export GIT_PS1_SHOWDIRTYSTATE=1
# Append $ if there are stashed changes
export GIT_PS1_SHOWSTASHSTATE=1
# Append $ if there are untracked changes
#export GIT_PS1_SHOWUNTRACKEDFILES=1

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	COLOR_CHROOT="\[\033[1;30m\]"
	COLOR_USER="\[\033[0;33m\]"
	COLOR_DEFAULT="\[\033[0m\]"
else
	COLOR_CHROOT=
	COLOR_USER=
	COLOR_DEFAULT=
fi

function prompt_command() {
	# Set the window title to the current user, hostname and working dir
	# Ignore my own user name for local shells
	if [ "${USER}" != "renate" -o ! -z "$SSH_CLIENT" ]; then
		PROMPT="\u@\h:\w"
		TITLE="${USER}@${HOSTNAME} : ${PWD}"
	else 
		PROMPT="\w"
		TITLE="${HOSTNAME} : ${PWD}"
	fi
	if [ "${TERM}" != "linux" ]; then
		echo -ne "\033]0;${TITLE}\007"
	fi
	# Optionally include the git branch if we are located in a
	# git repository and not in the home directory
	GIT_DIR="$(git rev-parse --git-dir 2>/dev/null)"
	if [ -e /usr/bin/git -a "$PWD" != "$HOME" \
	     -a "$GIT_DIR" != "$HOME/.git" ]; then
		__git_ps1 "\[\033[0;33m\]${PROMPT}\033[0m\]" \
			"\[\033[0m\]\$ " "(%s)"
	else
		export PS1="\[\033[0;33m\]${PROMPT}\033[0m\]\$ "
	fi
	unset TITLE PROMPT
}
PROMPT_COMMAND="prompt_command"

# Aliases
alias ls="ls --color=tty"
alias wkhal="khal calendar --days 7"

export EMAIL="sebi@glatzor.de"
export DEBMAIL="devel@glatzor.de"

export PATH="~$HOME/.local/bin:$PATH"

# The used mail indexer is required by the muttjump command
export MUTTJUMP_INDEXER="notmuch"

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# Append commands to the bash history instead of replacing it on exit
shopt -s histappend

# Use nice fonts in Java
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

eval `dircolors $HOME/.3rdparty/dircolors-solarized/dircolors.ansi-dark`

# Store passwords in the primary X selection
export PASSWORD_STORE_X_SELECTION=pri
