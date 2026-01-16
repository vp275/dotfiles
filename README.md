<h1 align="center">~/.dotfiles</h1>

<p align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=JetBrains+Mono&size=18&duration=3000&pause=1000&color=00D2BE&center=true&vCenter=true&width=435&lines=vim+enthusiast;keyboard+driven+workflow;mercedes+petronas+theme;i+use+arch+btw+%F0%9F%98%8F" alt="Typing SVG" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/macOS-Sequoia-000000?logo=apple&logoColor=white" alt="macOS">
  <img src="https://img.shields.io/badge/Arch-Linux-1793D1?logo=archlinux&logoColor=white" alt="Arch Linux">
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

# Deploy (Mac)
cd ~/.dotfiles
stow common mac

# Deploy (Linux)
cd ~/.dotfiles
stow common linux
```

## What's Inside

| Tool | Package | Purpose | Docs |
|------|---------|---------|------|
| [aerospace](mac/.config/aerospace/) | mac | Tiling window manager (i3-like) | [CLAUDE.md](mac/.config/aerospace/CLAUDE.md) |
| [nvim](common/.config/nvim/) | common | Neovim with lazy.nvim | [CLAUDE.md](common/.config/nvim/CLAUDE.md) |
| [doom](common/.config/doom/) | common | Doom Emacs (GTD, org-roam, gptel) | [CLAUDE.md](common/.config/doom/CLAUDE.md) |
| [tmux](common/.config/tmux/) | common | Terminal multiplexer | [CLAUDE.md](common/.config/tmux/CLAUDE.md) |
| [zsh](mac/.config/zsh/) | mac | Shell (oh-my-zsh, p10k) | [CLAUDE.md](mac/.config/zsh/CLAUDE.md) |
| [ghostty](mac/.config/ghostty/) | mac | Terminal emulator | [CLAUDE.md](mac/.config/ghostty/CLAUDE.md) |
| [ranger](common/.config/ranger/) | common | File manager | - |
| [karabiner](mac/.config/karabiner/) | mac | Keyboard customization | - |
| [bat](common/.config/bat/) | common | Cat clone with syntax highlighting | - |
| [btop](common/.config/btop/) | common | System monitor | - |

## Structure

```
~/.dotfiles/
├── common/                 # Cross-platform configs
│   ├── .config/
│   │   ├── nvim/          # Neovim + lazy.nvim plugins
│   │   ├── tmux/          # tmux + TPM plugins
│   │   ├── doom/          # Doom Emacs (literate org config)
│   │   ├── ranger/        # File manager (mercedes theme)
│   │   ├── bat/           # Syntax highlighting
│   │   ├── btop/          # System monitor
│   │   └── neofetch/      # System info
│   └── .taskrc            # Taskwarrior config
│
├── mac/                    # Mac-specific configs
│   ├── .zshrc             # Shell config
│   ├── .p10k.zsh          # Powerlevel10k prompt
│   ├── .gitconfig         # Git config
│   ├── .fzf.zsh           # FZF for zsh
│   ├── .claude/           # Claude Code settings
│   └── .config/
│       ├── aerospace/     # Tiling WM
│       ├── ghostty/       # Terminal (mercedes-petronas theme)
│       ├── karabiner/     # Key remapping
│       ├── linearmouse/   # Mouse settings
│       ├── zsh/           # Supporting zsh files
│       └── git/           # Git ignore, local config
│
├── linux/                  # Linux-specific (placeholder)
├── CLAUDE.md              # AI assistant guidance
├── README.md              # This file
└── theme-colors.md        # Color palette reference
```

## Key Features

- **Vim-centric** - Evil mode in Emacs, vim keybinds everywhere
- **Keyboard-driven** - Aerospace WM, tmux, minimal mouse usage
- **Cross-platform** - Stow-managed for Mac and Linux
- **Terminal stack** - Ghostty → tmux (Cmd keys forwarded as Meta)

## Theme: Mercedes Petronas

Custom dark theme inspired by Mercedes-AMG Petronas F1. See [theme-colors.md](theme-colors.md) for full palette.

| Color | Hex | Usage |
|-------|-----|-------|
| Petronas Teal | `#00D2BE` | Primary accent, directories, prompt |
| Pure Black | `#0A0A0A` | Backgrounds |
| Silver | `#D8D8D8` | Git modified state |
| Scarlet | `#CC2936` | Errors, conflicts |
| Light Text | `#f2f4f8` | Foreground |

Applied to: Ghostty, tmux, p10k, ranger, zsh-syntax-highlighting. Neovim uses carbonfox.

---

<p align="center">
  <img src="https://quotes-github-readme.vercel.app/api?type=horizontal&theme=dark&quote=Talk%20is%20cheap.%20Show%20me%20the%20code.&author=Linus%20Torvalds" alt="Quote" />
</p>

<p align="center">
  <sub>Managed with GNU Stow</sub>
</p>
