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
| M-R | Reload config |
| M-f | Search in copy mode |
| M-a | Enter copy mode |
| M-e | Choose tree |
| M-s | Choose session |
| M-z | Zoom pane |
| M-` / M-~ | Cycle panes forward/backward |

Prefix (Ctrl+a) bindings use standard tmux defaults.

## Commands

```bash
# Reload config (or use M-r inside tmux)
tmux source-file ~/.config/tmux/tmux.conf

# Install/update TPM plugins
~/.config/tmux/plugins/tpm/bin/install_plugins
~/.config/tmux/plugins/tpm/bin/update_plugins
```

## Config Structure

- `set -g` for global options
- `setw -g` for window options
- `bind -n` for unprefixed (no prefix needed) bindings
- Key names: `C-` = Control, `M-` = Meta/Alt

## Plugins

TPM manages plugins. Add plugins with `set -g @plugin 'owner/name'` before the `run` line.

Current: tpm (plugin manager only)

## Status Bar

Custom status bar shows: session name, S&P 500, VIX, NY time, local time. Stock tickers require `~/.local/bin/sp500-ticker` and `~/.local/bin/vix-ticker`.
