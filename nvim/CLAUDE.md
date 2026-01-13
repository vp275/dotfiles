# CLAUDE.md

Minimal Neovim configuration using lazy.nvim plugin manager with carbonfox theme.

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

Dependencies: `nvim-tree/nvim-web-devicons` (icons for lualine and render-markdown)

## Basic Settings (init.lua)

- Line numbers: absolute + relative (`number`, `relativenumber`)
- System clipboard integration (`clipboard = "unnamed,unnamedplus"`)
- Text width: 80 columns
- Show command and ruler enabled

## Theme

Carbonfox from nightfox.nvim - dark theme consistent with other tools in this dotfiles repo.
