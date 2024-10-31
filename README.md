# Dotfiles

Some of my config files

## Intallation
From a clean ubuntu install, follow the steps below

### 1. Install the following packages
- git
- brew
- zoxide
- ag
- neofetch
- flatpak
- thefuck
- ripgrep
- nodejs

### Alias python3 -> python

```bash
ln -s $(which python3) ~/.local/bin/python
```

### 2. Create aliases for zsh
-   ~/.zshrc -> configs/terminal/.zshrc
-   ~/zshrc -> configs/terminal/zshrc

### 3. Install zsh and make it the default shell

### 4. Follow the instructions given by .zshrc

### 5. Create aliases for wezterm
-   ~/.wezterm.lua -> configs/terminal/wezterm/.wezterm.lua

### 6. Install wezterm

### 7. Theme Grub with https://github.com/catppuccin/grub

## Usage

Create symbolic links in ~ for

For Zsh, create the following symbolic links
-   ~/.zshrc -> configs/terminal/.zshrc
-   ~/zshrc -> configs/terminal/zshrc


For Git, create the following symbolic links
-   ~/.gitconfig -> configs/git/.gitconfig
-   ~/.gitignore -> configs/git/.gitignore

For NeoVim, create the following symbolic links

-   ~/.config/nvim/init.lua -> configs/nvim/init.lua
-   ~/.config/nvim/lua -> configs/nvim/lua

For WezTerm, create the following symbolic links
-   ~/.wezterm.lua -> configs/terminal/wezterm/.wezterm.lua

For Tmux, create the following symbolic links
-   ~/.tmux.conf -> configs/terminal/.tmux/.tmux.conf
-   ~/.tmux.conf.local -> configs/terminal/.tmux/.tmux.conf.local

### How to create a symbolic link

https://linuxize.com/post/how-to-create-symbolic-links-in-linux-using-the-ln-command/
