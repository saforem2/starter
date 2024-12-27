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
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    enabled = true,
    name = "github-theme",
    config = function()
      -- Default options
      require("github-theme").setup({
        options = {
          -- Compiled file's destination location
          compile_path = vim.fn.stdpath("cache") .. "/github-theme",
          compile_file_suffix = "_compiled", -- Compiled file suffix
          hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
          hide_nc_statusline = true, -- Override the underline style for non-active statuslines
          transparent = false, -- Disable setting bg (make neovim's background transparent)
          terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false, -- Non focused panes set to alternative background
          module_default = true, -- Default enable value for modules
          styles = { -- Style to be applied to different syntax groups
            comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
            functions = "NONE",
            keywords = "NONE",
            variables = "NONE",
            conditionals = "NONE",
            constants = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
          },
          inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          darken = { -- Darken floating windows and sidebar-like windows
            floats = true,
            sidebars = {
              enable = true,
              list = {}, -- Apply dark background to specific windows
            },
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })

      -- setup must be called before loading
      -- vim.cmd("colorscheme github_dark")
    end,
  },

  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },

  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown", "quarto" },
    config = function()
      require("mkdnflow").setup({
        mappings = {
          MkdnFoldSection = { "n", "<leader>k" },
          MkdnUnfoldSection = { "n", "<leader>K" },
        },
        -- SAMPLE FOLDTEXT CONFIGURATION RECIPE WITH COMMENTS
        -- Other config options
        foldtext = {
          title_transformer = function()
            local function my_title_transformer(text)
              local updated_title = text:gsub("%b{}", "")
              updated_title = updated_title:gsub("^%s*", "")
              updated_title = updated_title:gsub("%s*$", "")
              -- updated_title = updated_title:gsub("^######", "░░░░░▓")
              -- updated_title = updated_title:gsub("^#####", "░░░░▓▓")
              -- updated_title = updated_title:gsub("^####", "░░░▓▓▓")
              -- updated_title = updated_title:gsub("^###", "░░▓▓▓▓")
              -- updated_title = updated_title:gsub("^##", "░▓▓▓▓▓")
              -- updated_title = updated_title:gsub("^#", "▓▓▓▓▓▓")
              -- updated_title = updated_title:gsub("^######", "󰲫 ")
              -- updated_title = updated_title:gsub("^#####", "󰲩 ")
              -- updated_title = updated_title:gsub("^####", "󰲧 ")
              -- updated_title = updated_title:gsub("^###", "󰲥 ")
              -- updated_title = updated_title:gsub("^##", "󰲣 ")
              -- updated_title = updated_title:gsub("^#", "󰲡 ")
              updated_title = updated_title:gsub("^######", "######")
              updated_title = updated_title:gsub("^#####", "#####")
              updated_title = updated_title:gsub("^####", "####")
              updated_title = updated_title:gsub("^###", "###")
              updated_title = updated_title:gsub("^##", "##")
              updated_title = updated_title:gsub("^#", "#")
              return updated_title
            end
            return my_title_transformer
          end,
          object_count_icon_set = "nerdfont", -- Use/fall back on the nerdfont icon set
          object_count_opts = function()
            local opts = {
              link = false, -- Prevent links from being counted
              blockquote = { -- Count block quotes (these aren't counted by default)
                icon = " ",
                count_method = {
                  pattern = { "^>.+$" },
                  tally = "blocks",
                },
              },
              fncblk = {
                -- Override the icon for fenced code blocks with 
                icon = " ",
              },
            }
            return opts
          end,
          line_count = false, -- Prevent lines from being counted
          word_count = true, -- Count the words in the section
          fill_chars = {
            left_edge = "╾────",
            right_edge = "───",
            item_separator = " · ",
            section_separator = " // ",
            left_inside = " ┝",
            right_inside = "┥ ",
            middle = "─",
          },
        },
      })
    end,
  },

  { "github/copilot.vim", lazy = false, enabled = true },
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
  { "lyokha/vim-publish-helper", lazy = false, enabled = true },
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
  { "vim-pandoc/vim-pandoc-syntax", lazy = false, filetypes = { "markdown", "vimwiki", "quarto" } },
  { "Bekaboo/deadcolumn.nvim", lazy = false, enabled = true },
  -- { "saforem2/glitz", lazy = false, enabled = true },
  { "p00f/nvim-ts-rainbow" },
  { "NTBBloodbath/doom-one.nvim" },
  { "marko-cerovac/material.nvim" },
  -- { "sainnhe/sonokai" },
  { "nyoom-engineering/oxocarbon.nvim" },
  -- { "tanvirtin/monokai.nvim" },
  { "yonlu/omni.vim", lazy = false },
  { "wakatime/vim-wakatime", lazy = false },
  { "mbbill/undotree" },
  { "machakann/vim-sandwich" },
  { "rktjmp/lush.nvim" },
  { "vim-python/python-syntax" },
  { "Vimjas/vim-python-pep8-indent" },
  { "rafcamlet/nvim-luapad" },
  { "tpope/vim-repeat" },
  { "easymotion/vim-easymotion" },
  { "lervag/vimtex" },
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  { "knubie/vim-kitty-navigator" },
  { "fladson/vim-kitty" },
  {
    "AntonVanAssche/md-headers.nvim",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- 'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require("md-headers").setup({
        width = 60,
        height = 10,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        popup_auto_close = true,
      })
    end,
  },
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
  { "lukas-reinke/indent-blankline.nvim", enabled = false },
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
  { "folke/lsp-colors.nvim", event = "BufRead" },
  { "brenoprata10/nvim-highlight-colors" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "rrethy/vim-illuminate" },
  { "dhruvasagar/vim-table-mode" },
  { "jghauser/mkdir.nvim" },
  { "hkupty/iron.nvim" },
  { "rktjmp/lush.nvim", lazy = false, enabled = true },
  { "bfredl/nvim-ipy" },
  { "ggandor/lightspeed.nvim", event = "BufRead" },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow", ft = { "markdown", "quarto" } },
  { "godlygeek/tabular", enabled = true, lazy = false },
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
  -- { -- install without yarn or npm
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   -- build = function() vim.fn["mkdp#util#install"]() end,
  -- },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    ft = { "markdown", "quarto" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
      {
        "echasnovski/mini.icons",
        version = false,
        config = function()
          require("mini.icons").setup()
        end,
      },
      -- { "echasnovski/mini.icons" },
      {
        "tadmccorkle/markdown.nvim",
        event = "VeryLazy",
        ft = { "markdown", "quarto", "qmd" },
        opts = {
          mappings = {
            inline_surround_toggle = "gs", -- (string|boolean) toggle inline style
            inline_surround_toggle_line = "gss", -- (string|boolean) line-wise toggle inline style
            inline_surround_delete = "ds", -- (string|boolean) delete emphasis surrounding cursor
            inline_surround_change = "cs", -- (string|boolean) change emphasis surrounding cursor
            link_add = "gl", -- (string|boolean) add link
            link_follow = "gx", -- (string|boolean) follow link
            go_curr_heading = "]c", -- (string|boolean) set cursor to current section heading
            go_parent_heading = "]p", -- (string|boolean) set cursor to parent section heading
            go_next_heading = "]]", -- (string|boolean) set cursor to next section heading
            go_prev_heading = "[[", -- (string|boolean) set cursor to previous section heading
          },
        },
      },
    },
    config = function()
      require("render-markdown").setup({
        enabled = true,
        preset = "obsidian",
        win_options = {
          conceallevel = {
            -- Used when not being rendered, get user setting
            default = 0,
            -- default = vim.api.nvim_get_option_value("conceallevel", { 2 }),
            -- Used when being rendered, concealed text is completely hidden
            rendered = 2,
          },
        },
        file_types = {
          "markdown",
          "quarto",
        },
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
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
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
    "turbio/bracey.vim",
    cmd = { "Bracey", "BraceyStop", "BraceyReload", "BraceyEval" },
    run = "npm install --prefix server",
  },

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
  {
    "quarto-dev/quarto-nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "jmbuhr/otter.nvim",
    },
  },
  {
    "projekt0n/circles.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
  },
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
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      --   require("codeium").setup({})
      vim.g.codeium_disable_bindings = 1
      nvim_set_keymap("i", "<C-g>", "v:lua.codeium#Accept()", { expr = true })
      -- vim.keymap.set("i", "<C-g>", function()
      -- return vim.fn["codeium#Accept"]()
      -- end, { expr = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
    -- dependencies = {
    --   "nvim-lua/plenary.nvim",
    --   "hrsh7th/nvim-cmp",
    -- },
    -- lazy = false,
    -- enabled = true,
    -- config = function() require("codeium").setup {} end,
  },
  {
    -- "code-stats/code-stats-vim",
    "https://gitlab.com/code-stats/code-stats-vim.git",
    config = function()
      -- REQUIRED: set your API key
      -- TODO: Replace with environment variable ??
      vim.g["codestats_api_key"] = { os.getenv("CODESTATS_API_KEY") }
      -- vim.g['codestats_api_key'] = {os.getenv('CODESTATS_API_KEY')}
    end,
  },

  -- color html colors
  {
    "NvChad/nvim-colorizer.lua",
    enabled = true,
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "both", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true, -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
        virtualtext = "■",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = true,
        -- all the sub-options of filetypes apply to buftypes
      },
      buftypes = {},
    },
  },
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
    "AntonVanAssche/md-headers.nvim",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("md-headers").setup({
        width = 60,
        height = 10,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        popup_auto_close = true,
      })
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
  -- { "navarasu/onedark.nvim.git", name="navarasu-onedark", lazy = false },
  { "saforem2/glitz", lazy = false, enabled = true },
  { "p00f/nvim-ts-rainbow" },

  { "NTBBloodbath/doom-one.nvim" },
  { "marko-cerovac/material.nvim" },
  { "sainnhe/sonokai" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "tanvirtin/monokai.nvim" },
  { "wakatime/vim-wakatime" },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },

  -- {
  --   "toppair/peek.nvim",
  --   event = { "VeryLazy" },
  --   build = "deno task --quiet build:fast",
  --   config = function()
  --     require("peek").setup()
  --     vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  --     vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  --   end,
  -- },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {
      heading = {
        -- Turn on / off heading icon & background rendering
        enabled = true,
        -- Turn on / off any sign column related rendering
        sign = false,
        -- Determines how icons fill the available space:
        --  inline:  underlying '#'s are concealed resulting in a left aligned icon
        --  overlay: result is left padded with spaces to hide any additional '#'
        position = "inline",
        -- Replaces '#+' of 'atx_h._marker'
        -- The number of '#' in the heading determines the 'level'
        -- The 'level' is used to index into the array using a cycle
        -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- icons = { "1️⃣ ", "2️⃣ ", "3️⃣ ", "4️⃣ ", "5️⃣ ", "6️⃣ " }, -- {
        -- Added to the sign column if enabled
        -- The 'level' is used to index into the array using a cycle
        signs = { "󰫎 " },
        -- signs = { "" },
        -- Width of the heading background:
        --  block: width of the heading text
        --  full:  full width of the window
        -- Can also be an array of the above values in which case the 'level' is used
        -- to index into the array using a clamp
        width = "block",
        -- Amount of padding to add to the left of headings
        left_pad = 0,
        -- Amount of padding to add to the right of headings when width is 'block'
        right_pad = 0,
        -- Minimum width to use for headings when width is 'block'
        min_width = 0,
        -- Determins if a border is added above and below headings
        border = false,
        -- Highlight the start of the border using the foreground highlight
        border_prefix = true,
        -- Used above heading for border
        above = "▄",
        -- Used below heading for border
        below = "▀",
        -- The 'level' is used to index into the array using a clamp
        -- Highlight for the heading icon and extends through the entire line
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        -- The 'level' is used to index into the array using a clamp
        -- Highlight for the heading and sign icons
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
      },
    },
    code = {
      -- Turn on / off code block & inline code rendering
      enabled = true,
      -- Turn on / off any sign column related rendering
      sign = false,
      -- Determines how code blocks & inline code are rendered:
      --  none:     disables all rendering
      --  normal:   adds highlight group to code blocks & inline code, adds padding to code blocks
      --  language: adds language icon to sign column if enabled and icon + name above code blocks
      --  full:     normal + language
      style = "full",
      -- Determines where language icon is rendered:
      --  right: right side of code block
      --  left:  left side of code block
      position = "right",
      -- Amount of padding to add around the language
      language_pad = 0,
      -- An array of language names for which background highlighting will be disabled
      -- Likely because that language has background highlights itself
      disable_background = { "diff" },
      -- Width of the code block background:
      --  block: width of the code block
      --  full:  full width of the window
      width = "block",
      -- Amount of padding to add to the left of code blocks
      left_pad = 0,
      -- Amount of padding to add to the right of code blocks when width is 'block'
      right_pad = 0,
      -- Minimum width to use for code blocks when width is 'block'
      min_width = 0,
      -- Determins how the top / bottom of code block are rendered:
      --  thick: use the same highlight as the code body
      --  thin:  when lines are empty overlay the above & below icons
      border = "thin",
      -- Used above code blocks for thin border
      above = "▄",
      -- Used below code blocks for thin border
      below = "▀",
      -- Highlight for code blocks
      highlight = "RenderMarkdownCode",
      -- Highlight for inline code
      highlight_inline = "RenderMarkdownCodeInline",
    },
  },

  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      --   require("codeium").setup({})
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
    -- dependencies = {
    --   "nvim-lua/plenary.nvim",
    --   "hrsh7th/nvim-cmp",
    -- },
    -- lazy = false,
    -- enabled = true,
    -- config = function() require("codeium").setup {} end,
  },

  {
    -- "code-stats/code-stats-vim",
    "https://gitlab.com/code-stats/code-stats-vim.git",
    config = function()
      -- REQUIRED: set your API key
      -- TODO: Replace with environment variable ??
      vim.g["codestats_api_key"] = { os.getenv("CODESTATS_API_KEY") }
      -- vim.g['codestats_api_key'] = {os.getenv('CODESTATS_API_KEY')}
    end,
  },
}

