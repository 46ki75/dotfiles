-- Run from the repository root: nvim --headless -u NONE -i NONE -l nvim/tests/snacks-highlights.lua
-- Requires snacks.nvim installed in lazy.nvim's standard data directory.
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
vim.opt.rtp:prepend(root .. "/.config/nvim")
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/snacks.nvim")

local function highlight(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local function check_highlights(context)
  for group, target in pairs({
    SnacksPickerPathHidden = "Normal",
    SnacksPickerPathIgnored = "Conceal",
  }) do
    assert(highlight(group).fg == highlight(target).fg, context .. ": " .. group .. " must use " .. target)
    assert(highlight(group).fg ~= highlight("NonText").fg, context .. ": " .. group .. " must not use NonText")
  end
end

vim.o.background = "dark"
vim.cmd.colorscheme("ikuma")
local nontext = highlight("NonText")
local spec = dofile(root .. "/.config/nvim/lua/plugins/snacks.lua")[1]
if spec.init then
  spec.init()
end

require("snacks")
require("snacks.picker.config.highlights")
check_highlights("startup")
assert(vim.deep_equal(highlight("NonText"), nontext), "NonText must remain unchanged")

for _, background in ipairs({ "light", "dark" }) do
  vim.o.background = background
  check_highlights(background .. " background switch")
  vim.cmd.colorscheme("ikuma")
  check_highlights(background .. " colorscheme reload")
end

print("Snacks hidden/ignored highlights: OK")
