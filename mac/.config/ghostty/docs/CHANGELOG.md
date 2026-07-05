# Ghostty Config Changelog

## 2026-07-01 - Add ranger launcher keybind

- Added `Cmd+R` (`super+r`) to clear the current shell prompt and run `ranger`.

## 2026-07-01 - Disable ranger autostart

- Removed the `command` override so new Ghostty sessions start with the normal
  login shell again instead of opening `ranger`.

## 2026-07-01 - Rebalance Mercedes Petronas theme

- Restored `theme = mercedes-petronas`.
- Adjusted the custom theme so ANSI black is visible against the background and
  restored cyan/bright-cyan to the Petronas teal values used by shell tools.

## 2026-06-30 - Preserve ranger exit directory

- Updated `ghostty-ranger-session` to launch `ranger` with `--choosedir`, then
  `cd` to ranger's final directory before starting the fallback login `zsh`.

## 2026-06-29 — Start Ghostty in ranger

- Added `command = /Users/vp/.local/bin/ghostty-ranger-session` so new Ghostty
  sessions open into `ranger`.
- Added a small wrapper that runs Homebrew's `ranger` first, then starts a login
  `zsh` after ranger exits so quitting ranger does not close the terminal.

## 2026-06-16 — Strip to stock defaults, keep a minimal set

### Goal
Try Ghostty's out-of-the-box feel without the personal customizations, then keep
only a small set that's actually wanted. The terminal stack previously routed all
Cmd keys to tmux and auto-launched tmux; this change drops that to use native
Ghostty behavior (native tabs/splits, native smooth scrollback, native Cmd
shortcuts).

### What was kept vs removed

| # | Setting | Value | Status | Notes |
|---|---------|-------|--------|-------|
| 1 | `theme` | `mercedes-petronas` | ✅ Kept | Black/teal theme |
| 2 | `background-opacity` | `0.98` | ✅ Kept | Slight transparency |
| 3 | `font-family` | `JetBrainsMono Nerd Font` | ❌ Removed | Using Ghostty's default font |
| 4 | `font-style` | `Light` | ❌ Removed | Default weight |
| 5 | `font-size` | `20` | ✅ Kept | Size 20 on the default font |
| 6 | `font-thicken` | `false` | ❌ Removed | Same as default, no effect |
| 7 | `clipboard-write` | `allow` | ❌ Removed | Redundant — already the default |
| 8 | `clipboard-read` | `allow` | ❌ Removed | Only needed to silence OSC52 read prompts |
| 9 | `copy-on-select` | `clipboard` | ❌ Removed | Only for select-to-system-clipboard |
| 10 | `keybind` (Cmd→Meta block, ~45 binds) | — | ❌ Removed | Native Ghostty shortcuts now active; no tmux routing |
| 11 | `command` (`tmux new-session -A -s '⭐ main'`) | — | ❌ Removed | No auto-tmux; native scrollback |
| 12 | `config-file` (`~/.config/ghostty/config.local`) | — | ❌ Removed | Machine override include no longer loaded |

### Notes on the removals
- **Clipboard (7/8/9):** basic copy/paste (Cmd+C / Cmd+V) works on stock defaults,
  so these were unnecessary. Re-add `clipboard-read = allow` if OSC52 paste prompts
  get annoying, or `copy-on-select = clipboard` to auto-copy mouse selections.
- **Keybinds (10):** the old block only re-sent Cmd keys to tmux as Meta sequences
  (e.g. `cmd+d` → `\x1bd`). It added no native features, so removing it restores all
  native Ghostty Cmd shortcuts (tabs, splits, search, font size, select-all, command
  palette `cmd+shift+p`, etc.). The tradeoff: Cmd keys now drive Ghostty's own
  tabs/splits instead of tmux.
- **Auto-tmux (11):** with this off, Ghostty no longer launches tmux on startup. An
  existing tmux session keeps running in the background and can be reattached
  manually (`tmux attach -t '⭐ main'`).

### Backup of the previous (pre-change) config
The full config as it was before this change is archived at:

    docs/config.original-2026-06-16.bak

### How to restore the previous setup
```bash
cp ~/.config/ghostty/docs/config.original-2026-06-16.bak ~/.config/ghostty/config
# then fully quit (Cmd+Q) and relaunch Ghostty
```
Or, since this is tracked in the dotfiles repo:
```bash
git -C ~/.dotfiles checkout -- mac/.config/ghostty/config
```
