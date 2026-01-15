# CLAUDE.md

## Overview

Zsh configuration using Oh-My-Zsh with Powerlevel10k theme. The `~/.zshrc` symlinks to `~/.config/zsh/.zshrc`.

## Plugins

```
git macos zsh-syntax-highlighting zsh-autosuggestions fzf fzf-tab z brew colored-man-pages
```

## Secrets Management

`.zshenv.local` contains API keys and is gitignored:
- `GEMINI_API_KEY` - Google Gemini API
- `ZAI_AUTH_TOKEN` - Z.AI authentication token

Loaded at top of `.zshrc` before p10k instant prompt.

## Custom Functions

**ranger()** - Wraps ranger to cd to last directory on quit (q key). Use via `rr` alias.

**glm()** - Launches Claude Code with Z.AI GLM backend (fully isolated from Claude Max):
- Sets `CLAUDE_CONFIG_DIR=~/.claude-glm` for complete separation
- Sets `ANTHROPIC_AUTH_TOKEN`, `ANTHROPIC_BASE_URL`, `API_TIMEOUT_MS`
- All env vars scoped to that process only (no leakage)

**ccusage()** - Aggregates usage stats from both Claude and GLM configs:
- Sets `CLAUDE_CONFIG_DIR` to comma-separated list of both config directories
- Reports combined usage from `~/.claude` and `~/.claude-glm`

**fr()** - Recent files picker using neovim's oldfiles + fzf (filters to existing files only)

## Claude Code Dual-Provider Setup

| Command | Provider | Config Dir | Use Case |
|---------|----------|------------|----------|
| `claude` | Claude Max | `~/.claude/` | Default, Anthropic subscription |
| `glm` | Z.AI GLM | `~/.claude-glm/` | GLM-4.7 via Z.AI endpoint |

Both can run simultaneously with no conflicts - separate history, projects, settings, and stats.

## Key Aliases

| Alias | Command | Purpose |
|-------|---------|---------|
| `rr` | `ranger` | File manager with cd-on-quit |
| `vim`, `vi` | `nvim` | Neovim |
| `py` | `.venv/bin/python3` | Local venv Python |
| `fim` | `vim $(fzf)` | Fuzzy find and edit |
| `fopen` | `open "$(fzf)"` | Fuzzy find and open |
| `fcd` | cd to fzf selection | Fuzzy cd |
| `tw` | `task` | Taskwarrior |
| `caff`/`uncaff` | caffeinate control | Keep-awake scripts |
| `mynet`/`offmynet` | network scripts | Fast network toggle |

### Claude Code Aliases

| Alias | Command | Purpose |
|-------|---------|---------|
| `cl` | `claude` | Launch Claude Code |
| `cr` | `claude --resume` | Resume picker |
| `clc` | `claude --continue` | Continue last chat |
| `cld` | `claude --dangerously-skip-permissions` | Skip permissions |
| `crd` | `claude --resume --dangerously-skip-permissions` | Resume + skip permissions |
| `clcd` | `claude --continue --dangerously-skip-permissions` | Continue + skip permissions |

### ccusage Aliases

| Alias | Command | Purpose |
|-------|---------|---------|
| `ccu` | `ccusage --since $(date +%Y%m%d) -b` | Today's usage with breakdown |
| `ccuw` | `ccusage weekly -b` | Weekly usage |
| `ccum` | `ccusage monthly -b` | Monthly usage |
| `ccup` | `ccusage -i` | Usage by project |

## Environment

- `EDITOR` / `VISUAL` = `nvim`
- `BAT_THEME` = `carbonfox` (matches terminal/editor theme)
- `TERM` = `xterm-256color`
- direnv hook enabled for per-directory env

## Prompt Configuration

Powerlevel10k configured via `~/.p10k.zsh`. Run `p10k configure` to reconfigure.
