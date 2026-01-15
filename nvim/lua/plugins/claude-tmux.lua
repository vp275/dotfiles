return {
  {
    "folke/which-key.nvim",  -- just using this as a hook to add keymaps
    keys = {
      {
        "<leader>cc",
        function()
          local file = vim.fn.expand("%:p")
          local dir = vim.fn.expand("%:p:h")
          vim.fn.system("tmux split-window -h -l 40% -c '" .. dir .. "' 'claude \"" .. file .. "\"'")
        end,
        desc = "Claude in tmux pane (current file)",
      },
      {
        "<leader>cC",
        function()
          vim.fn.system("tmux split-window -h -l 40% 'claude'")
        end,
        desc = "Claude in tmux pane (no file)",
      },
      {
        "<leader>cg",
        function()
          local file = vim.fn.expand("%:p")
          local dir = vim.fn.expand("%:p:h")
          vim.fn.system("tmux split-window -h -l 40% -c '" .. dir .. "' 'glm \"" .. file .. "\"'")
        end,
        desc = "GLM in tmux pane (current file)",
      },
      {
        "<leader>cr",
        function()
          local dir = vim.fn.expand("%:p:h")
          vim.fn.system("tmux split-window -h -l 40% -c '" .. dir .. "' 'claude --resume'")
        end,
        desc = "Claude resume (old chats)",
      },
    },
  },
}
