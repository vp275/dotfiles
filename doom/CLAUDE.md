# CLAUDE.md

Doom Emacs configuration using literate config (org-babel-tangle). Evil mode with corfu/vertico completion.

## Commands

```bash
~/.config/emacs/bin/doom sync    # After changing init.el or packages.el
~/.config/emacs/bin/doom doctor  # Diagnose issues
```

## File Structure

- `init.el` - Module declarations only. Enable/disable Doom modules here.
- `packages.el` - Additional packages (run `doom sync` after changes)
- `emacs.org` - **Primary config file**. Literate org file that tangles to `config.el`
- `config.el` - Auto-generated from emacs.org. Do not edit directly.

### Editing Config

Edit `emacs.org`, not `config.el`. The file auto-tangles on save via org-auto-tangle. Manual tangle: `SPC t t`

## Key Modules (init.el)

- Completion: `corfu +orderless`, `vertico`
- Editor: `evil +everywhere`, `snippets`, `fold`
- Org: `org +roam2`
- Term: `vterm`
- Tools: `magit`, `eval +overlay`, `lookup`
- UI: `workspaces`, `zen`, `doom-dashboard`

## GTD/Org-Mode Setup

Location: `~/Dropbox/admin/gtd/`
- `inbox.org` - Capture inbox
- `gtd.org` - Main GTD file

Todo keywords: `TODO` -> `NEXT` -> `PROJ` | `DONE` / `DROP` (also `BOOK`)

Capture templates:
- `i` - Inbox (appends to inbox.org)
- `t` - Todo (to inbox.org)

Org-roam directory: `~/Dropbox/admin/org/org-roam/`

## Keybindings

| Binding | Action |
|---------|--------|
| `SPC f x` | Open emacs.org (config) |
| `SPC d i` | Open inbox.org |
| `SPC d g` | Open gtd.org |
| `SPC t t` | org-babel-tangle |
| `C-c C-'` | claude-code-ide menu |

## AI/LLM Integration

**gptel** (Gemini backend):
- Reads API key from `GEMINI_API_KEY` env var
- Model: `gemini-2.5-pro-preview-05-06`
- Streaming enabled

**claude-code-ide**: Bound to `C-c C-'`

## Appearance

- Theme: `doom-one`
- Font: JetBrainsMono Nerd Font Mono (18pt, Light)
- Transparency: 98%

## Additional Packages

org-auto-tangle, org-journal, org-roam-ui, xmind-org, org-noter, gptel, claude-code-ide
