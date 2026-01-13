# Aerospace Configuration Changelog

## 2026-01-08
- Changed `alt-tab` from `workspace-back-and-forth` to cycle through non-empty workspaces on the focused monitor

## 2026-01-03
- Set Ghostty windows to floating to avoid tab-induced tiling splits

## 2025-09-20
- Fixed workspace 0/10 keybinding inconsistency: unified alt+0 and alt+shift+0 to workspace 10
- Reorganized workspace 2: moved Calendar and SuperWhisper from ws4/ws6, removed Terminal assignment
- Added SuperWhisper floating layout mode
- Assigned trading apps: TradingView→ws4, IB Gateway→ws5, Trader Workstation→ws6
- Added music streaming apps to workspace 10: Spotify and YouTube Music
- Fixed YouTube Music rule precedence to prevent assignment to workspace Y

## 2025-08-31
- Added Books app configuration: auto-assign to workspace O with floating layout

## 2025-08-20
- Removed default workspace assignments for Warp and Ghostty terminals
- Removed workspace 1 monitor assignment to secondary

## 2025-08-14
- Enabled workspace E for Finder, reorganized terminals (Warp→1, Terminal/Ghostty→2)
- Removed mpv workspace assignments due to file association conflicts

## 2025-08-10
- Added `alt-esc`: Cycle through windows in current workspace with wrap-around

## 2025-08-07
- Added `ctrl-alt-n`: Launch Safari in private browsing mode
- Changed Safari default workspace from S to N

## 2025-08-06

### App Workspace Assignments
- Added comprehensive app-to-workspace assignments using `on-window-detected` for automatic window placement
- Configured workspace-to-monitor assignments for dual-monitor setup

### Custom Keybindings
- Added `alt-shift-backtick`: Move window to next available empty workspace

## 2025-07-31

### Customizations from Default Config

**Window Gaps**
- Removed all window gaps (set to 0) for a more compact tiling layout without spacing between windows

**Workspace Bindings**
- Extended alphabet workspace support to include: A, B, C, D, F, G, I, M, N, O, P, Q, R, S, T, U, V, W, Y, Z
- Disabled workspace E and X bindings (commented out)

**Custom Keybindings**
- `alt-backtick`: Switch to first empty workspace on current monitor
- `alt-enter`: Launch terminal application

**Service Mode Additions**
- Added volume controls in service mode: `up/down` for volume adjustment, `shift-down` for mute

**Configuration Location**
- Moved config from `~/.aerospace.toml` to `~/.config/aerospace/aerospace.toml` following XDG Base Directory specification
