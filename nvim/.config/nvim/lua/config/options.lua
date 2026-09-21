-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.timeoutlen = 500
vim.opt.background = "dark"

if vim.g.neovide then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':~')}"

  -- Match Ghostty's size and disable hinting to reduce heavy-looking strokes.
  vim.opt.guifont = "DM Mono Light,Symbols Nerd Font Mono,Zen Kaku Gothic New:h13:#h-none"
  -- Set at startup because Neovide can cache font rendering.
  vim.g.neovide_text_gamma = 0.8
  vim.g.neovide_text_contrast = 0.1
end
