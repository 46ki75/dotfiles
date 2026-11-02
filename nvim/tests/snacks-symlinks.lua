-- Run from the repository root: nvim --headless -u NONE -i NONE -l nvim/tests/snacks-symlinks.lua
-- Requires ripgrep and snacks.nvim installed in lazy.nvim's standard data directory.
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/snacks.nvim")
require("snacks")

local sources = dofile(root .. "/.config/nvim/lua/plugins/snacks.lua")[1].opts.picker.sources
local fixture = vim.fn.tempname()
local target, stowed = fixture .. "/target", fixture .. "/stowed"
vim.fn.mkdir(target .. "/lua", "p")
vim.fn.mkdir(stowed .. "/.git", "p")

-- Capture the real finders' commands without opening a picker or running its async UI.
require("snacks.picker.source.proc").proc = function(opts)
  return opts
end

local function run(source)
  local opts = vim.tbl_extend("force", { cwd = stowed, cmd = "rg", debug = {} }, sources[source])
  local ctx = {
    filter = { search = source == "grep" and "symlink_regression" or "" },
    opts = function(_, overrides)
      return vim.tbl_extend("force", opts, overrides)
    end,
  }
  -- Explorer search delegates to the files finder using its own source options.
  local finder = source == "grep" and "grep" or "files"
  local command = require("snacks.picker.source." .. finder)[finder](opts, ctx)
  local argv = vim.list_extend({ command.cmd }, command.args)
  local result = vim.system(argv, { cwd = command.cwd, text = true }):wait()
  assert(result.code == 0, source .. " exited " .. result.code .. ": " .. result.stderr)
  return result.stdout
end

local ok, err = xpcall(function()
  for _, name in ipairs({ "init.lua", ".hidden", "ignored.lua", "lua/config.lua" }) do
    vim.fn.writefile({ "symlink_regression" }, target .. "/" .. name)
  end
  vim.fn.writefile({ "ignored.lua" }, target .. "/.ignore")
  for _, name in ipairs({ "init.lua", ".hidden", "ignored.lua", ".ignore", "lua" }) do
    assert(vim.uv.fs_symlink(target .. "/" .. name, stowed .. "/" .. name))
  end
  vim.fn.writefile({ "symlink_regression" }, stowed .. "/.git/excluded")

  for _, source in ipairs({ "files", "grep", "explorer" }) do
    local output = run(source)
    for _, name in ipairs({ "init.lua", ".hidden", "lua/config.lua" }) do
      assert(output:find(name, 1, true), source .. " must find symlinked " .. name)
    end
    assert(not output:find(".git/", 1, true), source .. " must exclude .git")
    local found_ignored = output:find("ignored.lua", 1, true) ~= nil
    assert(found_ignored == sources[source].ignored, source .. " must preserve ignore behavior")
  end
end, debug.traceback)
vim.fn.delete(fixture, "rf")
assert(ok, err)
print("Snacks symlink discovery and search: OK")
