# Repository Guidelines

## Project Structure & Module Organization
This repo is a tmux configuration bundle.
- `tmux.conf` is the single source of truth for tmux settings and keybindings.
- `plugins/` contains TPM (`plugins/tpm`) and theme/plugins (for example `plugins/catppuccin`).
- `README.md` documents keybinding intent and Ghostty interoperability notes.

## Build, Test, and Development Commands
There is no build step; changes take effect after reloading tmux.
- `tmux source-file ~/.config/tmux/tmux.conf` reloads the config (same as the `Cmd+r` binding).
- `~/.config/tmux/plugins/tpm/bin/install_plugins` installs plugins via TPM.
- `~/.config/tmux/plugins/tpm/bin/update_plugins` updates plugins via TPM.
- `ghostty +validate-config` validates Ghostty config after keybinding edits.

## Coding Style & Naming Conventions
- Keep tmux syntax consistent: `set -g` for globals, `setw -g` for window options, `bind -n` for unprefixed keys.
- Key names use tmux conventions (`C-` for Control, `M-` for Meta, `M-~` for Shift+Meta).
- Use short section comments with `#` to group related settings.
- Plugin names should follow TPM’s `owner/name` format (for example `tmux-plugins/tpm`).

## Testing Guidelines
There is no automated test suite. Validate changes manually:
- Reload tmux and confirm bindings work (splits, new window, window navigation).
- Check copy-mode and clipboard behavior; `xclip` is required for X11 copy piping.
- If the status bar shows command errors, verify `~/.local/bin/sp500-ticker` and `~/.local/bin/vix-ticker`, or adjust `status-right`.

## Commit & Pull Request Guidelines
This directory is not currently a git repository, so there is no commit history to follow. If you add version control, keep commit messages short and imperative (for example, `tmux: tweak status bar colors`). For pull requests, include a brief description of the behavior change, list any keybinding updates, and attach a terminal screenshot if UI elements or colors changed.

## Configuration Tips
- Ghostty must forward Command as Meta; keep `~/.config/ghostty/config` and `~/.config/Ghostty/config` in sync when changing bindings.
- Prefer minimal changes to preserve muscle memory; document any nonstandard mappings in `README.md`.
