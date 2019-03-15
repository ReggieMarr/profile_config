#
# ~/.bash_aliases
# also used for zsh
#
eval $(thefuck --alias fuck)
# Safeguarding aliases to confirm file changes
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ls='ls --color=auto'
alias vi='/usr/bin/vim'
alias l='ls -Al'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'

# Passing aliases when using sudo
alias sudo='sudo '

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && \
        eval "$(dircolors -b ~/.dircolors)" || \
        eval "$(dircolors -b)"

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias grep='grep -n -B 4 -A 4 --colour --exclude tags'

# bash env agnostic exports
#export FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS="--reverse --inline-info --height=30"
export FZF_COMPLETION_TRIGGER=']]'
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
# Custom Aliases
alias fsearch='rg . -n | fzf --preview="echo {} | cut -d ":" -f1 |xargs cat "'
alias vfsearch='vi $(fsearch)'
alias fcheck='git_checkout $(git branch | fzf)'
alias rcheck='git_checkout $(git branch -r | fzf)'
alias ncheck='git checkout'
alias rebase='git_rebase'
alias commit='git_commit_message'
alias fixup='git_commit_fixup'
alias cloneHome='git_clone'
alias mi='maint_ip'
alias pull='git pull -p'
alias nn='nvim'
alias nf='nvim $(fzf)'
alias vf='vim $(fzf --preview="cat {}")'
alias asource='source ~/.bashrc;source ~/.zshrc'
alias update='sudo apt update && sudo apt upgrade -y'
alias fbit='git lg | fzf'
