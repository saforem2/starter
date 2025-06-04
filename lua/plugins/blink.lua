return {
  -- add blink.compat
  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    "saghen/blink.cmp",
    -- version = "0.*",
    lazy = false,
    dependencies = {
      -- add source
      "jc-doyle/cmp-pandoc-references",
      "saghen/blink.compat",
      { "dmitmel/cmp-digraphs" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-buffer" },
      -- "hrsh7th/cmp-path",
      { "dmitmel/cmp-cmdline-history" },
      { "FelipeLema/cmp-async-path" },
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-nvim-lua" },
      { "saadparwaiz1/cmp_luasnip" },
      { "f3fora/cmp-spell" },
      { "ray-x/cmp-treesitter" },
      { "kdheepak/cmp-latex-symbols" },
      { "jmbuhr/cmp-pandoc-references" },
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
      { "onsails/lspkind-nvim" },
      { "jmbuhr/otter.nvim" },
      { "giuxtaposition/blink-cmp-copilot" },
    },
    -- opts = {
    -- completion = {
    --   menu = {
    --     draw = {
    --       components = {
    --         kind_icon = {
    --           text = function(ctx)
    --             local icon = ctx.kind_icon
    --             if vim.tbl_contains({ "Path" }, ctx.source_name) then
    --               local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
    --               if dev_icon then
    --                 icon = dev_icon
    --               end
    --             else
    --               icon = require("lspkind").symbolic(ctx.kind, {
    --                 mode = "symbol",
    --               })
    --             end
    --
    --             return icon .. ctx.icon_gap
    --           end,
    --
    --           -- Optionally, use the highlight groups from nvim-web-devicons
    --           -- You can also add the same function for `kind.highlight` if you want to
    --           -- keep the highlight groups in sync with the icons.
    --           highlight = function(ctx)
    --             local hl = ctx.kind_hl
    --             if vim.tbl_contains({ "Path" }, ctx.source_name) then
    --               local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
    --               if dev_icon then
    --                 hl = dev_hl
    --               end
    --             end
    --             return hl
    --           end,
    --         },
    --       },
    --     },
    --   },
    -- },
    -- appearance = {
    --   -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
    --   -- kind_icons = {
    --   --   Copilot = " ",
    --   --   Text = "󰉿 ",
    --   --   Method = "󰡱 ",
    --   --   Function = "󰊕",
    --   --   Constructor = "󰒓 ",
    --   --   Field = "󰜢 ",
    --   --   Variable = "󰆦 ",
    --   --   Property = "󰖷 ",
    --   --
    --   --   Class = "󱡠 ",
    --   --   Interface = "󱡠 ",
    --   --   Struct = "󱡠 ",
    --   --   Module = "󰅩 ",
    --   --
    --   --   Unit = "󰪚 ",
    --   --   Value = "󰦨 ",
    --   --   Enum = "󰦨 ",
    --   --   EnumMember = "󰦨 ",
    --   --
    --   --   Keyword = "󰻾 ",
    --   --   Constant = "󰏿 ",
    --   --
    --   --   Snippet = "󱄽 ",
    --   --   Color = "󰏘 ",
    --   --   File = "󰈔 ",
    --   --   Reference = "󰬲 ",
    --   --   Folder = "󰉋 ",
    --   --   Event = "󱐋 ",
    --   --   Operator = "󰪚 ",
    --   --   TypeParameter = "󰬛 ",
    --   -- },
    -- },
    sources = {
      -- remember to enable your providers here
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "digraphs",
        "omni",
        "cmdline",
        -- "copilot.lua",
        "codeium",
        "nvim_lua",
        "spell",
        "treesitter",
        "calc",
        "latex_symbols",
        "emoji",
        "otter",
        "async_path",
        "cmdline_history",
        "nvim_lsp_signature_help",
      },
      compat = { "pandoc_references" },
      providers = {
        references = {
          name = "pandoc_references",
          module = "cmp-pandoc-references.blink",
        },
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
        -- create provider
        digraphs = {
          -- IMPORTANT: use the same name as you would for nvim-cmp
          name = "digraphs",
          module = "blink.compat.source",

          -- all blink.cmp source config options work as normal:
          score_offset = -3,

          -- this table is passed directly to the proxied completion source
          -- as the `option` field in nvim-cmp's source config
          --
          -- this is NOT the same as the opts in a plugin's lazy.nvim spec
          opts = {
            -- this is an option from cmp-digraphs
            cache_digraphs_on_start = true,

            -- If you'd like to use a `name` that does not exactly match nvim-cmp,
            -- set `cmp_name` to the name you would use for nvim-cmp, for instance:
            -- cmp_name = "digraphs"
            -- then, you can set the source's `name` to whatever you like.
          },
        },
      },
    },
    -- },
  },
}
