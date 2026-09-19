return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.markdown = {}
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      for _, ft in ipairs({ "markdown", "markdown.mdx" }) do
        opts.formatters_by_ft[ft] = vim.tbl_filter(function(formatter)
          return formatter ~= "markdownlint-cli2"
        end, opts.formatters_by_ft[ft] or {})
      end
    end,
  },
}
