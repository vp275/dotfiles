return {
  {
    "folke/which-key.nvim",  -- just using this as a hook to add keymaps
    keys = {
      {
        "<leader>cc",
        function()
          if vim.fn.executable("claude") == 0 or vim.env.TMUX == nil then
            vim.notify("Claude and tmux must be available for this command", vim.log.levels.WARN)
            return
          end
          local file = vim.fn.expand("%:p")
          local dir = vim.fn.expand("%:p:h")
          vim.fn.system("tmux split-window -h -l 40% -c '" .. dir .. "' 'claude \"" .. file .. "\"'")
        end,
        desc = "Claude in tmux pane (current file)",
      },
      {
        "<leader>cC",
        function()
          if vim.fn.executable("claude") == 0 or vim.env.TMUX == nil then
            vim.notify("Claude and tmux must be available for this command", vim.log.levels.WARN)
            return
          end
          vim.fn.system("tmux split-window -h -l 40% 'claude'")
        end,
        desc = "Claude in tmux pane (no file)",
      },
      {
        "<leader>cg",
        function()
          if vim.fn.executable("glm") == 0 or vim.env.TMUX == nil then
            vim.notify("GLM and tmux must be available for this command", vim.log.levels.WARN)
            return
          end
          local file = vim.fn.expand("%:p")
          local dir = vim.fn.expand("%:p:h")
          vim.fn.system("tmux split-window -h -l 40% -c '" .. dir .. "' 'glm \"" .. file .. "\"'")
        end,
        desc = "GLM in tmux pane (current file)",
      },
      {
        "<leader>cr",
        function()
          if vim.fn.executable("claude") == 0 or vim.env.TMUX == nil then
            vim.notify("Claude and tmux must be available for this command", vim.log.levels.WARN)
            return
          end
          local dir = vim.fn.expand("%:p:h")
          vim.fn.system("tmux split-window -h -l 40% -c '" .. dir .. "' 'claude --resume'")
        end,
        desc = "Claude resume (old chats)",
      },
    },
  },
}
