# Directory hashes
hash -d docs=$HOME/Documents
hash -d dl=$HOME/Downloads
hash -d repos=$HOME/Documents/Repositories

# History settings
HISTSIZE=10000
SIVEHIST=10000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

if which nix &>/dev/null; then
    NIX_PACKAGES="$(nix profile list | grep "^S" | grep "nix-packages" | cut -d' ' -f 10)"
fi

# Homebrew on aarch64 Darwin
if [[ $(uname) == 'Darwin' && $(uname -m) == 'arm64' && -d "/opt/homebrew/share/zsh/site-functions" ]]; then
  [[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath+=(/opt/homebrew/share/zsh/site-functions)
fi

# Nix zsh autocompletion 
if [[ -d /nix/var/nix/profiles/default/share/zsh/site-functions ]]; then
    fpath+=(/nix/var/nix/profiles/default/share/zsh/site-functions)
fi

if which "$NIX_PACKAGES/bin/direnv" &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

if [[ -d "$NIX_PACKAGES/share/zsh/themes/typewritten" ]]; then
    fpath+="$NIX_PACKAGES/share/zsh/themes/typewritten"
    autoload -U promptinit; promptinit

    TYPEWRITTEN_CURSOR=block

    prompt typewritten
fi

# Completion
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# zsh-history-substring-search
if [[ -d "$NIX_PACKAGES/share/zsh-history-substring-search" ]]; then
    source "$NIX_PACKAGES/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
    bindkey '^[OA' history-substring-search-up
    bindkey '^[[A' history-substring-search-up
    bindkey '^[OB' history-substring-search-down
    bindkey '^[[B' history-substring-search-down
fi

# fast-syntax-highlighting
if [[ -f "$NIX_PACKAGES/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh" ]]; then
    source "$NIX_PACKAGES/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh"
fi

alias ll="ls -lG"
alias la="ls -laG"


config() {
echo $1;
}

