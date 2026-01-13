# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS user dotfiles (`~/.config`). Vim-centric, keyboard-driven workflow with carbonfox theme throughout.

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

**Symlink**: `~/.zshrc` → `~/.config/zsh/.zshrc`

**Claude Code**: Dual-provider setup via `glm()` function in zshrc. `claude` uses Claude Max (`~/.claude/`), `glm` uses Z.AI GLM (`~/.claude-glm/`). Fully isolated configs, can run simultaneously. See `zsh/CLAUDE.md` for details.
