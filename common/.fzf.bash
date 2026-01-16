# Setup fzf
# ---------
if [[ "$OSTYPE" == darwin* ]]; then
    # macOS Homebrew
    if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
        PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
    fi
else
    # Linux - check common locations
    [[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
    [[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash
fi

# Modern fzf shell integration (works on both if fzf is in PATH)
eval "$(fzf --bash 2>/dev/null)" || true
