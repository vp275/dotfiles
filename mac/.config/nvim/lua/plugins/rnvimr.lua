return {
  {
    "kevinhwang91/rnvimr",
    cmd = { "RnvimrToggle", "RnvimrResize" },
    keys = {
      { "<leader>r", "<cmd>RnvimrToggle<cr>", desc = "Ranger" },
    },
    init = function()
      vim.g.rnvimr_enable_picker = 1
    end,
  },
}
