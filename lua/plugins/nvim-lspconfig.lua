if true then return {} end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    -- example using `opts` for defining servers
    opts = {
      servers = {
        lua_ls = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff_lsp = {
          init_options = {
            settings = {
              args = { "--line-length", "80" },
            },
          },
        },
        bash_language_server = {
          filetypes = { "sh", "zsh", "bash" },
          settings = {
            shellcheck = {
              enable = true,
            },
            shfmt = {
              enable = true,
            },
          },
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
    -- -- example calling setup directly for each LSP
    -- config = function()
    --     local capabilities = require('blink.cmp').get_lsp_capabilities()
    --     local lspconfig = require('lspconfig')
    --     lspconfig['lua_ls'].setup({ capabilities = capabilities })
    -- end
  },
}
