return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "mdslw" },
      },
      formatters = {
        mdslw = { prepend_args = { "--stdin-filepath", "$FILENAME" } },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },
}
