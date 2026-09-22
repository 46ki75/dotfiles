return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = not vim.g.neovide,
      },
      picker = {
        sources = {
          explorer = { hidden = false, ignored = false },
          files = { hidden = false, ignored = false },
          grep = { hidden = false, ignored = false },
        },
      },
    },
  },
}
