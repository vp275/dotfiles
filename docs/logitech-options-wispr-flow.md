# Logitech Options+ and Wispr Flow Setup

Last audited: 2026-07-04

## Goal

Keep the MX Master 3S wheel/back buttons predictable across Codex, AI apps,
terminals, browsers, and Wispr Flow.

The important split:

- Chat/terminal-like apps, including Codex: wheel click sends `Enter`.
- Browsers: wheel click stays a real middle click.
- Wispr Flow hands-free should not steal browser back/middle-click behavior.

## Source of Truth

Logitech Options+ stores its profile state in:

```text
~/Library/Application Support/LogiOptionsPlus/settings.db
```

The real settings are stored as one JSON blob in SQLite table `data`, column
`file`.

Wispr Flow stores shortcuts in:

```text
~/Library/Application Support/Wispr Flow/config.json
```

The authoritative Wispr shortcuts are under:

```text
prefs.user.shortcuts
```

`prefs.cache.splitKeybinds` is a derived/cache view and can be rebuilt by
Wispr.

## MX Master 3S Slot IDs

Observed device prefix:

```text
mx-master-3s-2b034
```

Useful slots:

| Slot | Physical control | Notes |
| --- | --- | --- |
| `mx-master-3s-2b034_c82` | Wheel click / middle button | `Enter` in terminal-like apps and Codex, `MB3` in browsers. |
| `mx-master-3s-2b034_c83` | Back button | Native Back in browsers/default; `Ctrl+Tab` in Codex. |
| `mx-master-3s-2b034_c86` | Forward button | Native Forward in browsers/default; `Cmd+K` in Codex. |
| `mx-master-3s-2b034_c195` | Aux/thumb-style button | Right Option in Desktop/default and Codex for Wispr hands-free. Previously used as raw aux for Wispr. |
| `mx-master-3s-2b034_c196` | Gesture/top button | App navigation gesture card. |

## Current Logitech Profile Benchmark

### Full Profile Snapshot

Generated from the live Logitech Options+ database on 2026-07-04.

| App/profile | Bundle id | Thumb button `c195` | Wheel click `c82` | Back `c83` | Forward `c86` |
| --- | --- | --- | --- | --- | --- |
| Desktop/default | global fallback | Right Option / `Opt ->` | Real middle click: `MB3` | Native Back | Native Forward |
| Codex | `com.openai.codex` | Right Option / `Opt ->` | `Enter` | `Ctrl+Tab` | `Cmd+K` |
| Claude | `com.anthropic.claudefordesktop` | Empty shortcut / no action | `Enter` | Native Back | Native Forward |
| Warp | `dev.warp.Warp-Stable` | Empty shortcut / no action | `Enter` | Native Back | Native Forward |
| Ghostty | `com.mitchellh.ghostty` | Empty shortcut / no action | `Enter` | Native Back | Native Forward |
| Safari | `com.apple.Safari` | Empty shortcut / no action | Real middle click: `MB3` | Native Back | Native Forward |
| Google Chrome | `com.google.Chrome` | Empty shortcut / no action | Real middle click: `MB3` | Native Back | Native Forward |
| Brave Browser | `com.brave.Browser` | Empty shortcut / no action | Real middle click: `MB3` | Native Back | Native Forward |
| Firefox | `org.mozilla.firefox` | Empty shortcut / no action | Real middle click: `MB3` | Native Back | Native Forward |
| Helium | `net.imput.helium` | `Cmd+\`` | Real middle click: `MB3` | Native Back | Native Forward |

Important inheritance detail: Desktop/default applies only to apps without a
custom Logitech profile. Existing custom profiles with an explicit empty thumb
assignment do not inherit the Desktop/default right Option thumb behavior.

### Wheel Click

| App/profile | Bundle id | Wheel click |
| --- | --- | --- |
| Codex | `com.openai.codex` | `Enter` key |
| Claude | `com.anthropic.claudefordesktop` | `Enter` key |
| Warp | `dev.warp.Warp-Stable` | `Enter` key |
| Ghostty | `com.mitchellh.ghostty` | `Enter` key |
| Desktop/default | global fallback | Real middle click: `MB3` |
| Safari | `com.apple.Safari` | Real middle click: `MB3` |
| Google Chrome | `com.google.Chrome` | Real middle click: `MB3` |
| Brave Browser | `com.brave.Browser` | Real middle click: `MB3` |
| Firefox | `org.mozilla.firefox` | Real middle click: `MB3` |
| Helium | `net.imput.helium` | Real middle click: `MB3` |

Use `Enter` for apps where wheel click means "send/submit current composer"
and a real middle click would steal focus.

Use `MB3` for browsers because middle click opens links in background tabs and
does browser-native tab behavior.

### Back / Forward

Known-good browser/default shape:

| Slot | Expected action |
| --- | --- |
| `c83` | `OSX_GESTURE_BACK` |
| `c86` | `OSX_GESTURE_FORWARD` |

Profiles currently matching that browser/default shape:

- Desktop/default
- Safari
- Google Chrome
- Brave Browser
- Firefox
- Helium
- Claude
- Warp
- Ghostty

Desktop/default also sets the thumb button (`c195`) to right Option
(`code: 230`, displayed by Logi as `Opt ->`) so Wispr hands-free works in
apps that do not have their own customized Logi profile.

Codex currently has a custom four-button layout:

| Slot | Current Codex assignment |
| --- | --- |
| `c195` | Right Option key (`code: 230`, displayed by Logi as `Opt ->`); Wispr maps right Option (`61`) to hands-free |
| `c82` | `Enter` / `Return` |
| `c83` | `Ctrl+Tab` (`code: 43`, modifiers `[224]`) |
| `c86` | `Cmd+K` (`code: 14`, modifiers `[227]`) |

