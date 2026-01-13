# Repository Guidelines

## Project Structure & Module Organization

This directory is a Ghostty configuration repo. The only source of truth is the `config` file in the repo root (`/Users/vp/.config/ghostty/config`). There are no separate modules, assets, or test folders. Keep related settings grouped (theme/appearance, clipboard, keybinds, startup command) to make diffs readable.

## Build, Test, and Development Commands

There is no build system. Use Ghostty's CLI helpers to validate and inspect config changes:

- `ghostty +show-config`: show the effective config (changes vs defaults).
- `ghostty +validate-config --config-file config`: validate this repo's config file.
- `ghostty +edit-config`: open the default config path in your editor.

## Coding Style & Naming Conventions

Follow Ghostty's config syntax: `key = value`, one setting per line, comments with `#`. Keep alignment minimal and avoid tabs. Use explicit names for keybinds (e.g., `keybind = cmd+shift+t=...`) and prefer consistent casing/spacing with existing entries. Example:

```
background-opacity = 0.90
font-size = 21
```

## Testing Guidelines

No automated tests exist. Use `ghostty +validate-config --config-file config` after edits and manually reload Ghostty to confirm behavior.

## Commit & Pull Request Guidelines

This directory is not a Git repo, so no history-based conventions exist. If you initialize one, use short, descriptive commit messages (e.g., `Update keybinds for tmux`) and include the reason for the change. For PRs, include a brief summary plus any Ghostty behavior changes and validation steps.

## Configuration Tips

Keep clipboard and keybind changes together for review. When adding commands (like tmux autostart), document the intent near the setting so future edits stay consistent.
