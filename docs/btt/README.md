# BetterTouchTool Gesture Setup

Last audited: 2026-07-07

## Goal

Keep BetterTouchTool gestures predictable across the MacBook trackpad and any
future Magic Mouse experiments, without disturbing the MX Master 3S setup in
Logitech Options+.

The current known-good setup uses BTT for MacBook trackpad gestures:

- 3-finger swipe right opens BTT's native Application Switcher.
- 3-finger swipe left sends `Cmd+Delete`.
- 3-finger tap triggers Wispr Flow hands-free through right Option.
- 4-finger tap sends `Return`.
- In Codex only, 2-finger swipe right opens the chat switcher list with one
  `Ctrl+Tab` hold window. Lifting the final trackpad finger clicks the currently
  hovered chat and releases Control.
- 3-finger click is disabled and reserved for future use.
- Ducky One 2 F4 and F8 are handled outside BTT by
  `~/.local/bin/ducky-f8-aerospace-listener`, which calls
  `~/.local/bin/protonvpn-app-toggle` for F4 and
  `~/.local/bin/aerospace-toggle-enabled` for F8. BTT has a periodic automation
  that starts the listener if it is not already running.
- MacBook built-in F4 is first remapped from Apple's Spotlight/Search HID usage
  to normal F4 by `~/.local/bin/macbook-f4-proton-key`, then handled by the same
  listener.

Related Logitech/Wispr docs live here:

[Logitech Options+ and Wispr Flow setup](../logitech-options-wispr-flow.md)

## Source of Truth

BetterTouchTool is installed at:

```text
/Applications/BetterTouchTool.app
```

Current BTT database:

```text
~/Library/Application Support/BetterTouchTool/btt_data_store.version_6_609_build_2026062603
```

Preferences plist:

```text
~/Library/Preferences/com.hegenberg.BetterTouchTool.plist
```

BTT's bundled trigger reference is useful when checking gesture IDs:

```text
/Applications/BetterTouchTool.app/Contents/Resources/trigger-definitions.mdx
```

BTT is configured as a login item so the gestures are available after restart.

## Current Trackpad Gestures

Current global trackpad gestures:

| Gesture | BTT trigger type | BTT action / shortcut |
| --- | --- | --- |
| 3-finger swipe right | `101` | `46` / Application Switcher |
| 3-finger swipe left | `100` | `55,51` / Cmd+Delete, delete to beginning of line |
| 3-finger tap | `104` | `61` / right Option, triggers Wispr hands-free |
| 4-finger tap | `110` | `36` / Return, sends Enter |

Current BTT UUIDs:

| Gesture | UUID |
| --- | --- |
| 3-finger swipe right | `D31D7DAB-04F5-4A03-8EB7-469C8B9F9B01` |
| 3-finger swipe left | `94E64D33-7972-4F71-A04A-09A4D75C4B15` |
| 3-finger tap | `CA4B9E78-76FB-4764-9301-A9937EE84D12` |
| 4-finger tap | `A693727F-81DC-4CD4-B643-21A0D68705F8` |
| 3-finger click | `44022E95-1E33-48C6-BAC4-D7838FFBD70A` |

Disabled / reserved BTT triggers:

| Gesture | BTT trigger type | Previous shortcut | UUID | Status |
| --- | --- | --- | --- | --- |
| 3-finger click | `112` | `36` / Return | `44022E95-1E33-48C6-BAC4-D7838FFBD70A` | Disabled; reserved for future use |

## App-Specific Trackpad Gestures

Current app-specific trackpad gestures:

| App | Bundle ID | Gesture | BTT trigger type | BTT action / shortcut | UUID |
| --- | --- | --- | --- | --- | --- |
| Codex | `com.openai.codex` | 2-finger swipe right | `160` | `137` / terminal command, lift to select | `B3FE5023-2A6D-4A7B-908D-2DB2815F700D` |

Current BTT automation triggers:

| Trigger | BTT trigger type | Action | UUID |
| --- | --- | --- | --- |
| Every 30 seconds | `678` | `137` / `~/.local/bin/ducky-f8-aerospace-listener` | `24054644-BB63-47F8-B8A4-4ABB22E7E974` |

This is stored under a Codex app row in BTT, not as a global gesture. BTT's
loaded scripting API should report `BTTBelongsToApp` as `Codex`.

The Codex trigger runs this helper:

```text
~/.local/bin/btt-codex-chat-switcher
```

The helper calls this compiled Swift event sender:

```text
~/.local/bin/btt-codex-key-event
```

The Swift helper sends explicit keyboard events: Control flagsChanged down,
Tab down/up with the Control flag set, a left click at the current pointer
position, and Control flagsChanged up. The helper sends one `Ctrl+Tab` to open
Codex's chat switcher, keeps Control held, then BTT's no-touch hook runs the
selection helper when the last trackpad finger lifts. It intentionally does not
repeat while sliding, and it does not define a left-swipe trigger.

The no-touch hook runs this reusable named trigger:

