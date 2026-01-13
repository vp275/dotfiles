return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme carbonfox")
      -- Dark tint background (semitransparent black)
      vim.api.nvim_set_hl(0, "Normal", { bg = "#0a0a0a" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0a0a0a" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "#0a0a0a" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "#0a0a0a" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#0a0a0a" })
      vim.api.nvim_set_hl(0, "FoldColumn", { bg = "#0a0a0a" })
    end,
  },
}
