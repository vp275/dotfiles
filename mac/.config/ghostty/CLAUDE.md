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
- `background-opacity = .95`, `background-blur-radius = 200`

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
| `Cmd+d` | `M-d` | Split pane horizontal |
| `Cmd+Shift+d` | `M-D` | Split pane vertical |
| `Cmd+r` | `M-r` | New window |
| `Cmd+Shift+r` | `M-R` | Reload tmux config |
| `Cmd+w` | `M-w` | Close pane |
| `Cmd+Shift+w` | `M-W` | Close window |
| `Cmd+1-9` | `M-1-9` | Switch to window 1-9 |
| `Cmd+[` / `Cmd+]` | `M-[` / `M-]` | Previous/next window |
| `Cmd+f` | `M-f` | tmux search/find |
| `Cmd+a` | `M-a` | Enter copy mode |
| `Cmd+z` | `M-z` | Zoom pane |
| `Cmd+e` | `M-e` | Flat picker (windows) |
| `Cmd+Shift+e` | `M-E` | Session picker |
| `Cmd+s` | `M-s` | Choose session |
| `Cmd+Shift+s` | `M-S` | Save session (resurrect) |
| `Cmd+t` | `M-t` | New window |
| `Cmd+Shift+t` | `M-T` | Restore session (resurrect) |
| `Cmd+n` | `M-n` | New session (with name) |
| `Cmd+o` | `M-o` | Sessionx picker |
| `Ctrl+Tab` | `C-Right` | Next window |
| `Ctrl+Shift+Tab` | `C-Left` | Previous window |

The escape sequence `\x1b` is the Meta prefix. For example, `\x1bd` = Escape+d = Meta-d.

## tmux Integration

- Ghostty auto-launches tmux session `main` on startup
- All window/pane management happens in tmux, not Ghostty
- Ghostty runs as a single window; tmux provides the multiplexing
- Changes to keybinds here must coordinate with `~/.config/tmux/tmux.conf` Meta bindings
- Restart Ghostty to apply keybind changes (no hot reload)

## Config Syntax

```
key = value
keybind = modifier+key=action
```

One setting per line, `#` for comments. Keep settings grouped by function.
