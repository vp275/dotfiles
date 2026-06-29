# CLAUDE.md

Neovim configuration using lazy.nvim with a custom Mercedes Petronas
colorscheme. Nightfox/carbonfox remains installed as a fallback.

## Plugin Manager

Uses [lazy.nvim](https://github.com/folke/lazy.nvim) with auto-bootstrap.
Plugins are loaded from `lua/plugins/*.lua`.

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

**Commands**: `:Lazy` opens the plugin manager UI for sync, update, and clean.

## Current Plugins

| File | Plugin | Purpose |
|------|--------|---------|
| `colorscheme.lua` | `EdenEast/nightfox.nvim` | Keeps carbonfox available as fallback |
| `lualine.lua` | `nvim-lualine/lualine.nvim` | Status line |
| `render-markdown.lua` | `MeanderingProgrammer/render-markdown.nvim` | Renders markdown with formatting |
| `render-markdown.lua` | `nvim-treesitter/nvim-treesitter` | Syntax parsing |
| `telescope.lua` | `nvim-telescope/telescope.nvim` | Fuzzy finder |
| `telescope.lua` | `telescope-fzf-native.nvim` | Native fzf matching |
| `neo-tree.lua` | `nvim-neo-tree/neo-tree.nvim` | File tree sidebar |
| `which-key.lua` | `folke/which-key.nvim` | Keybinding hints popup |
| `comment.lua` | `numToStr/Comment.nvim` | Smart code commenting |
| `zen-mode.lua` | `folke/zen-mode.nvim` | Distraction-free writing mode |
| `zen-mode.lua` | `folke/twilight.nvim` | Dims inactive code with zen mode |
| `claude-tmux.lua` | keymaps only | Opens Claude/GLM in tmux split |

Dependencies: `nvim-lua/plenary.nvim`, `nvim-tree/nvim-web-devicons`,
`MunifTanjim/nui.nvim`.

## Keybindings

Leader key is `Space`.

### Telescope

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | List open buffers |
| `<leader>fr` | Recent files |
| `<leader>/` | Search in current buffer |

### Neo-tree

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file tree |
| `<leader>o` | Focus file tree |
| `l` | Open file/directory |
| `h` | Close node/go up |
| `a` | Add file/folder |
| `d` | Delete |
| `r` | Rename |
| `?` | Show all keybinds |

### Comment.nvim

| Key | Action |
|-----|--------|
| `gcc` | Toggle comment on line |
| `gc` + motion | Comment with motion |
| `gc` in visual | Comment selection |

### Which-key

| Key | Action |
|-----|--------|
| `<leader>?` | Show buffer keymaps |
| pause mid-keypress | Show available hints |

### Zen Mode

| Key | Action |
|-----|--------|
| `<leader>z` | Toggle zen mode |

### Claude/GLM tmux integration

| Key | Action |
|-----|--------|
| `<leader>cc` | Open Claude in right tmux pane with current file |
| `<leader>cC` | Open Claude in right tmux pane without file |
| `<leader>cg` | Open GLM in right tmux pane with current file |
| `<leader>cr` | Open Claude resume picker in right tmux pane |

`<leader>cg` assumes a `glm` command/function exists in the shell environment.

## Basic Settings

- Line numbers: absolute + relative
- System clipboard integration
- Text width: 80 columns
- Show command and ruler enabled
- Auto-reload files changed externally

## Theme

`init.lua` loads `colorscheme mercedes-petronas` from
`colors/mercedes-petronas.lua`. To switch back manually:

```lua
vim.cmd("colorscheme carbonfox")
```
