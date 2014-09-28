# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Prompt
if [[ $COLORTERM = xfce4-* && $TERM = xterm  ]]  && infocmp xfce4-256color >/dev/null 2>&1; then
    TERM=xfce4-256color;
else
    TERM=xterm-256color;
fi
if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256  ]] 2>/dev/null; then
        BASE03=$(tput setaf 234)
        BASE02=$(tput setaf 235)
        BASE01=$(tput setaf 240)
        BASE00=$(tput setaf 241)
        BASE0=$(tput setaf 244)
        BASE1=$(tput setaf 245)
        BASE2=$(tput setaf 254)
        BASE3=$(tput setaf 230)
        YELLOW=$(tput setaf 136)
        ORANGE=$(tput setaf 166)
        RED=$(tput setaf 160)
        MAGENTA=$(tput setaf 125)
        VIOLET=$(tput setaf 61)
        BLUE=$(tput setaf 33)
        CYAN=$(tput setaf 37)
        GREEN=$(tput setaf 64)
    else
        BASE03=$(tput setaf 8)
        BASE02=$(tput setaf 0)
        BASE01=$(tput setaf 10)
        BASE00=$(tput setaf 11)
        BASE0=$(tput setaf 12)
        BASE1=$(tput setaf 14)
        BASE2=$(tput setaf 7)
        BASE3=$(tput setaf 15)
        YELLOW=$(tput setaf 3)
        ORANGE=$(tput setaf 9)
        RED=$(tput setaf 1)
        MAGENTA=$(tput setaf 5)
        VIOLET=$(tput setaf 13)
        BLUE=$(tput setaf 4)
        CYAN=$(tput setaf 6)
        GREEN=$(tput setaf 2)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    # Linux console colors. I don't have the energy
    # to figure out the Solarized values
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

parse_git_branch () {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/*\ \(.*\)/\1/"
}
render_git_status () {
    STATUS=""
    CHANGES=""
    if [[ -n $(git branch 2> /dev/null) ]]; then
        if [[ -n $(parse_git_dirty) ]]; then
            STATUS=$STATUS"$RED($(parse_git_branch)"
            [[ $(git status -s | grep '??' | wc -l) -gt 0 ]] && CHANGES=$CHANGES$GREEN"+$(git status -s | grep '??' | wc -l)"
            [[ $(git status -s | grep 'M' | wc -l) -gt 0 ]] && CHANGES=$CHANGES$YELLOW"+$(git status -s | grep 'M' | wc -l)"
            [[ $(git status -s | grep 'D' | wc -l) -gt 0 ]] && CHANGES=$CHANGES$RED"-$(git status -s | grep 'D' | wc -l)"
            STATUS=$STATUS"$RED"
        else
            STATUS=$STATUS"$GREEN($(parse_git_branch)$GREEN"
        fi
        [[ ${#CHANGES} -gt 0 ]] && STATUS=$STATUS" $CHANGES"
        echo $STATUS")"
    fi
}

PS1="\[${GREEN}\][\[${VIOLET}\]\A\[${GREEN}\]][\[${CYAN}\]\u@\h:\[$ORANGE\]\w\[${GREEN}\]]\[$BASE0\]\$(render_git_status)\[$GREEN\] \$ \[$RESET\]"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Bash Git
if [ -f /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
fi
