return {
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        menu = {
          border = "single",
          draw = {
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                -- Optionally, you may also use the highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
        documentation = { window = { border = "single" } },
      },
      signature = { window = { border = "single" } },
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = "default" },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },
  -- LSP servers and clients communicate which features they support through "capabilities".
  --  By default, Neovim supports a subset of the LSP specification.
  --  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
  --  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
  --
  -- This can vary by config, but in general for nvim-lspconfig:

  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = { "saghen/blink.cmp" },
  --
  --   -- -- example using `opts` for defining servers
  --   -- opts = {
  --   --   servers = {
  --   --     lua_ls = {}
  --   --   }
  --   -- },
  --   -- config = function(_, opts)
  --   --   local lspconfig = require('lspconfig')
  --   --   for server, config in pairs(opts.servers) do
  --   --     -- passing config.capabilities to blink.cmp merges with the capabilities in your
  --   --     -- `opts[server].capabilities, if you've defined it
  --   --     config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  --   --     lspconfig[server].setup(config)
  --   --   end
  --   -- end
  --
  --   -- example calling setup directly for each LSP
  --   config = function()
  --     local capabilities = require("blink.cmp").get_lsp_capabilities()
  --     local lspconfig = require("lspconfig")
  --
  --     lspconfig["lua-ls"].setup({ capabilities = capabilities })
  --   end,
  -- },
}
