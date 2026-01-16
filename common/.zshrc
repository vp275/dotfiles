
# Load local secrets (API keys, tokens)
[[ -f ~/.config/zsh/.zshenv.local ]] && source ~/.config/zsh/.zshenv.local

# ===== PLATFORM DETECTION =====
if [[ "$OSTYPE" == darwin* ]]; then
    IS_MAC=true
else
    IS_MAC=false
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Complete direnv initialization (after instant prompt)
(( ${+commands[direnv]} )) && eval "$(direnv hook zsh)"


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git zsh-syntax-highlighting zsh-autosuggestions
	fzf
	fzf-tab
	z
	colored-man-pages
)
# Mac-only plugins
$IS_MAC && plugins+=(macos brew)

source $ZSH/oh-my-zsh.sh

# Syntax highlighting colors (Mercedes theme - teal instead of green)
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan,bold'

# User configuration

# Keep Puppeteer/fast-cli cache out of ~/.cache to avoid cleanup.
export PUPPETEER_CACHE_DIR="$HOME/.local/share/puppeteer"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'
export VISUAL='nvim'
export BAT_THEME='carbonfox'

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export TERM="xterm-256color"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias theta="~/thetadata/theta.bash"
export PATH="$PATH:$HOME/.config/emacs/bin"
alias py=".venv/bin/python3"
alias fim="vim \$(fzf)"

# Recent files from neovim, pick with fzf (filters to existing files only)
fr() {
  local file
  file=$(nvim --headless +'lua for _,f in ipairs(vim.v.oldfiles) do print(f) end' +q 2>&1 | grep '^/' | tr -d '\r' | while read -r f; do [[ -f "$f" ]] && echo "$f"; done | fzf)
  [[ -n "$file" ]] && nvim "$file"
}

# Platform-specific file opening aliases
if $IS_MAC; then
    alias fopen="open \"\$(fzf)\""
    alias ffind="open -R \"\$(fzf)\""
else
    alias fopen="xdg-open \"\$(fzf)\""
    alias ffind="xdg-open \"\$(dirname \"\$(fzf)\")\""
fi

alias fcd="cd \"\$(dirname \"\$(fzf)\")\" && ls"
alias tw="task"

# Mac-specific paths and tools
if $IS_MAC; then
    # Added by Windsurf
    export PATH="$HOME/.codeium/windsurf/bin:$PATH"
    # opencode
    export PATH="$HOME/.opencode/bin:$PATH"
    # MacPorts
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

    # Network optimization aliases
    alias mynet='~/.config/myFiles/network/enable_fast_network.sh'
    alias offmynet='~/.config/myFiles/network/disable_fast_network.sh'

    # IBKR trading scripts
    export PATH="$PATH:$HOME/pspl/ibkr/cron"
    alias nxc="nextcron"

    # Caffeinate control aliases
    alias caff="$HOME/pspl/ibkr/cron/on_caffeinate"
    alias uncaff="$HOME/pspl/ibkr/cron/off_caffeinate"

    # Added by Antigravity
    export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
fi

# Gemini API keys disabled on 2025-08-13
# GEMINI_API_KEY loaded from .zshenv.local

# Ranger function to cd to last directory on quit with Q
ranger() {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command ranger
        --cmd="map q chain shell echo %d > "$tempfile"; quitall"
        "$@"
    )
    "${ranger_cmd[@]}"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")"
    fi
    command rm -f -- "$tempfile"
}

alias rr="ranger"
alias vim="nvim"
alias vi="nvim"

# === CLAUDE CODE PROVIDER SWITCHER ===
alias cl="claude"
alias cr="claude --resume"
alias clc="claude --continue"
alias cld="claude --dangerously-skip-permissions"
alias crd="claude --resume --dangerously-skip-permissions"
alias clcd="claude --continue --dangerously-skip-permissions"

# Z.AI GLM (completely isolated config directory)
glm() {
    CLAUDE_CONFIG_DIR="$HOME/.claude-glm" \
    ANTHROPIC_AUTH_TOKEN="$ZAI_AUTH_TOKEN" \
    ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic" \
    API_TIMEOUT_MS="3000000" \
    command claude "$@"
}

# ccusage wrapper to aggregate usage from both Claude and GLM configs
ccusage() {
    CLAUDE_CONFIG_DIR="$HOME/.claude,$HOME/.claude-glm" command ccusage "$@"
}

# Usage aliases with model breakdown
alias ccu="ccusage --since \$(date +%Y%m%d) -b"
alias ccuw="ccusage weekly -b"
alias ccum="ccusage monthly -b"
alias ccup="ccusage -i"

# Source machine-specific local overrides (not version controlled)
[[ -f ~/.config/zsh/.zshrc.local ]] && source ~/.config/zsh/.zshrc.local
