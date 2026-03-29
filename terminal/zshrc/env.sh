[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Tools
command -v fzf &>/dev/null && eval "$(fzf --zsh)"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
command -v mise &>/dev/null && eval "$(mise activate zsh)"
command -v starship &>/dev/null && eval "$(starship init zsh)"

# Envars
export GIT_EDITOR=nvim
export EDITOR=nvim
export PATH=$PATH:$HOME/.local/bin