| Named trigger | BTT trigger type | Action | UUID |
| --- | --- | --- | --- |
| `codex_chat_switcher_select_hovered_chat` | `643` | `137` / `~/.local/bin/btt-codex-chat-switcher select` | `8BD35B3E-20C0-4062-9B93-6B2D1A2B762C` |

The shell helper currently uses a `12.0` second failsafe release window in case
the no-touch hook does not fire. On lift-to-select, it waits `0.001` seconds
before clicking the current pointer position. The click itself holds mouse-down
for `0.001` seconds before mouse-up.

When opening the switcher, the shell helper waits `0.001` seconds after Control
down before sending Tab.

Tracked source for the event sender:

```text
~/.dotfiles/mac/.local/bin/btt-codex-key-event.swift
```

Tracked source for the shell helper:

```text
~/.dotfiles/mac/.local/bin/btt-codex-chat-switcher
```

Compile/update the live helper with:

```sh
swiftc ~/.dotfiles/mac/.local/bin/btt-codex-key-event.swift -o ~/.local/bin/btt-codex-key-event
install -m 755 ~/.dotfiles/mac/.local/bin/btt-codex-chat-switcher ~/.local/bin/btt-codex-chat-switcher
```

The BTT trigger uses action `137` (`Execute Terminal Command`, async), rather
than action `206` (`Shell Script Task`), because `206` did not execute when
tested through BTT's scripting interface in this setup. Earlier attempts using
BTT's native `Control Down` action and `System Events` did not create a durable
held Control state.

The trigger has `Retrigger after sliding` disabled in the database
(`ZALLOWRETRIGGER=0`) and the live repeat delay/rate fields are `0.0`.

The 2-finger swipe sensitivity is explicitly tuned lower than the BTT default
to match the 3-finger app switcher swipe:

```sh
defaults read com.hegenberg.BetterTouchTool tpTwoFingerSwipeSensitivity
```

Current value: `0.05`.

## App Switcher Mode

BTT's special app switcher mode is enabled:

```sh
defaults read com.hegenberg.BetterTouchTool useSpecialAppSwitcher
defaults read com.hegenberg.BetterTouchTool specialAppSwitcher
defaults read com.hegenberg.BetterTouchTool specialAppSwitcherInfoShown
```

All should return `1`.

BTT's action editor shows `Use Gesture Mode` enabled for the app switcher
action. Its own description says the switcher advances with more taps or with
scroll while fingers are still touching. In practice this means:

- Three-finger swipe opens the app switcher.
- Two-finger scrolling can move through the app switcher.
- Continuing to glide with the same three fingers does not appear to be a
  supported built-in BTT behavior.

The 3-finger swipe sensitivity is explicitly tuned lower than the BTT default
so the app switcher activates with a shorter gesture:

```sh
defaults read com.hegenberg.BetterTouchTool BTTTpThreeFingerSwipeSensitivity
```

Current value: `0.05`.

Important: do not configure the app switcher gesture as a plain keyboard
shortcut like `Cmd+Tab` or `Shift+Cmd+Tab`. That only opens the macOS app
switcher and can leave it waiting for release/confirmation. The working setup
uses BTT's native Application Switcher action so the gesture behaves more like
the MX Master gesture button.

macOS's built-in 3-finger horizontal swipe is disabled in the matching
trackpad preference domains so it does not fight BTT. Four-finger horizontal
swipe remains enabled for Spaces/full-screen navigation.

## Magic Mouse Notes

As of 2026-07-01, no Magic Mouse gestures are configured. The Magic Mouse
section in BTT is clean.

BTT does support a dedicated Magic Mouse trigger class:

```text
BTTTriggerTypeMagicMouse
```

Useful Magic Mouse triggers observed in BTT's bundled trigger definitions:

| Gesture | Trigger type |
| --- | --- |
| 2 Finger Swipe Left | `5` |
| 2 Finger Swipe Right | `6` |
| 2 Finger Tap | `4` |
| 2 Finger Double-Tap | `62` |
| 3 Finger Tap | `9` |
| 3 Finger Double-Tap | `63` |
| 3 Finger Click | `21` |
| 3 Finger Swipe Left | `10` |
| 3 Finger Swipe Right | `11` |
| TipTap Left (1 Finger Fix) | `16` |
| TipTap Right (1 Finger Fix) | `17` |
| TipTap Left (2 Fingers Fix) | `30` |
| TipTap Middle (2 Fingers Fix) | `37` |
| TipTap Right (2 Fingers Fix) | `31` |

Possible future mappings:

| Goal | Candidate Magic Mouse gesture | Candidate action |
| --- | --- | --- |
| App switcher | 2-finger swipe right | BTT native Application Switcher |
| App switcher | TipTap gesture | BTT native Application Switcher |
| Wispr hands-free | 3-finger tap | `61` / right Option |
| Enter/send | 2-finger double-tap or 3-finger click | `36` / Return |

TipTap means keeping one or more fingers resting on the Magic Mouse surface and
tapping with another finger. BTT specifically notes that its special
Application Switcher mode is well suited for TipTap gestures because the
switcher can stay open while fingers remain touching the mouse or touchpad.

