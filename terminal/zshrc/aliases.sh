# [[ ALIASES ]]

# Editors
alias v="nvim"
n() { if [ "$#" -eq 0 ]; then command nvim . ; else command nvim "$@"; fi; }

# File system (eza)
if command -v eza &>/dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias la='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
fi

# Navigation
alias cd="z"
alias ..='cd ..'
alias ...='cd ../..'

# Tools
alias t='tmux attach || tmux new -s Work'
alias d='docker'
alias c='opencode'
alias cx='printf "\033[2J\033[3J\033[H" && claude --allow-dangerously-skip-permissions'
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias please="sudo"

# FZF
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias eff='$EDITOR "$(ff)"'

# Open files
open() ( xdg-open "$@" >/dev/null 2>&1 & )
