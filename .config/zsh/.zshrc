# Path to your oh-my-zsh installation.
# export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export SHELL="zsh"
export TERM="xterm-256color"

export ZSH="$HOME/.local/share/oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/zsh"

export HISTFILE="$HOME/.cache/zsh/zhistory"

TIMEFMT=$'\ncmd\t%J\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P\ntotal\t%*E'

ZSH_THEME="jaderbrasil"

plugins=(
    git
    zsh-syntax-highlighting
    vi-mode
    zsh-completions
    haskell
    rustup
)

# zsh-completions
autoload -U compinit && compinit

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# git my dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias vifm='~/.config/vifm/scripts/vifmrun'

export PATH="$GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin:$HOME/.cabal/bin:$PATH:$HOME/.local/share/cargo/bin"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc"
