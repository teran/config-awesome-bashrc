export MYSQL_PS1="\u@"`hostname -s`" [\d]> "

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

HOST=`hostname -f | cut -f1 -d.`
DOMAIN=`hostname -f | cut -f2 -d.`
COLOR_HOST="38;5;27"
COLOR_DOMAIN="38;5;102"
[ -f ~/.prompt_colors ] && . ~/.prompt_colors
if [ "X$OVERRIDE_PS1" != "X" ]; then
        export PS1=$OVERRIDE_PS1
else
	if [ "$TERM" = "xterm" ]; then
        	export PS1="\[\e[${COLOR_HOST}m\]${HOST}\[\e[${COLOR_DOMAIN}m\].${DOMAIN}\[\e[0m\]:\w\\$ "
    		PS1="\[\033]2;${HOST}.${DOMAIN}:\w\007\]$PS1"
	else
		PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	fi
fi

case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
fi

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