-- {
--   "nvim-telescope/telescope-fzf-native.nvim",
--   run = "make",
--   lazy = false,
-- },
-- {
--   "mfussenegger/nvim-dap-python",
--   config = function() require("dap-python").setup "~/.virtualenvs/debugpy/bin/python" end,
-- },
-- { "felipec/vim-sanegx" },
-- { "godlygeek/tabular" },
-- {
--   "ojroques/nvim-osc52"
-- },
-- return {
-- { "navarasu/onedark.nvim.git", name="navarasu-onedark", lazy = false },
-- { "LunarVim/bigfile.nvim" },
-- { "lukas-reineke/onedark.nvim", name="lukas-onedark", lazy=false, enabled = true },
-- { "dstein64/vim-startuptime" },
-- { "rktjmp/shipwright.nvim" },
-- { "navarasu/onedark.nvim", lazy=false, enabled=true },
-- { "navarasu/onedark.nvim" },
-- { "bluz71/vim-nightfly-guicolors" },
-- { "rafamadriz/neon" },
-- { "sainnhe/sonokai" },
-- { "kosayoda/nvim-lightbulb" },
-- { "simrat39/symbols-outline.nvim", cmd = "SymbolsOutline" },
-- { "chaoren/vim-wordmotion" },
-- { "jbyuki/nabla.nvim" },
-- { "HiPhish/nvim-ts-rainbow2" },
-- { "npxbr/glow.nvim", ft = { "markdown", "quarto" } },

-- { "preservim/vim-pencil" },
-- { "lvimuser/lsp-inlayhints.nvim" },
-- { "vim-pandoc/vim-pandoc" },
-- { "vim-pandoc/vim-pandoc-syntax" },

-- {
--   "ray-x/lsp_signature.nvim",
--   event = "BufRead",
--   config = function()
--     require("lsp_signature").setup({
--       bind = true,
--       floating_window = false,
--       hint_enable = true,
--       hint_prefix = " ",
--       hi_parameter = "LspSignatureActiveParameter",
--       -- toggle_key = '<C-s>',
--       handler_opts = {
--         border = "rounded",
--       },
--       always_trigger = true,
--       extra_trigger_chars = { "(", "," },
--       timer_interval = 100,
--     })
--   end,
-- },
-- {
--   "hoschi/yode-nvim",
--   config = function() require("yode-nvim").setup {} end,
-- },

-- {
--   "kdheepak/tabline.nvim",
--   config = function()
--     require("tabline").setup {
--       -- Defaults configuration options
--       enable = true,
--       options = {
--         -- If lualine is installed tabline will use separators configured in lualine by default.
--         -- These options can be used to override those settings.
--         -- section_separators = { '', '' },
--         -- component_separators = { '', '' },
--         max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
--         show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
--         show_devicons = true, -- this shows devicons in buffer section
--         show_bufnr = false, -- this appends [bufnr] to buffer section,
--         show_filename_only = true, -- shows base filename only instead of relative path in filename
--         -- modified_icon = "+ ", -- change the default modified icon
--         modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
--         show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
--       },
--     }
--   end,
-- },

-- {
--   "norcalli/nvim-terminal.lua",
--   config = function() require("terminal").setup() end,
-- },
-- {
--   "norcalli/nvim-terminal.lua",
--   config = function() require("terminal").setup() end,
-- },
-- {
--   "phaazon/hop.nvim",
--   event = "BufRead",
--   config = function()
--     require("hop").setup()
--     vim.api.nvim_set_keymap("n", ";", ":HopChar2<CR>", { silent = true })
--     vim.api.nvim_set_keymap("n", "W", ":HopWord<CR>", { silent = true })
--   end,
-- },
-- {
--   "kevinhwang91/nvim-bqf",
--   event = { "BufRead", "BufNew" },
--   config = function()
--     require("bqf").setup {
--       auto_enable = true,
--       preview = {
--         win_height = 12,
--         win_vheight = 12,
--         delay_syntax = 80,
--         border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
--       },
--       func_map = {
--         vsplit = "",
--         ptogglemode = "z,",
--         stoggleup = "",
--       },
--       filter = {
--         fzf = {
--           action_for = { ["ctrl-s"] = "split" },
--           extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
--         },
--       },
--     }
--   end,
-- },
-- {
--   "rafi/awesome-vim-colorschemes",
-- },
-- {
--   "flazz/vim-colorschemes",
-- },
-- {
--   'NvChad/nvim-colorizer.lua',
--   config = require('colorizer').setup({
--     user_default_options = {
--       RGB      = true;         -- #RGB hex codes
--       RRGGBB   = true;         -- #RRGGBB hex codes
--       names    = true;         -- "Name" codes like Blue
--       RRGGBBAA = true;        -- #RRGGBBAA hex codes
--       rgb_fn   = true;        -- CSS rgb() and rgba() functions
--       hsl_fn   = true;        -- CSS hsl() and hsla() functions
--       css      = true;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
--       css_fn   = true;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
--       -- Available modes: foreground, background
--       mode     = 'virtualtext'; -- Set the display mode.
--       tailwind = true,
--       sass = { enable = true, parsers = {"css"} },
--       virtualtext = "■",
--     },
--   })
-- },
-- {
--   'brenoprata10/nvim-highlight-colors',
--   config = function()
--     require('nvim-highlight-colors').setup({
--       render = 'foreground',
--       enable_named_colors = true,
--       enable_tailwind = true,
--     })
--   end,
-- },
-- {
--   "folke/zen-mode.nvim",
--   config = function()
--     require("zen-mode").setup {
--       window = {
--         backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
--         -- height and width can be:
--         -- * an absolute number of cells when > 1
--         -- * a percentage of the width / height of the editor when <= 1
--         -- * a function that returns the width or the height
--         -- by default, no options are changed for the Zen window
--         -- uncomment any of the options below, or add other vim.wo options you want to apply
--         width = 120, -- width of the Zen window
--         height = 1, -- height of the Zen window
--         options = {
--           -- signcolumn = "no", -- disable signcolumn
--           number = false, -- disable number column
--           relativenumber = false, -- disable relative numbers
--           cursorline = false, -- disable cursorline
--           cursorcolumn = false, -- disable cursor column
--           foldcolumn = "0", -- disable fold column
--           list = false, -- disable whitespace characters
--         },
--       },
--       plugins = {
--         options = {
--           enabled = true,
--           ruler = false, -- disables the ruler text in the cmd line area
--           showcmd = false, -- disables the command in the last line of the screen,
--           twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
--           gitsigns = { enabled = false }, -- disables git signs
--           tmux = { enabled = false }, -- disables the tmux statusline this will change the font size on kitty when in zen mode
--           kitty = {
--             enabled = true,
--             font = "+4", -- font size increment
--           },
--         },
--       },
--     }
--   end,
-- },
-- {
--   "johnfrankmorgan/whitespace.nvim",
--   config = function()
--     require('whitespace-nvim').setup({
--       -- configuration options and their defaults `highlight` configures
--       -- which highlight is used to display
--       -- trailing whitespace
--       highlight = 'DiffDelete',
--       -- `ignored_filetypes` configures which filetypes to ignore when
--       -- displaying trailing whitespace
--       ignored_filetypes = { 'TelescopePrompt' },
--       -- remove trailing whitespace with a keybinding
--       vim.api.nvim_set_keymap(
--         'n',
--         '<Leader>t', "[[<cmd>lua require('whitespace-nvim').trim()<CR>]]",
--         { noremap = true }
--       )
--     })
--   end,
-- },
-- { 'Iron-E/nvim-highlite' },
-- {
--   'rrethy/vim-hexokinase',
--   run = 'make hexokinase',
--   config = function()
--     vim.g["Hexokinase_highlighters"] = {
--       'virtual',
--       'sign_column',
--     }
--   end,
-- },
-- {
--   "folke/todo-comments.nvim",
--   lazy = false,
--   -- config = function()
--   --   require('todo-comments.nvim').setup({})
--   -- end
--   -- config = function()
--   -- require("user.todo-comments").config()
--   -- end,
-- },
-- {
--   "luk400/vim-jukit",
--   config = function()
--     -- vim.api.nvim_set_var('jukit#mappings#ext#enabled', {'py', 'ipynb'})
--     vim.g.jukit_mappings_ext_enabled = { "py", "ipynb" }
--     vim.g.jukit_layout = -1
--     -- vim.g['jukit#mappings#ext#enabled'] = {"py", "ipynb"}
--     -- g.jukit_mappings_ext_enabled = {"py", "ipynb"}
--     -- vim.opt.jukit_mappings_ext_enabled = {"py", "ipynb"}
--   end,
-- },
-- { "tomtom/tcomment_vim" },
-- {
--   "Cassin01/wf.nvim",
--   config = function()
--   require('wf').setup()
--   end
-- }

-- {
--   "3rd/image.nvim",
--   -- default config
--   config = function()
--     require("image").setup({
--       backend = "kitty",
--       integrations = {
--         markdown = {
--           enabled = true,
--           clear_in_insert_mode = false,
--           download_remote_images = true,
--           only_render_image_at_cursor = false,
--           filetypes = { "markdown", "vimwiki", "quarto" }, -- markdown extensions (ie. quarto) can go here
--         },
--         neorg = {
--           enabled = true,
--           clear_in_insert_mode = false,
--           download_remote_images = true,
--           only_render_image_at_cursor = false,
--           filetypes = { "norg" },
--         },
--         html = {
--           enabled = false,
--         },
--         css = {
--           enabled = false,
--         },
--       },
--       max_width = nil,
--       max_height = nil,
--       max_width_window_percentage = nil,
--       max_height_window_percentage = 50,
--       window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
--       window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
--       editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
--       tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
--       hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
--     })
--   end,
-- },

-- { -- install without yarn or npm
--   "iamcco/markdown-preview.nvim",
--   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--   ft = { "markdown" },
--   build = function()
--     vim.fn["mkdp#util#install"]()
--   end,
-- },

-- {
--   "MeanderingProgrammer/markdown.nvim",
--   name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
--   ft = { "markdown", "quarto" },
--   dependencies = {
--     { "nvim-treesitter/nvim-treesitter" },
--     {
--       "echasnovski/mini.icons",
--       version = false,
--       config = function()
--         require("mini.icons").setup()
--       end,
--     },
--     -- { "echasnovski/mini.icons" },
--     {
--       "tadmccorkle/markdown.nvim",
--       event = "VeryLazy",
--       ft = { "markdown", "quarto" },
--       opts = {
--         mappings = {
--           inline_surround_toggle = "gs", -- (string|boolean) toggle inline style
--           inline_surround_toggle_line = "gss", -- (string|boolean) line-wise toggle inline style
--           inline_surround_delete = "ds", -- (string|boolean) delete emphasis surrounding cursor
--           inline_surround_change = "cs", -- (string|boolean) change emphasis surrounding cursor
--           link_add = "gl", -- (string|boolean) add link
--           link_follow = "gx", -- (string|boolean) follow link
--           go_curr_heading = "]c", -- (string|boolean) set cursor to current section heading
--           go_parent_heading = "]p", -- (string|boolean) set cursor to parent section heading
--           go_next_heading = "]]", -- (string|boolean) set cursor to next section heading
--           go_prev_heading = "[[", -- (string|boolean) set cursor to previous section heading
--         },
--       },
--     },
--   },
--   config = function()
--     require("render-markdown").setup({
--       win_options = {
--         conceallevel = {
--           -- Used when not being rendered, get user setting
--           default = vim.api.nvim_get_option_value("conceallevel", { 2 }),
--           -- Used when being rendered, concealed text is completely hidden
--           rendered = 2,
--         },
--       },
--       file_types = {
--         "markdown",
--         "quarto",
--       },
--     })
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
--       mode = "virtualtext", -- Set the display mode.
--       -- Available methods are false / true / "normal" / "lsp" / "both"
--       -- True is same as normal
--       tailwind = true, -- Enable tailwind colors
--       -- parsers can contain values used in |user_default_options|
--       -- sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
--       virtualtext = "■",
--       -- update color values even if buffer is not focused
--       -- example use: cmp_menu, cmp_docs
--       always_update = false,
--       -- all the sub-options of filetypes apply to buftypes
--     },
--     buftypes = {},
--   },
-- },
