# CLAUDE.md

Ghostty terminal emulator configuration for macOS. Core purpose: route Mac Cmd keys to tmux as Meta sequences for a seamless terminal stack.

## Validation

```bash
ghostty +validate-config --config-file ~/.config/ghostty/config
ghostty +show-config  # Show effective config vs defaults
```

## Key Settings

**Theme & Appearance:**
- `theme = mercedes-petronas` (custom theme in `~/.config/ghostty/themes/`)
- Mercedes Petronas colors: black (#0A0A0A) background, teal (#00D2BE) cursor/accents
- `font-size = 18`
- `background-opacity = .9`, `background-blur-radius = 100`

**Clipboard:**
- `clipboard-write = "allow"` - Programs (Vim) can write via OSC 52
- `clipboard-read = "allow"` - Paste without prompt
- `copy-on-select = "clipboard"` - Selection syncs to clipboard

**Auto-start tmux:**
- `command = /opt/homebrew/bin/tmux new-session -A -s main`

## Cmd-to-Meta Keybind Routing (Critical)

Ghostty intercepts Cmd keys and sends them as Meta (Escape prefix `\x1b`) sequences to tmux. This enables Mac-native shortcuts in terminal:

| Ghostty Cmd Key | Sends to tmux | tmux Action |
|-----------------|---------------|-------------|
| `Cmd+d` | `M-d` (\x1bd) | Split pane vertical |
| `Cmd+Shift+d` | `M-D` (\x1bD) | Split pane horizontal |
| `Cmd+r` | `M-r` (\x1br) | New window |
| `Cmd+Shift+r` | `M-R` (\x1bR) | Reload tmux config |
| `Cmd+w` | `M-w` (\x1bw) | Close pane |
| `Cmd+1-9` | `M-1-9` | Switch to window 1-9 |
| `Cmd+[` / `Cmd+]` | `M-[` / `M-]` | Navigate panes/windows |
| `Cmd+f` | `M-f` (\x1bf) | tmux search/find |
| `Cmd+a` | `M-a` (\x1ba) | Enter copy mode |
| `Cmd+t` | `M-t` (\x1bt) | Toggle thinking (Claude Code) |

The escape sequence `\x1b` is the Meta prefix. For example, `\x1bd` = Escape+d = Meta-d.

## tmux Integration

- Ghostty auto-launches tmux session `main` on startup
- All window/pane management happens in tmux, not Ghostty
- Ghostty runs as a single window; tmux provides the multiplexing
- Changes to keybinds here must coordinate with `~/.config/tmux/tmux.conf` Meta bindings

## Config Syntax

```
key = value
keybind = modifier+key=action
```

One setting per line, `#` for comments. Keep settings grouped by function.
