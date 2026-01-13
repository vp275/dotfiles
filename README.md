<h1 align="center">~/.dotfiles</h1>
<p align="center">macOS dotfiles · Carbonfox theme · Vim-centric workflow</p>

<p align="center">
  <img src="https://img.shields.io/badge/macOS-Sequoia-000000?logo=apple&logoColor=white" alt="macOS">
  <img src="https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=white" alt="Neovim">
  <img src="https://img.shields.io/badge/Doom%20Emacs-7F5AB6?logo=gnuemacs&logoColor=white" alt="Doom Emacs">
  <img src="https://img.shields.io/badge/Zsh-F15A24?logo=zsh&logoColor=white" alt="Zsh">
  <img src="https://img.shields.io/badge/tmux-1BB91F?logo=tmux&logoColor=white" alt="tmux">
  <img src="https://img.shields.io/badge/Ghostty-161616?logo=ghost&logoColor=white" alt="Ghostty">
</p>

---

## What's Inside

| Tool | Purpose | Docs |
|------|---------|------|
| [aerospace](aerospace/) | Tiling window manager (i3-like) | [CLAUDE.md](aerospace/CLAUDE.md) |
| [nvim](nvim/) | Neovim with lazy.nvim | [CLAUDE.md](nvim/CLAUDE.md) |
| [doom](doom/) | Doom Emacs (GTD, org-roam, gptel) | [CLAUDE.md](doom/CLAUDE.md) |
| [tmux](tmux/) | Terminal multiplexer | [CLAUDE.md](tmux/CLAUDE.md) |
| [zsh](zsh/) | Shell (oh-my-zsh, p10k) | [CLAUDE.md](zsh/CLAUDE.md) |
| [ghostty](ghostty/) | Terminal emulator | [CLAUDE.md](ghostty/CLAUDE.md) |
| [ranger](ranger/) | File manager | - |
| [karabiner](karabiner/) | Keyboard customization | - |
| [bat](bat/) | Cat clone with syntax highlighting | - |
| [btop](btop/) | System monitor | - |

## Structure

```
~/.config/
├── aerospace/      # Tiling WM config
├── doom/           # Doom Emacs (literate org config)
├── ghostty/        # Terminal config
├── nvim/           # Neovim + lazy.nvim plugins
├── tmux/           # tmux + TPM plugins
├── zsh/            # Zsh + oh-my-zsh + p10k
├── bat/            # Carbonfox theme
├── btop/           # System monitor
├── git/            # Global gitignore
├── karabiner/      # Key remapping
├── linearmouse/    # Mouse settings
├── mcp/            # MCP servers
├── neofetch/       # System info
└── ranger/         # File manager
```

## Key Features

- **Vim-centric** - Evil mode in Emacs, vim keybinds everywhere
- **Keyboard-driven** - Aerospace WM, tmux, minimal mouse usage
- **Consistent theme** - Carbonfox across terminal, editors, bat
- **Terminal stack** - Ghostty → tmux (Cmd keys forwarded as Meta)

## Theme: Carbonfox

Part of the [Nightfox](https://github.com/EdenEast/nightfox.nvim) family.

| Color | Hex | Usage |
|-------|-----|-------|
| Background | `#161616` | Terminal, editors |
| Foreground | `#f2f4f8` | Text |
| Blue | `#78a9ff` | Keywords |
| Cyan | `#33b1ff` | Strings |
| Green | `#42be65` | Functions |
| Magenta | `#be95ff` | Constants |
| Red | `#ee5396` | Errors |
| Yellow | `#ffe97b` | Warnings |

## Claude Code Setup

Dual-provider configuration for running Claude Max and Z.AI GLM simultaneously:

```bash
claude    # → Uses ~/.claude/ (Claude Max subscription)
glm       # → Uses ~/.claude-glm/ (Z.AI GLM endpoint)
```

Fully isolated configs - separate history, projects, and settings.

---

<p align="center">
  <sub>Managed with Git · No symlink manager needed</sub>
</p>
