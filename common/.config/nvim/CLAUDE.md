# CLAUDE.md

Neovim configuration using lazy.nvim plugin manager with carbonfox theme.

## Plugin Manager

Uses [lazy.nvim](https://github.com/folke/lazy.nvim) with auto-bootstrap. Plugins are loaded from `lua/plugins/*.lua`.

**Adding plugins**: Create a new `.lua` file in `lua/plugins/` returning a table:
```lua
return {
  {
    "author/plugin-name",
    config = function()
      -- setup code
    end,
  },
}
```

**Commands**: `:Lazy` opens the plugin manager UI (sync, update, clean).

## Current Plugins

| File | Plugin | Purpose |
|------|--------|---------|
| `colorscheme.lua` | `EdenEast/nightfox.nvim` | Provides carbonfox colorscheme |
| `lualine.lua` | `nvim-lualine/lualine.nvim` | Status line with carbonfox theme |
| `render-markdown.lua` | `MeanderingProgrammer/render-markdown.nvim` | Renders markdown with formatting |
| `render-markdown.lua` | `nvim-treesitter/nvim-treesitter` | Syntax parsing (markdown installed) |
| `telescope.lua` | `nvim-telescope/telescope.nvim` | Fuzzy finder for files, grep, buffers |
| `telescope.lua` | `telescope-fzf-native.nvim` | Native fzf for fast fuzzy matching |
| `neo-tree.lua` | `nvim-neo-tree/neo-tree.nvim` | File tree sidebar |
| `which-key.lua` | `folke/which-key.nvim` | Keybinding hints popup |
| `comment.lua` | `numToStr/Comment.nvim` | Smart code commenting |
| `zen-mode.lua` | `folke/zen-mode.nvim` | Distraction-free writing mode |
| `zen-mode.lua` | `folke/twilight.nvim` | Dims inactive code (auto-enabled with zen) |
| `claude-tmux.lua` | (keymaps only) | Opens Claude/GLM in tmux split |

Dependencies: `nvim-lua/plenary.nvim`, `nvim-tree/nvim-web-devicons`, `MunifTanjim/nui.nvim`

## Keybindings

Leader key is `Space`.

### Telescope (fuzzy finder)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text across project) |
| `<leader>fb` | List open buffers |
| `<leader>fr` | Recent files |
| `<leader>/` | Search in current buffer |

### Neo-tree (file explorer)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file tree |
| `<leader>o` | Focus file tree |
| `l` | Open file/directory (in tree) |
| `h` | Close node/go up (in tree) |
| `a` | Add file/folder |
| `d` | Delete |
| `r` | Rename |
| `?` | Show all keybinds |

### Comment.nvim

| Key | Action |
|-----|--------|
| `gcc` | Toggle comment on line |
| `gc` + motion | Comment with motion (e.g., `gcap` for paragraph) |
| `gc` in visual | Comment selection |

### Which-key

| Key | Action |
|-----|--------|
| `<leader>?` | Show buffer keymaps |
| (auto) | Shows hints when you pause mid-keypress |

### Zen Mode

| Key | Action |
|-----|--------|
| `<leader>z` | Toggle zen mode (centers buffer, hides UI, dims inactive code) |

### Claude/GLM (tmux integration)

| Key | Action |
|-----|--------|
| `<leader>cc` | Open Claude in right tmux pane with current file |
| `<leader>cC` | Open Claude in right tmux pane (no file) |
| `<leader>cg` | Open GLM in right tmux pane with current file |
| `<leader>cr` | Open Claude resume picker in right tmux pane |

## Basic Settings (init.lua)

- Line numbers: absolute + relative (`number`, `relativenumber`)
- System clipboard integration (`clipboard = "unnamed,unnamedplus"`)
- Text width: 80 columns
- Show command and ruler enabled
- Auto-reload files changed externally (`autoread` + checktime autocmd)

## Theme

Carbonfox from nightfox.nvim - dark theme consistent with other tools in this dotfiles repo.
