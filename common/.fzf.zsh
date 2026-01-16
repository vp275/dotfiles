# Setup fzf
# ---------
if [[ "$OSTYPE" == darwin* ]]; then
    # macOS Homebrew
    if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
        PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
    fi
else
    # Linux - check common locations
    [[ -d /usr/share/fzf ]] && source /usr/share/fzf/key-bindings.zsh 2>/dev/null
    [[ -d /usr/share/fzf ]] && source /usr/share/fzf/completion.zsh 2>/dev/null
fi

# Modern fzf shell integration (works on both if fzf is in PATH)
source <(fzf --zsh 2>/dev/null) || true
