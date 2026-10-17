return {
  {
    "folke/snacks.nvim",
    init = function()
      local function set_path_highlights()
        -- NonText is too dim for filenames; copy only foregrounds to preserve picker backgrounds.
        for group, source in pairs({
          SnacksPickerPathHidden = "Normal",
          SnacksPickerPathIgnored = "Conceal",
        }) do
          local fg = vim.api.nvim_get_hl(0, { name = source, link = false }).fg
          vim.api.nvim_set_hl(0, group, { fg = fg })
        end
      end
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("snacks_path_highlights", { clear = true }),
        callback = set_path_highlights,
      })
      set_path_highlights()
    end,
    opts = {
      image = {
        enabled = not vim.g.neovide,
      },
      picker = {
        sources = {
          explorer = { hidden = true, ignored = true },
          files = { hidden = true, ignored = false },
          grep = { hidden = true, ignored = false },
        },
      },
    },
  },
}
