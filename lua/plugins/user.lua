return {
    {
        "folke/noice.nvim",
        enabled = false,
    },
    {
        -- time-machine.lua
        "y3owk1n/time-machine.nvim",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        "nvimdev/hlsearch.nvim",
        enabled = true,
        lazy = false,
        opts = {},
    },

    {
        "rmagatti/logger.nvim",
        required = true,
        lazy = false,
    },

    {
        "ptdewey/yankbank-nvim",
        dependencies = "kkharji/sqlite.lua",
        config = function()
            require("yankbank").setup({
                persist_type = "sqlite",
            })
        end,
    },
    { "lukas-reinke/indent-blankline.nvim", enabled = false },
    { "nvim-lualine/lualine.nvim", enabled = false },
    {
        "echasnovski/mini.statusline",
        version = false,
        enabled = true,
        config = function()
            require("mini.statusline").setup()
        end,
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
    { "lyokha/vim-publish-helper", lazy = false, enabled = true },
    { "Bekaboo/deadcolumn.nvim", lazy = false, enabled = true },
    { "p00f/nvim-ts-rainbow" },
    { "wakatime/vim-wakatime", lazy = false },
    { "mbbill/undotree" },
    { "machakann/vim-sandwich" },
    { "vim-python/python-syntax" },
    { "Vimjas/vim-python-pep8-indent" },
    { "rafcamlet/nvim-luapad" },
    { "tpope/vim-repeat" },
    { "easymotion/vim-easymotion" },
    { "lervag/vimtex" },
    { "folke/trouble.nvim", cmd = "TroubleToggle", enabled = true, lazy = false },
    { "knubie/vim-kitty-navigator" },
    { "fladson/vim-kitty" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "rrethy/vim-illuminate" },
    { "dhruvasagar/vim-table-mode" },
    { "jghauser/mkdir.nvim" },
    { "hkupty/iron.nvim" },
    { "rktjmp/lush.nvim", lazy = false, enabled = true },
    { "bfredl/nvim-ipy" },
    { "ggandor/lightspeed.nvim", event = "BufRead" },
    { "godlygeek/tabular", enabled = true, lazy = false },
    {
        "mrjones2014/legendary.nvim",
        -- since legendary.nvim handles all your keymaps/commands,
        -- its recommended to load legendary.nvim before other plugins
        priority = 10000,
        lazy = false,
        -- sqlite is only needed if you want to use frecency sorting
        -- dependencies = { 'kkharji/sqlite.lua' }
    },

    {
        "jmbuhr/otter.nvim",
        dependencies = {
            "hrsh7th/nvim-cmp", -- optional, for completion
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("otter").setup({
                lsp = {
                    hover = {
                        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                    },
                    -- `:h events` that cause the diagnostics to update. Set to:
                    -- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
                    -- but more instant diagnostic updates
                    diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
                },
                buffers = {
                    -- if set to true, the filetype of the otterbuffers will be set.
                    -- otherwise only the autocommand of lspconfig that attaches
                    -- the language server will be executed without setting the filetype
                    set_filetype = false,
                    -- write <path>.otter.<embedded language extension> files
                    -- to disk on save of main buffer.
                    -- usefule for some linters that require actual files
                    -- otter files are deleted on quit or main buffer close
                    write_to_disk = false,
                },
                strip_wrapping_quote_characters = { "'", '"', "`" },
                -- Otter may not work the way you expect when entire code blocks are indented (eg. in Org files)
                -- When true, otter handles these cases fully. This is a (minor) performance hit
                handle_leading_whitespace = true,
            })
        end,
    },
    {
        "chentoast/marks.nvim",
        config = function()
            require("marks").setup({
                default_mappings = true,
                -- builtin_marks = {'.', '<', '>', '^'},
                cyclic = true,
                force_write_shada = false,
                refresh_interval = 250,
                sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
                bookmark_0 = { sign = "⚑", virt_text = "hello world" },
            })
        end,
    },

    { -- interactive global search and replace
        "nvim-pack/nvim-spectre",
        cmd = { "Spectre" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    {
        "nacro90/numb.nvim",
        event = "BufRead",
        config = function()
            require("numb").setup({
                show_numbers = true,
                show_cursorline = true,
            })
        end,
    },
    {
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup({
                width = 120,
                height = 25,
                default_mappings = false,
                debug = false,
                opacity = nil,
                post_open_hook = nil,
            })
        end,
    },

    {
        "glacambre/firenvim",
        run = function()
            vim.fn["firenvim#install"](0)
        end,
    },
    {
        "dccsillag/magma-nvim",
        run = ":UpdateRemotePlugins",
    },

    {
        "andymass/vim-matchup",
        event = "CursorMoved",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    -- {
    --   "turbio/bracey.vim",
    --   cmd = { "Bracey", "BraceyStop", "BraceyReload", "BraceyEval" },
    --   run = "npm install --prefix server",
    -- },

    {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({
                signs = true, -- show icons in the signs column
                sign_priority = 8, -- sign priority
                -- keywords recognized as todo comments
                keywords = {
                    FIX = {
                        icon = " ", -- icon used for the sign, and in search results
                        color = "error", -- can be a hex color, or a named color (see below)
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                        -- signs = false, -- configure signs for some keywords individually
                    },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
                },
                gui_style = {
                    fg = "NONE", -- The gui style to use for the fg highlight group.
                    bg = "BOLD", -- The gui style to use for the bg highlight group.
                },
                merge_keywords = true, -- when true, custom keywords will be merged with the defaults
                -- highlighting of the line containing the todo comment
                -- * before: highlights before the keyword (typically comment characters)
                -- * keyword: highlights of the keyword
                -- * after: highlights after the keyword (todo text)
                highlight = {
                    multiline = true, -- enable multine todo comments
                    multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                    multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                    before = "", -- "fg" or "bg" or empty
                    keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                    after = "", -- "fg" or "bg" or empty
                    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                    comments_only = true, -- uses treesitter to match keywords in comments only
                    max_line_len = 400, -- ignore lines longer than this
                    exclude = {}, -- list of file types to exclude highlighting
                },
                -- list of named colors where we try to extract the guifg from the
                -- list of highlight groups or use the hex color if hl not found as a fallback
                colors = {
                    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                    info = { "DiagnosticInfo", "#2563EB" },
                    hint = { "DiagnosticHint", "#10B981" },
                    default = { "Identifier", "#7C3AED" },
                    test = { "Identifier", "#FF00FF" },
                },
                search = {
                    command = "rg",
                    args = {
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                    },
                    -- regex that will be used to match keywords.
                    -- don't replace the (KEYWORDS) placeholder
                    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
                },
            })
        end,
    },
    {
        "Pocco81/HighStr.nvim",
        config = function()
            local high_str = require("high-str")
            high_str.setup({
                verbosity = 1,
                saving_path = "/tmp/highstr/",
                highlight_colors = {
                    color_0 = { "#0c0d0e", "smart" }, -- Cosmic charcoal
                    color_1 = { "#e5c07b", "smart" }, -- Pastel yellow
                    color_2 = { "#7FFFD4", "smart" }, -- Aqua menthe
                    color_3 = { "#8A2BE2", "smart" }, -- Proton purple
                    color_4 = { "#FF4500", "smart" }, -- Orange red
                    color_5 = { "#008000", "smart" }, -- Office green
                    color_6 = { "#0000FF", "smart" }, -- Just blue
                    color_7 = { "#FFC0CB", "smart" }, -- Blush pink
                    color_8 = { "#FFF9E3", "smart" }, -- Cosmic latte
                    color_9 = { "#7d5c34", "smart" }, -- Fallow brown
                },
            })
            vim.api.nvim_set_keymap("v", "<F3>", ":<c-U>HSHighlight 1<CR>", {
                noremap = true,
                silent = true,
            })
            vim.api.nvim_set_keymap("v", "<F4>", ":<c-U>HSRmHighlight<CR>", {
                noremap = true,
                silent = true,
            })
        end,
    },

    { "projekt0n/circles.nvim", requires = { "nvim-tree/nvim-web-devicons" } },
    {
        "simrat39/rust-tools.nvim",
        config = function()
            local rt = require("rust-tools")
            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
            })
        end,
    },

    {
        "YannickFricke/codestats.nvim",
        config = function()
            require("codestats-nvim").setup()
        end,
        requires = { { "nvim-lua/plenary.nvim" } },
    },

    -- {
    --   "Freed-Wu/code-stats.nvim",
    --   config = function()
    --     require("code-stats").setup({
    --       dotenv = "~/codestats.sh",
    --     })
    --   end
    --
    -- },

    -- {
    --   -- "code-stats/code-stats-vim",
    --   "https://gitlab.com/code-stats/code-stats-vim.git",
    --   config = function()
    --     requ
    --     -- REQUIRED: set your API key
    --     -- TODO: Replace with environment variable ??
    --     vim.g["codestats_api_key"] = { os.getenv("CODESTATS_API_KEY") }
    --     -- vim.g['codestats_api_key'] = {os.getenv('CODESTATS_API_KEY')}
    --   end,
    -- },
    {
        "mikesmithgh/kitty-scrollback.nvim",
        enabled = true,
        lazy = true,
        cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
        event = { "User KittyScrollbackLaunch" },
        -- version = '*', -- latest stable version, may have breaking changes if major version changed
        -- version = '^5.0.0', -- pin major version, include fixes and features that do not have breaking changes
        config = function()
            require("kitty-scrollback").setup()
        end,
    },
    {
        "ojroques/nvim-osc52",
        keys = {
            {
                "<leader>y",
                function()
                    return require("osc52").copy_operator()
                end, -- <-- previously I wasn't using a return statement here
                desc = "copy selection to system clipboard (normal mode)",
                expr = true,
            },
            {
                "<leader>Y",
                "<leader>y_",
                remap = true,
                desc = "copy current line into system clipboard (normal mode)",
            },
            {
                mode = "v",
                "<leader>y",
                function()
                    require("osc52").copy_visual()
                end,
                desc = "copy selection to system clipboard (visual mode)",
            },
        },
    },
    { "wakatime/vim-wakatime" },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            require("rainbow-delimiters.setup").setup({})
        end,
    },
}

-- {
--   "AntonVanAssche/md-headers.nvim",
--   version = "*",
--   lazy = false,
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-treesitter/nvim-treesitter",
--   },
--   config = function()
--     require("md-headers").setup({
--       width = 60,
--       height = 10,
--       borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
--       popup_auto_close = true,
--     })
--   end,
-- },

-- { -- gh copilot
--   'zbirenbaum/copilot.lua',
--   enabled = false,
--   config = function()
--     require('copilot').setup {
--       suggestion = {
--         enabled = true,
--         auto_trigger = true,
--         debounce = 75,
--         keymap = {
--           accept = '<c-a>',
--           accept_word = false,
--           accept_line = false,
--           next = '<M-]>',
--           prev = '<M-[>',
--           dismiss = '<C-]>',
--         },
--       },
--       panel = { enabled = false },
--     }
--   end,
-- },
-- {
--   "kevinhwang91/nvim-ufo",
--   lazy = false,
--   enabled = true,
--   dependencies = {
--     "kevinhwang91/promise-async",
--   },
--   config = function()
--     vim.o.foldcolumn = "1" -- '0' is not bad
--     vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
--     vim.o.foldlevelstart = 99
--     vim.o.foldenable = true
--
--     -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
--     vim.keymap.set("n", "zR", require("ufo").openAllFolds)
--     vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
--
--     -- Option 1: coc.nvim as LSP client
--     -- use({ "neoclide/coc.nvim", branch = "master", run = "yarn install --frozen-lockfile" })
--     -- require("ufo").setup()
--     --
--
--     -- Option 2: nvim lsp as LSP client
--     -- Tell the server the capability of foldingRange,
--     -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
--     local capabilities = vim.lsp.protocol.make_client_capabilities()
--     capabilities.textDocument.foldingRange = {
--       dynamicRegistration = false,
--       lineFoldingOnly = true,
--     }
--     local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
--     for _, ls in ipairs(language_servers) do
--       require("lspconfig")[ls].setup({
--         capabilities = capabilities,
--         -- you can add other fields for setting up lsp server in this table
--       })
--     end
--     -- require("ufo").setup()
--     --
--
--     -- Option 3: treesitter as a main provider instead
--     -- (Note: the `nvim-treesitter` plugin is *not* needed.)
--     -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
--     -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
--     require("ufo").setup({
--       provider_selector = function(bufnr, filetype, buftype)
--         return { "treesitter", "indent" }
--       end,
--     })
--     --
--
--     -- Option 4: disable all providers for all buffers
--     -- Not recommend, AFAIK, the ufo's providers are the best performance in Neovim
--     -- require("ufo").setup({
--     --   provider_selector = function(bufnr, filetype, buftype)
--     --     return ""
--     --   end,
--     -- })
--     -- require("ufo").setup()
--   end,
-- },
-- {
--   "romgrk/kirby.nvim",
--   enabled = true,
--   dependencies = {
--     { "romgrk/fzy-lua-native", build = "make all" },
--     { "romgrk/kui.nvim" },
--     { "nvim-tree/nvim-web-devicons" },
--     { "nvim-lua/plenary.nvim" },
--   },
-- },
-- { "ggml-org/llama.vim", lazy = false, enabled = true },
-- { "dasupradyumna/midnight.nvim", lazy = false, priority = 1000 },
-- { "saforem2/glitz", lazy = false, enabled = true },
-- {
--   "AntonVanAssche/md-headers.nvim",
--   version = "*",
--   lazy = false,
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     -- 'nvim-treesitter/nvim-treesitter',
--   },
--   config = function()
--     require("md-headers").setup({
--       width = 60,
--       height = 10,
--       borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
--       popup_auto_close = true,
--     })
--   end,
-- },
--   {
--   "preservim/vim-markdown",
--   branch = "master",
--   dependencies = { "godlygeek/tabular" },
--   ft = { "markdown", "quarto" },
--   config = function()
--     vim.cmd("nmap ]v <Plug>Markdown_MoveToNextHeader")
--     vim.cmd("nmap [v <Plug>Markdown_MoveToPreviousHeader")
--   end,
-- },

