# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

User dotfiles (`~/.dotfiles`) managed with GNU Stow. Vim-centric, keyboard-driven workflow with Mercedes Petronas theme (black + teal). See `theme-colors.md` for the full color palette.

## Directory Structure

```
~/.dotfiles/
├── common/         # Cross-platform configs (zsh, p10k, git, nvim, tmux, etc.)
├── mac/            # Mac-only apps (aerospace, ghostty, karabiner) + config.local
├── linux/          # Linux-only apps (alacritty) + config.local
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
| common | `common/.config/zsh/` | Shell config (oh-my-zsh, p10k) | Yes |
| common | `common/.config/nvim/` | Neovim with lazy.nvim | Yes |
| common | `common/.config/tmux/` | Terminal multiplexer | Yes |
| common | `common/.config/doom/` | Doom Emacs config (GTD, org-roam, gptel) | Yes |
| mac | `mac/.config/aerospace/` | i3-like tiling window manager | Yes |
| mac | `mac/.config/ghostty/` | Terminal emulator (Mac) | Yes |
| linux | `linux/.config/alacritty/` | Terminal emulator (Linux) | No |

## Key Architecture

**Terminal stack**: Ghostty → tmux. Ghostty forwards Cmd keys as Meta sequences to tmux (e.g., Cmd+d becomes M-d for split). See `mac/.config/ghostty/CLAUDE.md` for the keybind mapping table.

**Secrets**: API keys live in `{mac,linux}/.config/zsh/.zshenv.local` (gitignored). Configs reference env vars like `$GEMINI_API_KEY`, `$ZAI_AUTH_TOKEN`.

**Stow symlinks**: Stow creates symlinks from ~/ and ~/.config/ to ~/.dotfiles/:
- `~/.zshrc` → `.dotfiles/common/.zshrc`
- `~/.p10k.zsh` → `.dotfiles/common/.p10k.zsh`
- `~/.gitconfig` → `.dotfiles/common/.gitconfig`
- `~/.fzf.zsh` → `.dotfiles/common/.fzf.zsh`
- `~/.claude/` → `.dotfiles/common/.claude/`
- `~/.config/nvim/` → `.dotfiles/common/.config/nvim/`
- `~/.config/git/config.local` → `.dotfiles/{mac,linux}/.config/git/config.local`

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
