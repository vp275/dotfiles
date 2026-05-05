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
- F1-F12 are primary keys; media controls via Fn+F1-F12
