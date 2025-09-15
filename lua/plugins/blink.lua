-- if true then
--   return {}
-- end
--
--
return {
  ------@diagnostic disable: missing-fields
  ---if lazyvim_docs then
  ---  -- set to `true` to follow the main branch
  ---  -- you need to have a working rust toolchain to build the plugin
  ---  -- in this case.
  ---  vim.g.lazyvim_blink_main = false
  ---end
  ---
  ---return {
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    -- enabled = false,
  },
  {
    "saghen/blink.cmp",
    version = not vim.g.lazyvim_blink_main and "*",
    build = vim.g.lazyvim_blink_main and "cargo build --release",
    -- enabled = true,
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        enabled = true,
        opts = {
          debug = true,
        },
        version = not vim.g.lazyvim_blink_main and "*",
      },
      { "folke/snacks.nvim" },
      {
        "jc-doyle/cmp-pandoc-references",
        config = function()
          local cmppandoc = require("cmp-pandoc-references")
          cmppandoc.setup()
          cmppandoc.is_available = function()
            return vim.o.filetype == "pandoc"
              or vim.o.filetype == "markdown"
              or vim.o.fileyype == "rmd"
              or vim.o.filetype == "quarto"
          end
        end,
      },
      { "mikavilpas/blink-ripgrep.nvim" },
      { "dmitmel/cmp-digraphs" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-buffer" },
      -- { "saghen/blink.compat " },
      { "micangl/cmp-vimtex" },
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
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
      { "onsails/lspkind-nvim" },
      -- { "jmbuhr/otter.nvim" },
      { "giuxtaposition/blink-cmp-copilot" },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = {
        expand = function(snippet, _)
          return LazyVim.cmp.expand(snippet)
        end,
      },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },

      -- experimental signature help support
      signature = { enabled = true },

      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {
          "pandoc_references",
          "vimtex",
        },
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "ripgrep",
          -- "omni",
          -- "pandoc_references",
          "copilot",
          -- "codeium",
          "digraphs",
          "nvim_lua",
          "spell",
          "treesitter",
          "calc",
          "latex_symbols",
          "async_path",
          "cmdline_history",
        },
        {
          --           "lsp",
          --           "otter",
          --           "nvim_lsp_signature_help",
          --           "omni",
          --           "path",
          --           "copilot",
          --           "snippets",
          --           "digraphs",
          --           -- "cmdline",
          --           "nvim_lua",
          --           "spell",
          --           "treesitter",
          --           "calc",
          --           "buffer",
          --           "ripgrep",
          --           "latex_symbols",
          --           "emoji",
          --           "async_path",
          --           "cmdline_history",
        },

        cmdline = {
          enabled = true,
        },

        keymap = {
          preset = "enter",
          ["<C-y>"] = { "select_and_accept" },
        },
      },
      ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
      config = function(_, opts)
        -- setup compat sources
        local enabled = opts.sources.default
        for _, source in ipairs(opts.sources.compat or {}) do
          opts.sources.providers[source] = vim.tbl_deep_extend(
            "force",
            { name = source, module = "blink.compat.source" },
            opts.sources.providers[source] or {}
          )
          if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
            table.insert(enabled, source)
          end
        end

        -- add ai_accept to <Tab> key
        if not opts.keymap["<Tab>"] then
          if opts.keymap.preset == "super-tab" then -- super-tab
            opts.keymap["<Tab>"] = {
              require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
              LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
              "fallback",
            }
          else -- other presets
            opts.keymap["<Tab>"] = {
              LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
              "fallback",
            }
          end
        end

        -- Unset custom prop to pass blink.cmp validation
        opts.sources.compat = nil

        -- check if we need to override symbol kinds
        for _, provider in pairs(opts.sources.providers or {}) do
          ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
          if provider.kind then
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1

            CompletionItemKind[kind_idx] = provider.kind
            ---@diagnostic disable-next-line: no-unknown
            CompletionItemKind[provider.kind] = kind_idx

            ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
            local transform_items = provider.transform_items
            ---@param ctx blink.cmp.Context
            ---@param items blink.cmp.CompletionItem[]
            provider.transform_items = function(ctx, items)
              items = transform_items and transform_items(ctx, items) or items
              for _, item in ipairs(items) do
                item.kind = kind_idx or item.kind
                item.kind_icon = LazyVim.config.icons.kinds[item.kind_name] or item.kind_icon or nil
              end
              return items
            end

            -- Unset custom prop to pass blink.cmp validation
            provider.kind = nil
          end
        end

        require("blink.cmp").setup(opts)
      end,
    },
  },
}

