-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.timeoutlen = 500
vim.opt.background = "dark"

if vim.g.neovide then
  vim.opt.guifont = "DM Mono,Symbols Nerd Font Mono,Zen Kaku Gothic New"
end