-- {
--   "preservim/vim-markdown",
--   branch = "master",
--   dependencies = { "godlygeek/tabular" },
--   ft = { "markdown", "quarto" },
--   config = function()
--     vim.cmd("nmap ]v <Plug>Markdown_MoveToNextHeader")
--     vim.cmd("nmap [v <Plug>Markdown_MoveToPreviousHeader")
--   end,
-- },

-- color html colors
-- {
--   "NvChad/nvim-colorizer.lua",
--   enabled = true,
--   opts = {
--     filetypes = { "*" },
--     user_default_options = {
--       RGB = true, -- #RGB hex codes
--       RRGGBB = true, -- #RRGGBB hex codes
--       names = true, -- "Name" codes like Blue or blue
--       RRGGBBAA = true, -- #RRGGBBAA hex codes
--       AARRGGBB = false, -- 0xAARRGGBB hex codes
--       rgb_fn = true, -- CSS rgb() and rgba() functions
--       hsl_fn = true, -- CSS hsl() and hsla() functions
--       css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
--       css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
--       -- Available modes for `mode`: foreground, background,  virtualtext
--       mode = "both", -- Set the display mode.
--       -- Available methods are false / true / "normal" / "lsp" / "both"
--       -- True is same as normal
--       tailwind = true, -- Enable tailwind colors
--       -- parsers can contain values used in |user_default_options|
--       sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
--       virtualtext = "■",
--       -- update color values even if buffer is not focused
--       -- example use: cmp_menu, cmp_docs
--       always_update = true,
--       -- all the sub-options of filetypes apply to buftypes
--     },
--     buftypes = {},
--   },
-- },
--
