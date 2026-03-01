return {
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
      -- Disable dynamic file watcher registration for mdx_analyzer.
      -- The server registers watchers with the glob **/*.{mdx}, which is
      -- invalid (single-element brace expansion) in Neovim's glob parser.
      vim.lsp.config("mdx_analyzer", {
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = false,
            },
          },
        },
      })
    end,
  },
}
