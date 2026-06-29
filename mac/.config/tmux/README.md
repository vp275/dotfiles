# tmux config notes

This folder keeps tmux comfortable for keyboard-heavy work: Ctrl+a prefix,
vi-style copy mode, mouse support, session restore, custom pickers, and a
Mercedes Petronas status bar.

## Current Ghostty relationship

Ghostty no longer forwards Cmd combos to tmux as Meta. The live Ghostty config
is minimal and uses native Ghostty tabs, splits, search, scrollback, and Cmd
shortcuts.

The tmux Meta bindings still exist. They are useful in terminals that send Meta,
or if the archived Ghostty Cmd-to-Meta config is restored from:

```text
~/.config/ghostty/docs/config.original-2026-06-16.bak
```

## Core tmux settings

- Prefix: `Ctrl+a`
- Mouse: on
- Clipboard: `set-clipboard on`
- Indexing: windows and panes start at 1
- Mode keys: vi
- Extended keys enabled with csi-u format

## Unprefixed tmux bindings

These are set in `tmux.conf` as Meta/control bindings:

- `M-d` / `M-D`: split horizontal / vertical
- `M-t` / `M-W`: new window / kill window
- `M-w`: kill pane
- `M-1..9`: select window 1..9
- `M-[` / `M-]`: previous / next window
- `M-R`: reload `~/.config/tmux/tmux.conf`
- `M-f`: enter copy-mode and prompt for incremental search
- `M-e` / `M-E`: custom window/session pickers
- `M-S` / `M-T`: resurrect save / restore
- `M-z`: zoom current pane
- `M-`` / `M-~`: next / previous pane
- `C-Tab` / `C-S-Tab`: next / previous window
- `C-Right` / `C-Left`: next / previous window fallback

## Mouse scrolling

With `mouse on`, the wheel/trackpad scrolls tmux copy-mode, not native terminal
scrollback. tmux scrolls in whole-line jumps, so the step size is tuned in
`tmux.conf`:

```tmux
bind -T copy-mode-vi WheelUpPane   send-keys -X -N 2 scroll-up
bind -T copy-mode-vi WheelDownPane send-keys -X -N 2 scroll-down
```

`-N 2` means 2 lines per wheel event.

## Session restore gotcha

continuum restores the latest resurrect snapshot on every fresh server start.
If junk sessions exist when a snapshot is taken, they come back forever. Fix by
killing the junk sessions, then forcing a fresh snapshot with `M-S` or:

```bash
~/.config/tmux/plugins/tmux-resurrect/scripts/save.sh
```

## Reload / test

- Reload tmux config: `tmux source-file ~/.config/tmux/tmux.conf`
- Validate Ghostty config after related terminal changes:
  `ghostty +validate-config --config-file ~/.config/ghostty/config`
