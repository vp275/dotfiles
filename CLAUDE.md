# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

User dotfiles (`~/.dotfiles`) managed with GNU Stow. Vim-centric, keyboard-driven workflow with Mercedes Petronas theme (black + teal). See `theme-colors.md` for the full color palette.

## Common Commands

```bash
# Deploy configs
cd ~/.dotfiles && stow common mac    # Mac
cd ~/.dotfiles && stow common linux  # Linux

# Validate configs
ghostty +validate-config --config-file ~/.config/ghostty/config
aerospace reload-config

# Reload configs
tmux source-file ~/.config/tmux/tmux.conf  # or M-R in tmux
~/.config/emacs/bin/doom sync              # after init.el/packages.el changes

# Neovim plugins
:Lazy                                       # open plugin manager UI
```

## Directory Structure

```
~/.dotfiles/
├── common/         # Cross-platform configs (zsh, p10k, git, nvim, tmux, doom)
├── mac/            # Mac-only apps (aerospace, ghostty, karabiner) + config.local
├── linux/          # Linux-only apps (alacritty) + config.local
└── theme-colors.md # Color palette reference
```

## App-Specific Docs

Each app has its own CLAUDE.md with keybindings, settings, and gotchas:
- `common/.config/zsh/CLAUDE.md` - Shell, plugins, aliases, Claude Code dual-provider setup
- `common/.config/nvim/CLAUDE.md` - Neovim keybindings (leader=Space), lazy.nvim plugins
- `common/.config/tmux/CLAUDE.md` - Meta bindings table, TPM plugins
- `common/.config/doom/CLAUDE.md` - Literate config (emacs.org), GTD setup, gptel
- `mac/.config/aerospace/CLAUDE.md` - Workspace assignments, app matching rules
- `mac/.config/ghostty/CLAUDE.md` - Cmd-to-Meta routing table (critical for terminal stack)

## Key Architecture

**Terminal stack**: Ghostty → tmux. Ghostty forwards Cmd keys as Meta sequences to tmux (e.g., Cmd+d becomes M-d for split). See `mac/.config/ghostty/CLAUDE.md` for the keybind mapping table.

**Secrets**: API keys live in `{mac,linux}/.config/zsh/.zshenv.local` (gitignored). Configs reference env vars like `$GEMINI_API_KEY`, `$ZAI_AUTH_TOKEN`.

**Stow symlinks**: Stow creates symlinks from `~/` and `~/.config/` into this repo:
- `~/.zshrc` → `common/.zshrc`
- `~/.p10k.zsh` → `common/.p10k.zsh`
- `~/.gitconfig` → `common/.gitconfig`
- `~/.fzf.zsh` → `common/.fzf.zsh`
- `~/.claude/` → `common/.claude/`
- `~/.config/nvim/` → `common/.config/nvim/`
- `~/.config/git/config.local` → `{mac,linux}/.config/git/config.local`

**Platform conditionals**: Cross-platform configs use runtime detection:
- `.zshrc`: `IS_MAC` variable for plugins (macos, brew), paths, aliases (open vs xdg-open)
- `.fzf.zsh`: Homebrew vs Linux package paths
- `tmux.conf`: `if-shell` for clipboard (pbcopy vs xclip)
- `.gitconfig`: `[include]` for credential helper via platform config.local

**Platform overrides**: Machine-specific `.local` files (gitignored):
- `~/.config/zsh/.zshenv.local` - API keys and secrets
- `~/.config/zsh/.zshrc.local` - machine-specific shell config
- `~/.config/git/config.local` - credential helper (osxkeychain / libsecret)

**Claude Code**: Dual-provider setup via `glm()` function in zshrc. `claude` uses Claude Max (`~/.claude/`), `glm` uses Z.AI GLM (`~/.claude-glm/`). Fully isolated configs, can run simultaneously. See `common/.config/zsh/CLAUDE.md` for details.

## Theme

Mercedes Petronas theme applied to: Ghostty, tmux, p10k, ranger, zsh-syntax-highlighting. Neovim uses carbonfox.

Key colors: `#00D2BE` (teal), `#0A0A0A` (black), `#D8D8D8` (silver), `#CC2936` (scarlet for errors).
