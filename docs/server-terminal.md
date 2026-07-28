# Server terminal package

`server/` is the dedicated GNU Stow package for the Ubuntu server terminal. It
is independent from `mac/` and does not reactivate `archive/linux/`.

It deploys zsh, Powerlevel10k, Neovim, Ranger, bat, btop, tmux, and the tmux
picker helpers. It intentionally excludes macOS application paths, local
credentials, local automation, Ghostty settings, and shell history.

Tmux plugins are installed in `~/.local/share/tmux/plugins`, outside the Stow
package, so plugin updates do not dirty the dotfiles checkout.

## Provisioning

On the server, place this repository at `~/.dotfiles`, then run:

```bash
cd ~/.dotfiles
scripts/provision-server-terminal.sh
```

The script installs Ubuntu packages, Neovim `0.12.4` from the official upstream
release, Oh My Zsh, Powerlevel10k, fzf-tab, TPM, and the configured tmux
plugins. It dry-runs Stow before deployment. It does not change the account's
login shell.

After the script succeeds, test in a separate SSH command before changing the
default shell:

```bash
ssh myserver 'zsh -lic "command -v nvim ranger bat btop tmux"'
ssh myserver 'sudo chsh -s /usr/bin/zsh vp'
ssh myserver 'printf "%s\\n" "$SHELL"; zsh -lic "echo zsh-ready"'
```

Tmux is optional. SSH opens zsh normally, and `tmux` starts the familiar
Petronas configuration. Copy mode uses tmux's OSC 52 support so copied text is
sent back to Ghostty through SSH.

Ubuntu packages name the bat and fd commands `batcat` and `fdfind`. The server
package supplies `~/.local/bin/bat` and `~/.local/bin/fd` compatibility
wrappers.
