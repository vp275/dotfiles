# CLAUDE.md

AeroSpace tiling window manager config for macOS. i3-like behavior with vim-style keybindings.

## Commands

```bash
aerospace reload-config          # Apply changes (or alt-shift-; then esc)
aerospace list-windows --all     # Debug window assignments
aerospace list-workspaces        # See all workspaces
```

## Keybindings

**Navigation** (alt + vim keys):
- `alt-hjkl` - Focus window left/down/up/right
- `alt-shift-hjkl` - Move window left/down/up/right

**Workspaces**:
- `alt-[1-0]` - Switch to workspace 1-10
- `alt-[a-z]` - Switch to letter workspace (except r, x reserved)
- `alt-shift-[key]` - Move window to that workspace
- `alt-tab` - Cycle non-empty workspaces on current monitor
- `alt-backtick` - Jump to next empty workspace
- `cmd-shift-backtick` - Move window to first empty workspace on the other monitor
- `alt-shift-tab` - Move workspace to next monitor

**Layout**:
- `alt-/` - Toggle tiles horizontal/vertical
- `alt-,` - Toggle accordion layout
- `alt--` / `alt-=` - Resize window

**Service mode** (`alt-shift-;`):
- `esc` - Reload config and exit
- `r` - Reset/flatten workspace layout
- `f` - Toggle floating/tiling
- `backspace` - Close all windows but current

## Monitor Setup

- Primary letter workspaces prefer `LG HDR 4K`, falling back to macOS `main`.
- Workspace 1 plus workspaces 2-10, E, F, M, Y, Z prefer the built-in display, falling back to `secondary` then `main`.
- AeroSpace `main` follows macOS System Settings -> Displays -> Use as Main Display; the config targets the LG by name so the main workspace group does not depend on that OS setting.

## App Assignments

| Workspace | Apps |
|-----------|------|
| 1 | Ghostty (floating), Alacritty (floating), cmux (floating), Warp (floating) |
| 2 | Calendar, SuperWhisper (floating) |
| 3 | Things |
| 4-6 | TradingView, IB Gateway, TWS |
| 8 | Discord, Telegram, WhatsApp |
| 10 | Spotify, YouTube Music |
| A | Excel, Word, sioyek |
| B | Arc, Firefox, Brave, Helium |
| C | ChatGPT, Chrome |
| D | Emacs |
| E | Finder (floating), mpv (floating) |
| F | Drafts |
| G | Gemini |
| M | Gmail |
| N | Safari, Notion |
| O | Books (floating), Obsidian |
| P | VS Code |
| S | Comet (Reddit), Day One |
| V | Claude |
| Y | YouTube |

## Floating Apps

These apps launch floating instead of tiled: Ghostty, Alacritty, cmux, Warp, SuperWhisper, Finder, Books, mpv, Codex, CleanShot X, System Settings.

CleanShot X and System Settings are floated in place so utility windows stay in the workspace where they were invoked instead of hitting the empty-workspace catch-all.

PiP handling is centralized in `~/.local/bin/aerospace-pip-guardian`. Its automatic workspace-change mode moves AeroSpace-managed Helium `Picture-in-picture` windows to the focused workspace and unhides hidden Brave-owned YouTube PWA PiP windows. Press `ctrl-alt-p` to run the stronger recovery mode, which also recreates stale Helium native PiP windows by toggling the Google PiP extension.

## Gotchas

- **App matching**: Uses `app-name-regex-substring` (partial match) or `app-id` for specific bundle IDs
- **Terminals float on workspace 1**: Ghostty, Alacritty, cmux, and Warp all use `layout floating` and pin to workspace 1, since they rely on native macOS tabs/windows rather than aerospace tiling. (Ghostty workspace switching historically went through tmux.)
- **YouTube PWA PiP can vanish**: The `YouTube` app is a Brave app-mode wrapper (`com.brave.Browser.app...`), but its PiP window is owned by the parent `Brave Browser` process. If PiP disappears, check whether `Brave Browser` is hidden while `YouTube` is visible. `aerospace-pip-guardian auto` usually recovers this; use `ctrl-alt-p` for manual recovery.
- **Zero gaps**: `[gaps]` section has all values at 0
- **Mouse follows monitor**: When focus changes monitors, mouse moves to center
- **No sticky windows**: Feature not yet supported (issue #2)
- **Reserved bindings**: `alt-r` and `alt-x` are commented out

## Adding New App Assignment

```toml
[[on-window-detected]]
if.app-name-regex-substring = 'AppName'
run = 'move-node-to-workspace X'

# Or for floating:
run = ['layout floating', 'move-node-to-workspace X']

# Or by bundle ID (more precise):
if.app-id = 'com.company.appname'
```

Find app bundle ID: `osascript -e 'id of app "AppName"'`
