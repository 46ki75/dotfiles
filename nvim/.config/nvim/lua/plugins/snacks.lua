return {
  {
    "folke/snacks.nvim",
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
