return {
  {
    "folke/snacks.nvim",
    init = function()
      local function set_path_highlights()
        -- Snacks defaults both to NonText, which is too dim for filenames in the Ikuma theme.
        vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "Normal" })
        vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { link = "Conceal" })
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
