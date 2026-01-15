# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS user dotfiles (`~/.config`). Vim-centric, keyboard-driven workflow with Mercedes Petronas theme (black + teal). See `theme-colors.md` for the full color palette.

## App Index

For detailed guidance, see each app's `CLAUDE.md`:

| Folder | Purpose | Has CLAUDE.md |
|--------|---------|---------------|
| `aerospace/` | i3-like tiling window manager | Yes |
| `doom/` | Doom Emacs config (GTD, org-roam, gptel) | Yes |
| `ghostty/` | Terminal emulator | Yes |
| `nvim/` | Neovim with lazy.nvim | Yes |
| `tmux/` | Terminal multiplexer | Yes |
| `zsh/` | Shell config (oh-my-zsh, p10k) | Yes |

Other folders (gcloud, git, ranger, etc.) are simple or auto-managed configs without dedicated docs.

## Key Architecture

**Terminal stack**: Ghostty → tmux. Ghostty forwards Cmd keys as Meta sequences to tmux (e.g., Cmd+d becomes M-d for split). See `ghostty/CLAUDE.md` for the keybind mapping table.

**Secrets**: API keys live in `zsh/.zshenv.local` (gitignored). Configs reference env vars like `$GEMINI_API_KEY`, `$ZAI_AUTH_TOKEN`.

**Symlinks**: Many dotfiles live here but symlink to `~/`:
- `~/.zshrc` → `zsh/.zshrc`
- `~/.p10k.zsh` → `p10k/p10k.zsh`
- `~/.gitconfig` → `git/config`
- `~/.taskrc` → `task/taskrc`
- `~/.fzf.zsh` → `fzf/fzf.zsh`
- `~/.claude/settings.json` → `claude/settings.json`
- `~/.claude-glm/settings.json` → `claude-glm/settings.json`

**Claude Code**: Dual-provider setup via `glm()` function in zshrc. `claude` uses Claude Max (`~/.claude/`), `glm` uses Z.AI GLM (`~/.claude-glm/`). Fully isolated configs, can run simultaneously. See `zsh/CLAUDE.md` for details.

## Theme

Mercedes Petronas theme applied to: Ghostty, tmux, p10k, ranger, zsh-syntax-highlighting. Neovim uses carbonfox.

Key colors: `#00D2BE` (teal), `#0A0A0A` (black), `#D8D8D8` (silver), `#CC2936` (scarlet for errors).
