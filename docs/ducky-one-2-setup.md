# Ducky One 2 - macOS Setup

## Problem

Ducky One 2 doesn't have a Mac/Windows switch like Keychron. By default:
- Alt key → Option (⌥)
- Windows key → Command (⌘)

This is reversed from Mac layout where Command should be next to the spacebar.

## Solution

Added device-specific modifier swap in Karabiner-Elements (`mac/.config/karabiner/karabiner.json`):

- Left/Right Option ↔ Left/Right Command (for Ducky only, vendor 1241, product 661)

Other keyboards (including MacBook built-in) are unaffected.

## Other Settings

- Caps Lock → Escape (global, applies to all keyboards)

## Function Row

The Ducky hardware Fn key is handled by the keyboard firmware. macOS does not
see it as the MacBook Fn/Globe key, and `Fn+F1-F12` is not the right path for
Mac media keys on this board.

`~/.local/bin/ducky-one-2-media-keys` maps the media keys below with `hidutil`,
targeted to the Ducky vendor/product ID only. A LaunchAgent at
`~/Library/LaunchAgents/com.vp.ducky-one2-media-keys.plist` reapplies the
mapping on login and every 30 seconds so it survives keyboard replugging.

- F4 → `~/.local/bin/ducky-f8-aerospace-listener`, which calls
  `~/.local/bin/protonvpn-app-toggle` to click Proton VPN's native Quick
  Connect/Disconnect button. The listener ignores key-repeat so a held F4 does
  not bounce the VPN state. The helper opens Proton VPN first, so it still works
  when the main Proton window has been closed.
- MacBook built-in F4 → `~/.local/bin/macbook-f4-proton-key` remaps Apple's
  Spotlight/Search HID usage to normal F4, so the same listener handles it.
- F8 → the same listener calls `~/.local/bin/aerospace-toggle-enabled` to
  kill/relaunch the AeroSpace app.
  BetterTouchTool starts the listener periodically because BTT has the needed
  keyboard event permissions.
- F10 → Mute
- F11 → Volume Down
- F12 → Volume Up
