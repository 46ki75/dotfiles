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
          files = { hidden = true, ignored = true },
          grep = { hidden = true, ignored = true },
        },
      },
    },
  },
}
