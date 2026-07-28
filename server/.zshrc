# Server shell configuration for bte-agents-1.
# Keep machine-specific secrets and optional tools in ~/.config/zsh/.zshrc.local.

[[ -f ~/.config/zsh/.zshenv.local ]] && source ~/.config/zsh/.zshenv.local

# Powerlevel10k instant prompt must remain close to the top of this file.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
export VISUAL='nvim'
export BAT_THEME='Mercedes-Petronas'

ZSH_THEME='powerlevel10k/powerlevel10k'
DISABLE_UNTRACKED_FILES_DIRTY='true'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1

plugins=(
  git
  fzf
  fzf-tab
  z
  colored-man-pages
)

typeset -U fpath
[[ -d "$ZSH/custom/plugins/fzf-tab/lib" ]] && fpath+=("$ZSH/custom/plugins/fzf-tab/lib")
[[ -r "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

[[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if (( ${+parameters[ZSH_HIGHLIGHT_STYLES]} )); then
  ZSH_HIGHLIGHT_STYLES[command]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan,bold'
  ZSH_HIGHLIGHT_STYLES[function]='fg=cyan,bold'
fi

(( ${+commands[direnv]} )) && eval "$(direnv hook zsh)"
[[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh

alias szsh='source ~/.zshrc'
alias vim='nvim'
alias vi='nvim'
alias rr='ranger'
alias fim='nvim "$(fzf)"'
alias fcd='cd "$(dirname "$(fzf)")" && ls'

fr() {
  local file
  file=$(nvim --headless +'lua for _, f in ipairs(vim.v.oldfiles) do print(f) end' +q 2>/dev/null |
    while IFS= read -r candidate; do [[ -f "$candidate" ]] && print -r -- "$candidate"; done |
    fzf)
  [[ -n "$file" ]] && nvim "$file"
}

ranger() {
  local tempfile
  tempfile=$(mktemp)
  command ranger --cmd="map q chain shell echo %d > '$tempfile'; quitall" "$@"
  if [[ -f "$tempfile" ]]; then
    local destination
    destination=$(<"$tempfile")
    [[ -n "$destination" && "$destination" != "$PWD" ]] && cd -- "$destination"
  fi
  command rm -f -- "$tempfile"
}

[[ -f ~/.config/zsh/.zshrc.local ]] && source ~/.config/zsh/.zshrc.local
