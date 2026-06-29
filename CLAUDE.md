# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
this repository.

## Overview

User dotfiles (`~/.dotfiles`) are managed with GNU Stow. This repo is now a
macOS-focused setup with a single active Stow package: `mac/`.

The workflow is Vim-centric and keyboard-driven, with a Mercedes Petronas theme
(black + teal) across the terminal stack and editor tooling. See
`theme-colors.md` for the full palette.

## Common Commands

```bash
# Deploy configs
cd ~/.dotfiles && stow mac

# Validate configs
ghostty +validate-config --config-file ~/.config/ghostty/config
aerospace reload-config

# Reload configs
tmux source-file ~/.config/tmux/tmux.conf
~/.config/emacs/bin/doom sync              # after init.el/packages.el changes

# Neovim plugins
:Lazy                                       # open plugin manager UI
```

## Directory Structure

```text
~/.dotfiles/
|-- mac/                    # Active Stow package
|   |-- .zshrc              # Shell config
|   |-- .p10k.zsh           # Powerlevel10k prompt
|   |-- .gitconfig          # Git config
|   |-- .fzf.zsh            # FZF shell integration
|   |-- .local/bin/         # Helper scripts
|   `-- .config/
|       |-- zsh/
|       |-- nvim/
|       |-- tmux/
|       |-- doom/
|       |-- aerospace/
|       |-- ghostty/
|       |-- alacritty/
|       |-- karabiner/
|       |-- linearmouse/
|       |-- git/
|       |-- ranger/
|       |-- bat/
|       |-- btop/
|       `-- neofetch/
|-- archive/linux/          # Inactive Linux config kept for reference
`-- theme-colors.md         # Color palette reference
```

## App-Specific Docs

Each app has its own docs with keybindings, settings, and gotchas:

- `mac/.config/zsh/CLAUDE.md` - Shell, plugins, aliases, Claude Code setup
- `mac/.config/nvim/CLAUDE.md` - Neovim keybindings, lazy.nvim plugins
- `mac/.config/tmux/CLAUDE.md` - tmux bindings, TPM plugins, statusline notes
- `mac/.config/doom/CLAUDE.md` - Literate config, GTD setup, gptel
- `mac/.config/aerospace/CLAUDE.md` - Workspace assignments, app matching rules
- `mac/.config/aerospace/AGENTS.md` - Agent notes for AeroSpace edits
- `mac/.config/ghostty/CLAUDE.md` - Current native/minimal Ghostty setup
- `mac/.config/ghostty/AGENTS.md` - Agent notes for Ghostty edits

## Key Architecture

**Active package**: `mac/` is the only active Stow package. The old Linux package
is archived under `archive/linux/` and is not part of the deployment flow.

**Terminal stack**: Ghostty is currently minimal and stock-leaning. It uses
native Ghostty tabs, splits, scrollback, and Cmd shortcuts. The older
Cmd-to-Meta tmux integration is archived in Ghostty docs, while tmux still has
Meta bindings available for terminals that send Meta.

**Secrets**: API keys and machine-local config live in ignored `.local` files:

- `~/.config/zsh/.zshenv.local`
- `~/.config/zsh/.zshrc.local`
- `~/.config/git/config.local`
- app-specific `config.local` files where present

**Stow symlinks**: Stow creates symlinks from `~/` and `~/.config/` into
`mac/`, including:

- `~/.zshrc` -> `mac/.zshrc`
- `~/.p10k.zsh` -> `mac/.p10k.zsh`
- `~/.gitconfig` -> `mac/.gitconfig`
- `~/.fzf.zsh` -> `mac/.fzf.zsh`
- `~/.config/nvim/` -> `mac/.config/nvim/`
- `~/.config/tmux/` -> `mac/.config/tmux/`
- `~/.config/doom/` -> `mac/.config/doom/`
- `~/.config/git/` -> `mac/.config/git/`

**Claude Code**: `claude` is the default Claude Code command. The tracked
`.zshrc` defines aliases such as `cl`, `cld`, `clds`, `cldr`, `cldc`, `cldp`,
and `ccv*`. If `glm` is available, it comes from local shell config or another
installed command, not from the tracked `.zshrc`.

## Theme

Mercedes Petronas theme is applied to Ghostty, tmux, p10k, ranger,
zsh-syntax-highlighting, bat, and Neovim.

Key colors: `#00D2BE` (teal), `#0A0A0A` (black), `#D8D8D8` (silver),
`#CC2936` (scarlet for errors).
