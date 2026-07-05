# AGENTS.md

Guidance for Codex and other AI agents working in this AeroSpace config.

## Scope

- Applies to `mac/.config/aerospace/` in the dotfiles repo.
- This directory configures AeroSpace, the macOS tiling window manager, via `aerospace.toml`.
- The config is managed through GNU Stow and is intended to appear at `~/.config/aerospace/aerospace.toml`.
- Before behavioral edits, read `aerospace.toml`, `CLAUDE.md`, and `CHANGELOG.md`.
- Treat `aerospace.toml` as the source of truth when docs disagree. `CLAUDE.md` is the best human summary.

## Commands

```bash
aerospace reload-config          # Validate and apply config edits
aerospace list-windows --all     # Inspect app names, bundle IDs, workspaces
aerospace list-workspaces        # Inspect configured/active workspaces
aerospace list-apps              # Find bundle IDs for app matching rules
osascript -e 'id of app "AppName"'  # Alternative bundle ID lookup
```

Run `aerospace reload-config` after changing `aerospace.toml`. For documentation-only edits, no reload is needed.

## Files

- `aerospace.toml`: main config and source of truth.
- `CLAUDE.md`: concise overview of commands, keybindings, workspace assignments, and gotchas.
- `CHANGELOG.md`: dated behavior history; update it for meaningful config changes.
- `AGENTS.md`: agent-facing working notes.

## Current Config Model

- Starts AeroSpace at login.
- Uses flattened container normalization and opposite-orientation normalization.
- Default layout is `tiles`; root orientation is `auto`.
- Accordion padding is `30`.
- All inner and outer gaps are `0`.
- Mouse moves to lazy center when focus changes monitors.
- macOS hidden apps are not automatically unhidden.

## Monitor Assignments

- Workspace `D` is forced to `main`.
- Workspaces `2`-`10`, `E`, `F`, `M`, and `Z` are forced to `secondary`.
- Workspace `1` is not forced and acts as the default terminal workspace.

## App Assignment Rules

Rules are ordered. Specific rules must stay above broader rules, and the final catch-all rule must remain last.

| Workspace | Current automatic assignments |
| --- | --- |
| `1` | Ghostty, Alacritty, cmux, Warp; all floating |
| `2` | Calendar; SuperWhisper floating |
| `3` | Things |
| `4` | TradingView |
| `5` | IB Gateway |
| `6` | Trader Workstation |
| `8` | Discord, Telegram, WhatsApp |
| `10` | Spotify, YouTube Music |
| `A` | Microsoft Excel, Microsoft Word, sioyek |
| `B` | Arc, Firefox, Brave, Helium |
| `C` | ChatGPT, Chrome, Codex floating |
| `D` | Emacs |
| `E` | Finder floating |
| `F` | Drafts |
| `G` | Gemini |
| `M` | Gmail |
| `N` | Safari, Notion |
| `O` | Books floating, Obsidian |
| `S` | Comet, Day One |
| `V` | Claude |
| `Y` | YouTube |

Additional rules:

- `mpv` is floating only and is not moved to a fixed workspace.
- `exec-on-workspace-change` runs `~/.local/bin/aerospace-pip-guardian auto`, which keeps known PiP cases visible without using a generic sticky-window workaround.
- Cloudflare WARP, 1Password, and `com.apple.LocalAuthentication.UIAgent` are floating match-and-stop rules so menu-bar popovers do not hit the catch-all.
- Unassigned apps hit the final catch-all and move to the first empty workspace on the focused monitor.

## PiP Troubleshooting

- The `YouTube` app is a Brave app-mode wrapper with bundle id `com.brave.Browser.app.agimnkijcaahngcdmfeangaknmldooml`.
- Its picture-in-picture window can be owned by the hidden parent `Brave Browser` process (`com.brave.Browser`), not by the visible `YouTube` app window that AeroSpace manages on workspace `Y`.
- Symptom: `aerospace list-windows --all` shows only the `YouTube` window, while System Events or CoreGraphics sees `Brave Browser` with a `Picture-in-picture` window marked offscreen or hidden.
- Automatic recovery: `~/.local/bin/aerospace-pip-guardian auto` runs on workspace changes. It moves managed Helium PiP windows and activates hidden Brave when a Brave-owned `Picture-in-picture` window exists.
- Manual recovery: `ctrl-alt-p` runs `~/.local/bin/aerospace-pip-guardian recover`. It also recreates stale Helium native PiP windows, where CoreGraphics sees `Helium` / `Picture-in-picture` but `aerospace list-windows --all` does not.
- Keep YouTube/Brave and Helium branches separate. YouTube PWA PiP is usually a hidden-parent-Brave problem; Helium PiP is usually an AeroSpace-managed-window or stale-native-window problem.

## Keybindings

- `alt-hjkl`: focus left/down/up/right.
- `alt-shift-hjkl`: move window left/down/up/right.
- `alt-/`: toggle tiles horizontal/vertical.
- `alt-,`: toggle accordion horizontal/vertical.
- `alt--` / `alt-=`: resize smart -50/+50.
- `alt-1` through `alt-0`: switch to workspaces `1` through `10`.
- Letter workspace bindings exist for `A B C D E F G I M N O P Q S T U V W Y Z`; `R` and `X` are commented out.
- Move-to-workspace bindings mostly mirror switch bindings, but `alt-shift-e`, `alt-shift-r`, and `alt-shift-x` are commented out.
- `alt-tab`: cycle through non-empty workspaces on the focused monitor.
- `alt-shift-tab`: move current workspace to the next monitor.
- `alt-backtick`: switch to the next empty workspace on the focused monitor.
- `alt-shift-backtick`: move the focused window to the next empty workspace on the focused monitor.
- `alt-esc`: cycle windows in the current workspace.
- `ctrl-alt-n`: launch Safari private browsing via `~/.config/myFiles/macos/safari_incognito.scpt`.

Service mode starts with `alt-shift-;`:

- `esc`: reload config and return to main mode.
- `r`: flatten/reset the workspace layout.
- `f`: toggle floating/tiling.
- `backspace`: close all windows except current.
- `alt-shift-hjkl`: join with neighboring container.
- `up` / `down`: volume up/down.
- `shift-down`: mute and return to main mode.

## Editing Rules

- Prefer `if.app-id` for precise app rules when the bundle ID is known.
- Use `if.app-name-regex-substring` for flexible name matching, but beware broad matches.
- Keep `YouTube Music` above `YouTube`.
- If reintroducing a VS Code rule, prefer its bundle ID instead of matching `Code`, because broad name matching can catch unrelated apps.
- Keep terminal apps that rely on native tabs/windows floating on workspace `1`: Ghostty, Alacritty, cmux, and Warp.
- Add menu-bar/popover exclusions above the catch-all using `run = ['layout floating']`.
- Keep the catch-all as the final `[[on-window-detected]]` block.
- For significant behavior changes, update `CHANGELOG.md` and keep `CLAUDE.md`/`AGENTS.md` aligned with the real config.

## Known Doc Drift To Watch

- `CLAUDE.md` is closer to current state, but verify workspace tables against `aerospace.toml` before editing.
- The live config currently has no automatic VS Code assignment even though some docs mention workspace `P`.
- The live config floats `mpv` in place rather than moving it to workspace `E`.
