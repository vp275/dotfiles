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

- Workspace 1: main monitor (default)
- Workspaces 2-10, E, F, M, Z: secondary monitor
- Workspace D: main monitor (Emacs)

## App Assignments

| Workspace | Apps |
|-----------|------|
| 2 | Calendar, SuperWhisper (floating) |
| 3 | Things |
| 4-6 | TradingView, IB Gateway, TWS |
| 8 | Discord, Telegram, WhatsApp |
| 10 | Spotify, YouTube Music |
| A | Excel, Word, sioyek |
| B | Arc, Firefox, Brave |
| C | ChatGPT, Chrome |
| D | Emacs, Day One |
| E | Finder (floating), mpv (floating) |
| F | Drafts |
| G | Gemini |
| M | Gmail |
| N | Safari, Notion |
| O | Books (floating), Obsidian |
| P | VS Code |
| S | Comet (Reddit) |
| V | Claude |
| Y | YouTube |

## Floating Apps

These apps launch floating instead of tiled: Ghostty, SuperWhisper, Finder, Books, mpv.

## Gotchas

- **App matching**: Uses `app-name-regex-substring` (partial match) or `app-id` for specific bundle IDs
- **Ghostty is floating**: Uses native macOS tabs, so it floats. Terminal workspace switching happens via tmux.
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