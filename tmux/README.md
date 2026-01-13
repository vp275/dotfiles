# tmux config notes

This folder is tuned so tmux feels like macOS apps: common window/pane actions
are bound to Command-style shortcuts, with Ghostty configured to forward those
keys to tmux as Meta. The goal is minimal prefix use, left-hand ergonomics, and
predictable key behavior inside tmux.

## Why this setup

- Prefer Mac-like shortcuts for window/pane management.
- Keep hands on the left side of the keyboard where possible.
- Let Ghostty pass Cmd combos through to tmux instead of handling them itself.
- Preserve tmux defaults where they already work (prefix-based actions).

## Core tmux settings

- Prefix: `Ctrl+a`
- Mouse: on
- Clipboard: `set-clipboard on` (copy-pipe to `xclip` for copy-mode)
- Indexing: windows and panes start at 1
- Mode keys: vi

## Unprefixed tmux bindings (Meta = Cmd via Ghostty)

These are set in `tmux.conf` and expect Ghostty to send Cmd as Meta.

- `Cmd+d` / `Cmd+Shift+d`: split horizontal / vertical
- `Cmd+t` / `Cmd+Shift+t`: new window
- `Cmd+w` / `Cmd+Shift+w`: kill pane / kill window
- `Cmd+1..9`: select window 1..9
- `Cmd+[` / `Cmd+]`: previous / next window
- `Cmd+r`: reload `~/.config/tmux/tmux.conf`
- `Cmd+f`: enter copy-mode and prompt for incremental search
- `Cmd+e`: choose-tree (window list)
- `Cmd+s`: choose-session (session list)
- `Cmd+z`: zoom current pane (toggle)
- `Cmd+``: next pane (clockwise)
- `Cmd+Shift+``: previous pane (counter-clockwise)

## Ctrl+Tab window navigation

Some terminals do not send distinct Ctrl+Tab sequences, so tmux listens for
both variants.

- `Ctrl+Tab` / `Ctrl+Shift+Tab`: next / previous window
- `Ctrl+Right` / `Ctrl+Left`: next / previous window (Ghostty remap target)

## Ghostty keybind overrides

Ghostty is configured to forward Cmd combos to tmux as Meta sequences. Keep
these two files in sync:

- `~/.config/ghostty/config`
- `~/.config/Ghostty/config`

Examples (Ghostty `keybind` entries):

- `cmd+w` -> `text:\x1bw`
- `cmd+1` / `cmd+digit_1` -> `text:\x1b1`
- `cmd+bracket_left` / `cmd+bracket_right` -> `text:\x1b[` / `text:\x1b]`
- `cmd+backquote` / `cmd+shift+backquote` -> `text:\x1b\x60` / `text:\x1b\x7e`
- `ctrl+tab` / `ctrl+shift+tab` -> `text:\x1b[1;5C` / `text:\x1b[1;5D`

## Reload / test

- Reload tmux config: `Cmd+r` (or `tmux source-file ~/.config/tmux/tmux.conf`)
- Reload Ghostty: restart Ghostty
- Validate Ghostty config: `ghostty +validate-config`

