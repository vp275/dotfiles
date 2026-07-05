# Aerospace Configuration Changelog

## 2026-07-04
- Added `aerospace-pip-guardian` with separate PiP branches instead of one-off fixes:
  - `auto` runs from `exec-on-workspace-change`, moves managed Helium PiP windows to the focused workspace, and unhides hidden Brave-owned YouTube PWA PiP windows.
  - `recover` is bound to `ctrl-alt-p` and additionally recreates stale Helium native PiP windows by toggling Helium's Google Picture-in-Picture extension.

## 2026-07-01
- Documented YouTube Brave app-mode PiP recovery notes. The YouTube PWA (`com.brave.Browser.app.agimnkijcaahngcdmfeangaknmldooml`) can create PiP under the hidden parent Brave process (`com.brave.Browser`), leaving the PiP present but offscreen. Runtime recovery is to activate Brave Browser; no persistent AeroSpace config change was kept.

## 2026-06-29
- Added Alacritty (`org.alacritty`) to workspace 1 with the same floating treatment as Ghostty: `run = ['layout floating', 'move-node-to-workspace 1']`.

## 2026-06-08
- Restored Ghostty floating layout: changed its rule from `run = 'move-node-to-workspace 1'` to `run = ['layout floating', 'move-node-to-workspace 1']`. The floating layout had been dropped despite the 2026-01-03 change and the CLAUDE.md "Ghostty is floating" note, so the config now matches the docs again.
- Added cmux terminal (`com.cmuxterm.app`) with the same treatment as Ghostty: `run = ['layout floating', 'move-node-to-workspace 1']`. Previously it had no rule, so the catch-all moved it to the first empty workspace.
- Added Warp terminal (`dev.warp.Warp-Stable`) with the same treatment: `run = ['layout floating', 'move-node-to-workspace 1']`. Re-adds a Warp assignment that was removed on 2025-08-20, this time floating.
- Added Helium browser (`net.imput.helium`) to workspace B, matching the Brave rule (`run = 'move-node-to-workspace B'`, tiled, no floating).

## 2026-05-28
- Moved Day One from workspace D to workspace S (shared with Comet), freeing D for Emacs only

## 2026-05-07
- Added menu bar / popover exclusion rules above the catch-all so their windows are not moved to an empty workspace:
  - Cloudflare WARP (`com.cloudflare.1dot1dot1dot1.macos`)
  - 1Password (`com.1password.1password`)
  - macOS LocalAuthentication agent (`com.apple.LocalAuthentication.UIAgent`), used by the 1Password Quick Access launcher (Cmd+Shift+Space) and Touch ID / system password prompts
- Each exclusion uses `run = ['layout floating']` as a benign no-op that matches and stops further callbacks (an empty `run = []` did not reliably block the catch-all).
- Add new offenders the same way: discover the bundle id via `aerospace list-apps` (or `aerospace list-windows --all` while the popover is visible) and insert a block above the catch-all.

## 2026-05-05
- Added catch-all `on-window-detected` rule at the end of the rule list: any app without an explicit workspace assignment is moved to the first empty workspace on the focused monitor (uses the same shell pattern as `alt-shift-backtick`). Apps with specific rules above are unaffected because matching rules set `check-further-callbacks = false` by default. The catch-all must remain the last `[[on-window-detected]]` block in the file.

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