-- -- add icons
-- {
--   "saghen/blink.cmp",
--   opts = function(_, opts)
--     opts.appearance = opts.appearance or {}
--     opts.appearance.kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds)
--   end,
-- },
--
-- -- lazydev
-- {
--   "saghen/blink.cmp",
--   opts = {
--     sources = {
--       -- add lazydev to your completion providers
--       default = { "lazydev" },
--       providers = {
--         lazydev = {
--           name = "LazyDev",
--           module = "lazydev.integrations.blink",
--           score_offset = 100, -- show at a higher priority than lsp
--         },
--       },
--     },
--   },
-- },
-- -- catppuccin support
-- {
--   "catppuccin",
--   optional = true,
--   enabled = "false",
--   opts = {
--     integrations = { blink_cmp = true },
--   },
-- },

-- return {
--   -- add blink.compat
--   {
--     "saghen/blink.compat",
--     -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
--     version = "*",
--     enabled = true,
--     -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
--     lazy = true,
--     -- make sure to set opts so that lazy.nvim calls blink.compat's setup
--     opts = {},
--   },
--   {
--     "saghen/blink.cmp",
--     version = "1.*",
--     lazy = false,
--     enabled = true,
--     dependencies = {
--       -- "hrsh7th/cmp-path",
--       -- add source
--       -- "jc-doyle/cmp-pandoc-references",
--       -- "jmbuhr/cmp-pandoc-references",
--       -- "saghen/blink.compat",
--       -- {
--       --   "Exafunction/codeium.nvim",
--       --   dependencies = {
--       --     "nvim-lua/plenary.nvim",
--       --   },
--       --   opts = {},
--       -- },
--       { "folke/snacks.nvim" },
--       { "jc-doyle/cmp-pandoc-references" },
--       { "mikavilpas/blink-ripgrep.nvim" },
--       { "saghen/blink.compat" },
--       { "dmitmel/cmp-digraphs" },
--       { "hrsh7th/cmp-nvim-lsp" },
--       { "hrsh7th/cmp-nvim-lsp-signature-help" },
--       { "hrsh7th/cmp-buffer" },
--       -- "hrsh7th/cmp-path",
--       { "dmitmel/cmp-cmdline-history" },
--       { "FelipeLema/cmp-async-path" },
--       { "hrsh7th/cmp-calc" },
--       { "hrsh7th/cmp-emoji" },
--       { "hrsh7th/cmp-nvim-lua" },
--       { "saadparwaiz1/cmp_luasnip" },
--       { "f3fora/cmp-spell" },
--       { "ray-x/cmp-treesitter" },
--       { "kdheepak/cmp-latex-symbols" },
--       { "jmbuhr/cmp-pandoc-references" },
--       { "L3MON4D3/LuaSnip" },
--       { "rafamadriz/friendly-snippets" },
--       { "onsails/lspkind-nvim" },
--       { "jmbuhr/otter.nvim" },
--       { "giuxtaposition/blink-cmp-copilot" },
--     },
--     opts = {
--       completion = {
--         menu = {
--           draw = {
--             components = {
--               kind_icon = {
--                 text = function(ctx)
--                   local icon = ctx.kind_icon
--                   if vim.tbl_contains({ "Path" }, ctx.source_name) then
--                     local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
--                     if dev_icon then
--                       icon = dev_icon
--                     end
--                   else
--                     icon = require("lspkind").symbolic(ctx.kind, {
--                       mode = "symbol",
--                     })
--                   end
--
--                   return icon .. ctx.icon_gap
--                 end,
--
--                 -- Optionally, use the highlight groups from nvim-web-devicons
--                 -- You can also add the same function for `kind.highlight` if you want to
--                 -- keep the highlight groups in sync with the icons.
--                 highlight = function(ctx)
--                   local hl = ctx.kind_hl
--                   if vim.tbl_contains({ "Path" }, ctx.source_name) then
--                     local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
--                     if dev_icon then
--                       hl = dev_hl
--                     end
--                   end
--                   return hl
--                 end,
--               },
--             },
--           },
--         },
--       },
--       appearance = {
--         -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
--         kind_icons = {
--           Copilot = " ",
--           Text = "󰉿 ",
--           Method = "󰡱 ",
--           Function = "󰊕",
--           Constructor = "󰒓 ",
--           Field = "󰜢 ",
--           Variable = "󰆦 ",
--           Property = "󰖷 ",
--
--           Class = "󱡠 ",
--           Interface = "󱡠 ",
--           Struct = "󱡠 ",
--           Module = "󰅩 ",
--
--           Unit = "󰪚 ",
--           Value = "󰦨 ",
--           Enum = "󰦨 ",
--           EnumMember = "󰦨 ",
--
--           Keyword = "󰻾 ",
--           Constant = "󰏿 ",
--
--           Snippet = "󱄽 ",
--           Color = "󰏘 ",
--           File = "󰈔 ",
--           Reference = "󰬲 ",
--           Folder = "󰉋 ",
--           Event = "󱐋 ",
--           Operator = "󰪚 ",
--           TypeParameter = "󰬛 ",
--         },
--       },
--       sources = {
--         -- remember to enable your providers here
--         default = {
--           "lsp",
--           "otter",
--           "nvim_lsp_signature_help",
--           "omni",
--           "path",
--           "copilot",
--           "snippets",
--           "digraphs",
--           -- "cmdline",
--           "nvim_lua",
--           "spell",
--           "treesitter",
--           "calc",
--           "buffer",
--           "ripgrep",
--           "latex_symbols",
--           "emoji",
--           "async_path",
--           "cmdline_history",
--         },
--         completion = {
--           enabled_providers = {
--             "lsp",
--             "path",
--             "snippets",
--             "buffer",
--             -- "codeium",
--             "copilot",
--             "digraphs",
--             "cmdline",
--             "nvim_lua",
--             "pandoc_references",
--             "spell",
--             "treesitter",
--             "calc",
--             "latex_symbols",
--             "async_path",
--             "cmdline_history",
--           },
--         },
--
--         compat = { "emoji", "pandoc_references" },  -- , "codeium" },
--         providers = {
--           -- references = {
--           --   name = "pandoc_references",
--           --   module = "cmp-pandoc-references.blink",
--           -- },
--           copilot = {
--             name = "copilot",
--             module = "blink-cmp-copilot",
--             kind = "Copilot",
--             score_offset = 100,
--             async = true,
--             -- transform_items = function(_, items)
--             --   local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
--             --   local kind_idx = #CompletionItemKind + 1
--             --   CompletionItemKind[kind_idx] = "Copilot"
--             --   for _, item in ipairs(items) do
--             --     item.kind = kind_idx
--             --   end
--             --   return items
--             -- end,
--           },
--
--           --   name = "Codeium",
--           --   module = "codeium.blink",
--           --   async = true,
--           -- },
--           -- codeium = {
--           --   kind = "Codeium",
--           --   score_offset = 100,
--           --   async = true,
--           --   name = "codeium",
--           --   module = "blink-cmp-codeium",
--           --   score_offset = 100,
--           --   async = true,
--           --   transform_items = function(_, items)
--           --     local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
--           --     local kind_idx = #CompletionItemKind + 1
--           --     CompletionItemKind[kind_idx] = "Codeium"
--           --     for _, item in ipairs(items) do
--           --       item.kind = kind_idx
--           --     end
--           --     return items
--           --   end,
--           -- },
--           pyright = {
--             name = "pyright",
--             module = "blink.compat.source",
--             score_offset = 100,
--             async = true,
--             transform_items = function(_, items)
--               local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
--               local kind_idx = #CompletionItemKind + 1
--               CompletionItemKind[kind_idx] = "Pyright"
--               for _, item in ipairs(items) do
--                 item.kind = kind_idx
--               end
--               return items
--             end,
--           },
--           bashls = {
--             name = "bashls",
--             module = "blink.compat.source",
--             score_offset = 100,
--             async = true,
--             transform_items = function(_, items)
--               local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
--               local kind_idx = #CompletionItemKind + 1
--               CompletionItemKind[kind_idx] = "Bashls"
--               for _, item in ipairs(items) do
--                 item.kind = kind_idx
--               end
--               return items
--             end,
--           },
--           -- create provider
--           digraphs = {
--             -- IMPORTANT: use the same name as you would for nvim-cmp
--             name = "digraphs",
--             module = "blink.compat.source",
--
--             -- all blink.cmp source config options work as normal:
--             score_offset = -3,
--
--             -- this table is passed directly to the proxied completion source
--             -- as the `option` field in nvim-cmp's source config
--             -- this is NOT the same as the opts in a plugin's lazy.nvim spec
--             opts = {
--               -- this is an option from cmp-digraphs
--               cache_digraphs_on_start = true,
--
--               -- If you'd like to use a `name` that does not exactly match nvim-cmp,
--               -- set `cmp_name` to the name you would use for nvim-cmp, for instance:
--               -- cmp_name = "digraphs"
--               -- then, you can set the source's `name` to whatever you like.
--             },
--           },
--           ripgrep = {
--             module = "blink-ripgrep",
--             name = "Ripgrep",
--             -- the options below are optional, some default values are shown
--             ---@module "blink-ripgrep"
--             ---@type blink-ripgrep.Options
--             opts = {
--               -- the minimum length of the current word to start searching
--               -- (if the word is shorter than this, the search will not start)
--               prefix_min_len = 3,
--
--               -- Specifies how to find the root of the project where the ripgrep
--               -- search will start from. Accepts the same options as the marker
--               -- given to `:h vim.fs.root()` which offers many possibilities for
--               -- configuration. If none can be found, defaults to Neovim's cwd.
--               --
--               -- Examples:
--               -- - ".git" (default)
--               -- - { ".git", "package.json", ".root" }
--               project_root_marker = ".git",
--
--               -- When a result is found for a file whose filetype does not have a
--               -- treesitter parser installed, fall back to regex based highlighting
--               -- that is bundled in Neovim.
--               fallback_to_regex_highlighting = true,
--
--               -- Keymaps to toggle features on/off. This can be used to alter
--               -- the behavior of the plugin without restarting Neovim. Nothing
--               -- is enabled by default. Requires folke/snacks.nvim.
--               toggles = {
--                 -- The keymap to toggle the plugin on and off from blink
--                 -- completion results. Example: "<leader>tg" ("toggle grep")
--                 on_off = nil,
--
--                 -- The keymap to toggle debug mode on/off. Example: "<leader>td" ("toggle debug")
--                 debug = nil,
--               },
--
--               backend = {
--                 -- The backend to use for searching. Defaults to "ripgrep".
--                 -- Available options:
--                 -- - "ripgrep", always use ripgrep
--                 -- - "gitgrep", always use git grep
--                 -- - "gitgrep-or-ripgrep", use git grep if possible, otherwise
--                 --   use ripgrep
--                 use = "ripgrep",
--
--                 -- Whether to set up custom highlight-groups for the icons used
--                 -- in the completion items. Defaults to `true`, which means this
--                 -- is enabled.
--                 customize_icon_highlight = true,
--
--                 ripgrep = {
--                   -- For many options, see `rg --help` for an exact description of
--                   -- the values that ripgrep expects.
--
--                   -- The number of lines to show around each match in the preview
--                   -- (documentation) window. For example, 5 means to show 5 lines
--                   -- before, then the match, and another 5 lines after the match.
--                   context_size = 5,
--
--                   -- The maximum file size of a file that ripgrep should include
--                   -- in its search. Useful when your project contains large files
--                   -- that might cause performance issues.
--                   -- Examples:
--                   -- "1024" (bytes by default), "200K", "1M", "1G", which will
--                   -- exclude files larger than that size.
--                   max_filesize = "1M",
--
--                   -- Enable fallback to neovim cwd if project_root_marker is not
--                   -- found. Default: `true`, which means to use the cwd.
--                   project_root_fallback = true,
--
--                   -- The casing to use for the search in a format that ripgrep
--                   -- accepts. Defaults to "--ignore-case". See `rg --help` for
--                   -- all the available options ripgrep supports, but you can try
--                   -- "--case-sensitive" or "--smart-case".
--                   search_casing = "--ignore-case",
--
--                   -- (advanced) Any additional options you want to give to
--                   -- ripgrep. See `rg -h` for a list of all available options.
--                   -- Might be helpful in adjusting performance in specific
--                   -- situations. If you have an idea for a default, please open
--                   -- an issue!
--                   --
--                   -- Not everything will work (obviously).
--                   additional_rg_options = {},
--
--                   -- Absolute root paths where the rg command will not be
--                   -- executed. Usually you want to exclude paths using gitignore
--                   -- files or ripgrep specific ignore files, but this can be used
--                   -- to only ignore the paths in blink-ripgrep.nvim, maintaining
--                   -- the ability to use ripgrep for those paths on the command
--                   -- line. If you need to find out where the searches are
--                   -- executed, enable `debug` and look at `:messages`.
--                   ignore_paths = {},
--
--                   -- Any additional paths to search in, in addition to the
--                   -- project root. This can be useful if you want to include
--                   -- dictionary files (/usr/share/dict/words), framework
--                   -- documentation, or any other reference material that is not
--                   -- available within the project root.
--                   additional_paths = {},
--                 },
--               },
--
--               -- Show debug information in `:messages` that can help in
--               -- diagnosing issues with the plugin.
--               debug = false,
--             },
--             -- (optional) customize how the results are displayed. Many options
--             -- are available - make sure your lua LSP is set up so you get
--             -- autocompletion help
--             transform_items = function(_, items)
--               for _, item in ipairs(items) do
--                 -- example: append a description to easily distinguish rg results
--                 item.labelDetails = {
--                   description = "(rg)",
--                 }
--               end
--               return items
--             end,
--           },
--         },
--       },
--       signature = { enabled = true },
--       keymap = {
--         -- 👇🏻👇🏻 (optional) add a keymap to invoke the search manually
--         ["<c-g>"] = {
--           function()
--             require("blink-cmp").show({ providers = { "ripgrep" } })
--           end,
--         },
--       },
--     },
--   },
-- }
