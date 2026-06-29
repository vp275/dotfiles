# CLAUDE.md

Tmux configuration using Ctrl+a prefix, vi mode, TPM plugins, and a Mercedes
Petronas status bar.

## Current Terminal Relationship

The tmux config still defines Meta (`M-`) bindings for Mac-style ergonomics, but
the current Ghostty config does not forward Cmd keys as Meta. Ghostty now uses
native tabs, splits, scrollback, and Cmd shortcuts.

The old Ghostty Cmd-to-Meta setup is archived in:

```text
mac/.config/ghostty/docs/config.original-2026-06-16.bak
```

If that setup is restored, the Meta bindings below become Cmd-style shortcuts
again.

## Key Bindings

| Binding | Action |
|---------|--------|
| M-d | Split horizontal |
| M-D | Split vertical |
| M-t | New window |
| M-w | Close pane |
| M-W | Close window |
| M-1 to M-9 | Switch to window 1-9 |
| M-[ / M-] | Previous/next window |
| C-Tab / C-S-Tab | Next/previous window |
| C-Right / C-Left | Next/previous window fallback |
| M-R | Reload config |
| M-f | Search in copy mode |
| M-a | Enter copy mode |
| M-z | Zoom pane |
| C-` | Cycle sessions |
| M-` / M-~ | Cycle panes forward/backward |

### Session Management

| Binding | Action |
|---------|--------|
| M-e | Flat picker, all windows across sessions |
| M-E | Session picker |
| M-s | Choose session |
| M-n | New session, prompts for name |
| M-o | Sessionx fuzzy session picker |
| M-S | Save session with resurrect |
| M-T | Restore session with resurrect |

## Plugins

TPM manages plugins. Run `Ctrl+a, I` to install after fresh clone.

- **tpm** - Plugin manager
- **tmux-resurrect** - Save/restore sessions manually
- **tmux-continuum** - Auto-save every 15 mins and auto-restore on start
- **tmux-sessionx** - Fuzzy session picker

## Custom Scripts

Located in `~/.local/bin/`, stowed from `mac/.local/bin/`:

- `tmux-flat-picker` - fzf table view of all windows
- `tmux-session-picker` - fzf table view of sessions only
- `tmux-session-cycler` - compact session cycler popup
- `tmux-record-focus` - focus tracking helper for picker sorting

## Commands

```bash
# Reload config
tmux source-file ~/.config/tmux/tmux.conf

# Install TPM plugins
~/.config/tmux/plugins/tpm/bin/install_plugins
```

## Status Bar

Mercedes Petronas themed. Shows the session name, window list, VQA/Stripe
revenue helper output, NY time, local date, and local time.

Window names auto-rename to the basename of the active pane's cwd. In the status
bar, names are truncated to 10 chars; the underlying window name stays full
length so scripts and pickers still see it intact.

## Notes

- PATH is set at top of config for plugin script compatibility.
- Plugins directory is gitignored for new files, but existing tracked plugin
  files are intentionally left alone.
- Window and pane numbering starts at 1.
- Clipboard copy-mode uses `pbcopy` on macOS and keeps an `xclip` fallback.
