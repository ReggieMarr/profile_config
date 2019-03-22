#
# ~/.bashrc
#



# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=$HOME/bin:$HOME/util:$PATH
if [ $(hostname) == localhost.localdomain ]; then
    export OPT_ROOT=/opt
else
    export OPT_ROOT=/opt/software
fi
export CPPUTEST_HOME=$OPT_ROOT/cpputest
#export CDPATH=":$HOME" # include $HOME in cd-able path
#export VIMRUNTIME=$HOME/.vim

# Check the window size and update LINES and COLUMNS after each command
shopt -s checkwinsize

# Correct minor spelling mistakes in cd command
shopt -s cdspell

# Load aliases
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Patch.py
export PATH=$HOME/git-tools:$PATH
# Allow for auto-tab-completion of commands proceeded by sudo.
complete -cf sudo

###############################################################################
# BASH HISTORY
#   see bash(1)
###############################################################################
HISTCONTROL=ignoreboth  # Ignore lines beginning with space and duplicates
HISTSIZE=1000           # Number of commands to remember in command history
HISTFILESIZE=2000       # Number of lines contained in history file
shopt -s histappend     # Append to the history file, don't overwrite it

###############################################################################
# GIT
###############################################################################
source ~/util/git-completion.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"

###############################################################################
# PROMPT STRINGS
###############################################################################
PS1='\n\[\e[1;32m\]\u@\h \[\e[1;0m\]\w\[\e[0m\]\[\e[1;30m\]'`
   `'$(__git_ps1 "[%s]")\[\e[1;0m\]\n$ '

###############################################################################
# FUNCTIONS
###############################################################################

# Set man page colors to make man pages more readable.
man () {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf  $1 ;;
            *.tbz2)     tar -jxvf  $1 ;;
            *.tar.gz)   tar -zxvf  $1 ;;
            *.tar.xz)   tar -xf    $1 ;;
            *.tgz)      tar -zxvf  $1 ;;
            *.tar)      tar -xvf   $1 ;;
            *.bz2)      bunzip2    $1 ;;
            *.gz)       gunzip     $1 ;;
            *.zip)      unzip      $1 ;;
            *.ZIP)      unzip      $1 ;;
            *.Z)        uncompress $1 ;;
            *)          echo "'$1' unknown format. Unable to extract." ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Added maint to the PATH
export PATH=$PATH:/home/rmarr/Projects/workRequests/bugfixes/release/
export PATH=$PATH:/home/rmarr/util/pymaint/
export CFGDB_DIR=~/cfgdb
#Added to use ngrok
export PATH=$PATH:/home/rmarr/Projects/dev-Ops/atlassianAutomation/ngrok

alias fdr="find . -regextype sed -regex"
alias fdg="-exec grep"

export JAVA_HOME=/usr/bin/javaJDK-Install/jdk1.8.0_171/
export PATH=$PATH:$JAVA_HOME/bin

# Virtual Environment Wrapper
source /usr/local/bin/virtualenvwrapper.sh
# Virtual Environment Wrapper
source /usr/local/bin/virtualenvwrapper.sh

#Code Sonar
export CSONAR=$OPT_ROOT/codesonar/codesonar-5.0p0
export PATH=$CSONAR/codesonar/bin:$PATH

#fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g !*.git -g !*.o -g !*.d'
eval $(thefuck --alias)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Custom Bash Functions
source ~/.bash_scripts

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in
# the .git/ folder)

