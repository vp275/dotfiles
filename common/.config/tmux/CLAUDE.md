# CLAUDE.md

Tmux configuration with Mac-style keybindings. Uses Ctrl+a prefix and vi mode.

## Key Bindings

Meta (M-) bindings work because Ghostty forwards Cmd as Meta. These feel like native Mac shortcuts:

| Binding | Action |
|---------|--------|
| M-d | Split horizontal |
| M-D | Split vertical |
| M-r | New window |
| M-w | Close pane |
| M-W | Close window |
| M-1 to M-9 | Switch to window 1-9 |
| M-[ / M-] | Previous/next window |
| C-Tab / C-S-Tab | Next/previous window |
| M-R | Reload config |
| M-f | Search in copy mode |
| M-a | Enter copy mode |
| M-z | Zoom pane (🔴 indicator shows when zoomed) |
| C-` | Cycle sessions |
| M-` / M-~ | Cycle panes forward/backward |

### Session Management

| Binding | Action |
|---------|--------|
| M-e | Flat picker (all windows across sessions) |
| M-E | Session picker (sessions only) |
| M-s | Choose session (built-in) |
| M-n | New session (prompts for name) |
| M-o | Sessionx (fuzzy session picker) |
| M-S | Save session (resurrect) |
| M-T | Restore session (resurrect) |

## Plugins

TPM manages plugins. Run `Ctrl+a, I` to install after fresh clone.

- **tpm** - Plugin manager
- **tmux-resurrect** - Save/restore sessions manually
- **tmux-continuum** - Auto-save every 15 mins, auto-restore on start
- **tmux-sessionx** - Fuzzy session picker

## Custom Scripts

Located in `~/.local/bin/` (symlinked from `common/.local/bin/`):

- `tmux-flat-picker` - fzf table view of all windows (M-e)
- `tmux-session-picker` - fzf table view of sessions only (M-E)

## Commands

```bash
# Reload config (or use M-R inside tmux)
tmux source-file ~/.config/tmux/tmux.conf

# Install TPM plugins (or use Ctrl+a, I)
~/.config/tmux/plugins/tpm/bin/install_plugins
```

## Status Bar

Mercedes Petronas themed. Shows: session name, window list (with 🔴 zoom indicator), SPX/VIX tickers, NY time, local time.

## Notes

- PATH is set at top of config for plugin script compatibility
- Plugins directory is gitignored (install via TPM on new machines)
- Window/pane numbering starts at 1
