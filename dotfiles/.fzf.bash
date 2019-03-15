# Setup fzf
# ---------
if [[ ! "$PATH" == */home/reggiemarr/.fzf/bin* ]]; then
  export PATH="$PATH:$HOME.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME.fzf/shell/key-bindings.bash"

