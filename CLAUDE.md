# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

User dotfiles (`~/.dotfiles`) managed with GNU Stow. Vim-centric, keyboard-driven workflow with Mercedes Petronas theme (black + teal). See `theme-colors.md` for the full color palette.

## Directory Structure

```
~/.dotfiles/
├── common/         # Cross-platform configs (nvim, tmux, ranger, etc.)
├── mac/            # Mac-specific configs (aerospace, ghostty, karabiner, etc.)
├── linux/          # Linux-specific configs (placeholder for now)
├── CLAUDE.md       # This file
├── README.md       # Usage instructions
└── theme-colors.md # Color palette reference
```

**Deploy with Stow:**
```bash
cd ~/.dotfiles
stow common mac    # Mac
stow common linux  # Linux (future)
```

## App Index

For detailed guidance, see each app's `CLAUDE.md`:

| Package | Folder | Purpose | Has CLAUDE.md |
|---------|--------|---------|---------------|
| mac | `mac/.config/aerospace/` | i3-like tiling window manager | Yes |
| common | `common/.config/doom/` | Doom Emacs config (GTD, org-roam, gptel) | Yes |
| mac | `mac/.config/ghostty/` | Terminal emulator | Yes |
| common | `common/.config/nvim/` | Neovim with lazy.nvim | Yes |
| common | `common/.config/tmux/` | Terminal multiplexer | Yes |
| mac | `mac/.config/zsh/` | Shell config (oh-my-zsh, p10k) | Yes |

## Key Architecture

**Terminal stack**: Ghostty → tmux. Ghostty forwards Cmd keys as Meta sequences to tmux (e.g., Cmd+d becomes M-d for split). See `mac/.config/ghostty/CLAUDE.md` for the keybind mapping table.

**Secrets**: API keys live in `mac/.config/zsh/.zshenv.local` (gitignored). Configs reference env vars like `$GEMINI_API_KEY`, `$ZAI_AUTH_TOKEN`.

**Stow symlinks**: Stow creates symlinks from ~/ and ~/.config/ to ~/.dotfiles/:
- `~/.zshrc` → `.dotfiles/mac/.zshrc`
- `~/.p10k.zsh` → `.dotfiles/mac/.p10k.zsh`
- `~/.gitconfig` → `.dotfiles/mac/.gitconfig`
- `~/.taskrc` → `.dotfiles/common/.taskrc`
- `~/.config/nvim/` → `.dotfiles/common/.config/nvim/`
- `~/.config/ghostty/` → `.dotfiles/mac/.config/ghostty/`

**Platform overrides**: Configs support `.local` files for machine-specific settings:
- `~/.config/zsh/.zshrc.local` - sourced at end of .zshrc
- `~/.config/git/config.local` - included via git [include]
- `~/.config/ghostty/config.local` - included via config-file

**Claude Code**: Dual-provider setup via `glm()` function in zshrc. `claude` uses Claude Max (`~/.claude/`), `glm` uses Z.AI GLM (`~/.claude-glm/`). Fully isolated configs, can run simultaneously. See `mac/.config/zsh/CLAUDE.md` for details.

## Theme

Mercedes Petronas theme applied to: Ghostty, tmux, p10k, ranger, zsh-syntax-highlighting. Neovim uses carbonfox.

Key colors: `#00D2BE` (teal), `#0A0A0A` (black), `#D8D8D8` (silver), `#CC2936` (scarlet for errors).
