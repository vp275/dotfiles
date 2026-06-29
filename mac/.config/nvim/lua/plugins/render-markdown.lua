return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        configs.setup({
          ensure_installed = { "markdown", "markdown_inline" },
          highlight = { enable = true },
        })
      end
    end,
  },
}
