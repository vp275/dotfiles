<h1 align="center">~/.dotfiles</h1>

<p align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=JetBrains+Mono&size=18&duration=3000&pause=1000&color=00D2BE&center=true&vCenter=true&width=435&lines=vim+enthusiast;keyboard+driven+workflow;mercedes+petronas+theme;macOS+daily+driver" alt="Typing SVG" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/macOS-Sequoia-000000?logo=apple&logoColor=white" alt="macOS">
  <img src="https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=white" alt="Neovim">
  <img src="https://img.shields.io/badge/Doom%20Emacs-7F5AB6?logo=gnuemacs&logoColor=white" alt="Doom Emacs">
  <img src="https://img.shields.io/badge/Zsh-F15A24?logo=zsh&logoColor=white" alt="Zsh">
  <img src="https://img.shields.io/badge/tmux-1BB91F?logo=tmux&logoColor=white" alt="tmux">
  <img src="https://img.shields.io/badge/Ghostty-161616?logo=ghost&logoColor=white" alt="Ghostty">
  <br>
  <img src="https://visitor-badge.laobi.icu/badge?page_id=vp275.dotfiles_mac&left_color=%23161616&right_color=%2300D2BE" alt="Visitors">
</p>

---

## Quick Start

```bash
# Clone
git clone git@github.com:vp275/dotfiles.git ~/.dotfiles

# Deploy
cd ~/.dotfiles
stow mac
```

## What's Inside

| Tool | Path | Purpose | Docs |
|------|------|---------|------|
| [aerospace](mac/.config/aerospace/) | `mac` | Tiling window manager | [CLAUDE.md](mac/.config/aerospace/CLAUDE.md) |
| [nvim](mac/.config/nvim/) | `mac` | Neovim with lazy.nvim | [CLAUDE.md](mac/.config/nvim/CLAUDE.md) |
| [doom](mac/.config/doom/) | `mac` | Doom Emacs, GTD, org-roam, gptel | [CLAUDE.md](mac/.config/doom/CLAUDE.md) |
| [tmux](mac/.config/tmux/) | `mac` | Terminal multiplexer | [CLAUDE.md](mac/.config/tmux/CLAUDE.md) |
| [zsh](mac/.config/zsh/) | `mac` | Shell, Oh My Zsh, p10k | [CLAUDE.md](mac/.config/zsh/CLAUDE.md) |
| [ghostty](mac/.config/ghostty/) | `mac` | Terminal emulator | [CLAUDE.md](mac/.config/ghostty/CLAUDE.md) |
| [ranger](mac/.config/ranger/) | `mac` | File manager | - |
| [karabiner](mac/.config/karabiner/) | `mac` | Keyboard customization | - |
| [bat](mac/.config/bat/) | `mac` | Cat clone with syntax highlighting | - |
| [btop](mac/.config/btop/) | `mac` | System monitor | - |

## Structure

```text
~/.dotfiles/
|-- mac/                    # Active Stow package
|   |-- .zshrc              # Shell config
|   |-- .p10k.zsh           # Powerlevel10k prompt
|   |-- .gitconfig          # Git config
|   |-- .fzf.zsh            # FZF shell integration
|   |-- .claude/            # Claude Code settings
|   |-- .taskrc             # Taskwarrior config
|   `-- .config/
|       |-- aerospace/      # Tiling window manager
|       |-- ghostty/        # Terminal emulator
|       |-- alacritty/      # Alternate terminal config
|       |-- karabiner/      # Keyboard remapping
|       |-- linearmouse/    # Mouse settings
|       |-- nvim/           # Neovim + lazy.nvim plugins
|       |-- tmux/           # tmux + TPM
|       |-- doom/           # Doom Emacs
|       |-- zsh/            # zsh docs and local overrides
|       |-- git/            # Git ignore and local credential helper
|       |-- ranger/         # File manager
|       |-- bat/            # Syntax highlighting
|       |-- btop/           # System monitor
|       `-- neofetch/       # System info
|-- archive/
|   `-- linux/              # Inactive Linux package kept for reference
|-- docs/
|-- CLAUDE.md
|-- AGENTS.md
|-- README.md
`-- theme-colors.md
```

## Key Features

- **macOS-focused** - one active Stow package: `mac`
- **Vim-centric** - Evil mode in Emacs, vim keybinds everywhere
- **Keyboard-driven** - AeroSpace WM, tmux, minimal mouse usage
- **Terminal workflow** - Ghostty is native/minimal; tmux remains available for multiplexing

## Theme: Mercedes Petronas

Custom dark theme inspired by Mercedes-AMG Petronas F1. See [theme-colors.md](theme-colors.md) for full palette.

| Color | Hex | Usage |
|-------|-----|-------|
| Petronas Teal | `#00D2BE` | Primary accent, directories, prompt |
| Pure Black | `#0A0A0A` | Backgrounds |
| Silver | `#D8D8D8` | Git modified state |
| Scarlet | `#CC2936` | Errors, conflicts |
| Light Text | `#f2f4f8` | Foreground |

Applied to: Ghostty, tmux, p10k, ranger, zsh-syntax-highlighting, bat, and Neovim.

---

<p align="center">
  <img src="https://quotes-github-readme.vercel.app/api?type=horizontal&theme=dark&quote=Talk%20is%20cheap.%20Show%20me%20the%20code.&author=Linus%20Torvalds" alt="Quote" />
</p>

<p align="center">
  <sub>Managed with GNU Stow</sub>
</p>
