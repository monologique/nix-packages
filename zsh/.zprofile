# Envvars
export XDG_CACHE_DIR=$HOME/Library/Caches/go
export GOPATH=$XDG_CACHE_DIR/go

# Homebrew shell activation
if [[ -d "/opt/homebrew"  ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
