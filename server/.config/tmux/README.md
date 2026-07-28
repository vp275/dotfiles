# Server tmux

This is the server-safe counterpart to the macOS tmux configuration. It keeps
the Petronas status bar, Ctrl+a prefix, vi mode, picker bindings, and TPM
plugins. Tmux does not start automatically.

The server relies on tmux's OSC 52 clipboard support instead of `pbcopy` or an
X11 clipboard helper. Ghostty receives copied text through the SSH connection.

After a fresh deployment, install the plugins with:

```bash
~/.local/share/tmux/plugins/tpm/bin/install_plugins
```
