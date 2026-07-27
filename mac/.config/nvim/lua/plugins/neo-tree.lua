local function toggle_dotfiles(state)
  local filtered_items = state.filtered_items
  filtered_items.hide_dotfiles = not filtered_items.hide_dotfiles
  filtered_items.visible = false

  require("neo-tree.sources.filesystem.commands").refresh(state)
  vim.notify("Neo-tree: dotfiles " .. (filtered_items.hide_dotfiles and "hidden" or "shown"))
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File explorer" },
      { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus explorer" },
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["H"] = toggle_dotfiles,
          ["zh"] = toggle_dotfiles,
        },
      },
    },
  },
}