Caveat: BTT warns that configuring Magic Mouse two-finger swipes can block
normal Magic Mouse scrolling as soon as two fingers are touching the mouse
surface. Test Magic Mouse swipes carefully before keeping them.

## Backups

Known-good backup from before testing the `useSpecialAppSwitcher` flag:

```text
~/.dotfiles/backups/bettertouchtool/20260630-230409-current-working-3finger-appswitcher
```

Backup from before repurposing 3-finger swipe left to `Cmd+Delete`:

```text
~/.dotfiles/backups/bettertouchtool/20260630-233931-before-left-swipe-cmd-delete
```

Backup from before adding 4-finger tap as a second Enter gesture:

```text
~/.dotfiles/backups/bettertouchtool/20260630-234325-before-4finger-tap-enter
```

Backup from before disabling 3-finger click Enter:

```text
~/.dotfiles/backups/bettertouchtool/20260630-235139-before-disabling-3finger-click-enter
```

Backup from before adding Codex-only 2-finger swipe right:

```text
~/.dotfiles/backups/bettertouchtool/20260701-203104-before-codex-2finger-swipe-right
```

Backup from before tuning 2-finger swipe sensitivity to `0.05`:

```text
~/.dotfiles/backups/bettertouchtool/20260701-203619-before-twofinger-swipe-sensitivity-005
```

Backup from before changing the Codex gesture from one-shot `Ctrl+Tab` to the
timed Control hold helper:

```text
~/.dotfiles/backups/bettertouchtool/20260701-204030-before-codex-chat-switcher-hold
```

Backup from before enabling retrigger-after-sliding on the Codex gesture:

```text
~/.dotfiles/backups/bettertouchtool/20260701-210334-before-codex-retrigger-after-sliding
```

Backup from before adding the no-touch release named trigger and distance
monitor helper:

```text
~/.dotfiles/backups/bettertouchtool/20260701-210543-before-codex-notouch-release
```

Backup from before adding Codex-only 2-finger swipe left:

```text
~/.dotfiles/backups/bettertouchtool/20260701-211730-before-codex-2finger-swipe-left
```

Backup from before simplifying the Codex gesture back to open-only behavior:

```text
~/.dotfiles/backups/bettertouchtool/20260701-212310-before-simplify-codex-chat-switcher-open-only
```

Backup from before adding lift-to-select for the Codex chat switcher:

```text
~/.dotfiles/backups/bettertouchtool/20260701-213123-before-codex-lift-to-select
```

## Troubleshooting

If the BTT gestures stop working, first check:

- BetterTouchTool is running.
- BetterTouchTool is enabled in System Settings -> Privacy & Security ->
  Accessibility.
- If requested by macOS, BetterTouchTool is also enabled under Input
  Monitoring.
- The special app switcher defaults still return `1`.
- The current trackpad trigger rows still have `ZENABLEDNEW=1` and
  `ZISENABLED=1`.

## Audit Commands

### Current Trackpad Trigger Rows

```bash
sqlite3 "$HOME/Library/Application Support/BetterTouchTool/btt_data_store.version_6_609_build_2026062603" \
  "select Z_PK, ZACTION, ZGESTURETYPE, ZISTOUCHPAD, ZSHORTCUT, ZUNIQUEIDENTIFIER, ZENABLEDNEW, ZISENABLED, ZNOTES, ZDESC from ZBTTBASEENTITY where ZISTOUCHPAD=1 order by ZGESTURETYPE, Z_PK;"
```

### Codex App-Specific Trigger

```bash
osascript <<'APPLESCRIPT'
tell application "BetterTouchTool"
  get_triggers trigger_app_bundle_identifier "com.openai.codex"
end tell
APPLESCRIPT
```

```bash
sqlite3 "$HOME/Library/Application Support/BetterTouchTool/btt_data_store.version_6_609_build_2026062603" \
  "select apps.ZBUNDLEIDENTIFIER, apps.ZNAME, gestures.ZGESTURETYPE, gestures.ZACTION, gestures.ZLAUNCHPATH, gestures.ZALLOWRETRIGGER, gestures.ZREPEATDELAY, gestures.ZREPEATRATE, gestures.ZUNIQUEIDENTIFIER, gestures.ZENABLEDNEW, gestures.ZISENABLED, gestures.ZDESC, gestures.ZNOTES from Z_2APPS_GESTURES rel join ZBTTBASEENTITY apps on apps.Z_PK=rel.Z_2GESTURES join ZBTTBASEENTITY gestures on gestures.Z_PK=rel.Z_9APPS_GESTURES where apps.ZBUNDLEIDENTIFIER='com.openai.codex';"
```


### Special App Switcher Defaults

```bash
defaults read com.hegenberg.BetterTouchTool useSpecialAppSwitcher
defaults read com.hegenberg.BetterTouchTool specialAppSwitcher
defaults read com.hegenberg.BetterTouchTool specialAppSwitcherInfoShown
defaults read com.hegenberg.BetterTouchTool BTTTpThreeFingerSwipeSensitivity
defaults read com.hegenberg.BetterTouchTool tpTwoFingerSwipeSensitivity
```
