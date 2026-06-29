-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key (must be before lazy)
vim.g.mapleader = " "

-- Basic settings (from your .vimrc)
vim.opt.syntax = "on"
vim.opt.autoread = true

-- Auto-reload files when changed externally
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime",
})
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.textwidth = 80

-- Load plugins
require("lazy").setup("plugins")

-- Load Mercedes Petronas theme (from colors/mercedes-petronas.lua)
-- To switch back to carbonfox: vim.cmd("colorscheme carbonfox")
vim.cmd("colorscheme mercedes-petronas")