Treat Codex side buttons separately from browser side buttons.

## Current Wispr Flow Shortcut Benchmark

Wispr shortcuts currently relevant to this setup:

| Shortcut code | Wispr action |
| --- | --- |
| `61` | `popo` / hands-free; right Option key |
| `4099` | `popo` / hands-free; Mouse 4 side button, legacy fallback while testing back button behavior |
| `4100` | `popo` / hands-free; Mouse 5 side button, legacy fallback while testing back button behavior |
| `63` | `ptt` |

Important absence:

- `4098 => enter_rebind` is intentionally removed.
- `65535 => popo` is intentionally removed after moving hands-free off the
  aux/thumb button.
- Physical middle click should not be globally bound in Wispr.

Why: when Wispr globally owns physical middle click, browser middle-click stops
being a normal browser middle-click.

## Related BetterTouchTool Docs

BetterTouchTool trackpad gestures and future Magic Mouse experiments are
documented separately:

[BetterTouchTool gesture setup](btt/README.md)

## Lessons Learned

### Do Not Use Logitech-Generated Chords For Wispr Hotkeys

We tried mapping wheel click in Codex to a weird keyboard chord and then making
Wispr listen for that chord. It did not reliably trigger Wispr.

Better pattern:

- If the target app needs "send", set Logi wheel click directly to `Enter`.
- If the target app needs browser behavior, keep Logi wheel click as `MB3`.
- If Codex needs Wispr hands-free from a side button, set Logi to emit right
  Option directly. Wispr already treats right Option (`61`) as `popo`.

### Codex Focus Problem

Historical note: this was the earlier layout before the later Codex button
swaps. The current Codex profile now uses wheel click (`c82`) for `Enter`,
thumb (`c195`) for Wispr hands-free, back (`c83`) for `Ctrl+Tab`, and
forward (`c86`) for `Cmd+K`.

Original bug:

- Wispr `Middle Click -> Press Enter` only worked when the cursor was inside
  the Codex composer.
- Clicking elsewhere in Codex moved focus before Wispr sent Enter.

Earlier fix:

- In the Codex Logi profile, set wheel click (`c82`) to a plain `Enter`
  keystroke instead of a physical middle click.
- This means no mouse click reaches Codex, so focus is not stolen.

### Browser Middle-Click Problem

Original bug:

- Helium/browser middle-click did not act like browser middle-click.

Cause:

- Wispr had global physical middle click (`4098`) bound to `enter_rebind`.

Fix:

- Remove Wispr `4098 => enter_rebind`.
- Keep browser Logi profiles as real `MB3`.

### YouTube PWA / Brave App Gotcha

YouTube installed from Brave can run as a separate app shim, for example:

```text
/Users/vp/Applications/Brave Browser Apps.localized/YouTube.app
com.brave.Browser.app.agimnkijcaahngcdmfeangaknmldooml
```

That may not use the normal Brave Browser profile. It can fall back to the
Desktop/default profile.

If YouTube behaves differently from Brave:

1. Check whether it is running as a Brave PWA/app shim.
2. Check the Desktop/default Logi profile.
3. If needed, create a dedicated Logi profile for the YouTube app bundle.

In this setup, the default profile should keep:

- Wheel click: `MB3`
- Back: `OSX_GESTURE_BACK`
- Forward: `OSX_GESTURE_FORWARD`

## Audit Commands

### Logitech Profile Summary

```bash
python3 - <<'PY'
import json, os, sqlite3

db = os.path.expanduser('~/Library/Application Support/LogiOptionsPlus/settings.db')
root = json.loads(sqlite3.connect(db).execute('select file from data limit 1').fetchone()[0])
apps = {a.get('applicationId'): a for a in root.get('applications', {}).get('applications', [])}

for pid in root.get('profile_keys', []):
    prof = root[pid]
    app = apps.get(prof.get('applicationId'), {})
    name = app.get('name') or prof.get('applicationId')
    bundle = app.get('bundleId') or ''
    print(f'\n{name}\t{bundle}\t{pid}')

    for slot in [
        'mx-master-3s-2b034_c82',
        'mx-master-3s-2b034_c83',
        'mx-master-3s-2b034_c86',
        'mx-master-3s-2b034_c195',
        'mx-master-3s-2b034_c196',
    ]:
        assignment = next((a for a in prof.get('assignments', []) if a.get('slotId') == slot), None)
        if not assignment:
            continue
        card = assignment.get('card', {})
        print(slot, card.get('id'), card.get('macro', {}))
PY
```

### Wispr Shortcut Summary

```bash
python3 - <<'PY'
import json, os

path = os.path.expanduser('~/Library/Application Support/Wispr Flow/config.json')
with open(path) as f:
    data = json.load(f)

print('prefs.user.shortcuts')
for key, value in sorted(data.get('prefs', {}).get('user', {}).get('shortcuts', {}).items()):
    print(key, '=>', value)

print('\nprefs.cache.splitKeybinds')
for binding in data.get('prefs', {}).get('cache', {}).get('splitKeybinds') or []:
    print(binding)
PY
```

## Safe Editing Notes

Before editing Logitech settings manually:

1. Back up the database.
2. Quit Logi Options+ and stop its launch agent.
3. Patch the JSON blob in SQLite.
4. Run SQLite integrity check.
5. Restart Logi Options+.
6. Re-audit after restart because Logi can overwrite direct edits from memory.

Example backup path used during debugging:

```text
work/logi-backups/
work/wispr-backups/
```

When changing Wispr shortcuts:

- Patch `prefs.user.shortcuts`.
- Patch `prefs.cache.splitKeybinds` only as a cache convenience.
- Restart Wispr and re-check because cache-only edits can be discarded.
