-- if true then return {} end

return {
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

  -- { "lukas-reinke/indent-blankline.nvim", enabled = false },
  -- { "ellisonleao/glow.nvim", config = true, cmd = "Glow", ft = { "markdown", "quarto" } },
  -- { "nvim-telescope/telescope-file-browser.nvim" },
  -- { "rafcamlet/nvim-luapad" },
  -- { "easymotion/vim-easymotion" },
  -- { "knubie/vim-kitty-navigator" },
  -- { "fladson/vim-kitty" },

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
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
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

  -- {
  --   "Exafunction/codeium.vim",
  --   event = "BufEnter",
  --   config = function()
  --     --   require("codeium").setup({})
  --     vim.g.codeium_disable_bindings = 1
  --     vim.keymap.set("i", "<C-g>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true })
  --     vim.keymap.set("i", "<c-;>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<c-,>", function()
  --       return vim.fn["codeium#CycleCompletions"](-1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<c-x>", function()
  --       return vim.fn["codeium#Clear"]()
  --     end, { expr = true })
  --   end,
  --   -- dependencies = {
  --   --   "nvim-lua/plenary.nvim",
  --   --   "hrsh7th/nvim-cmp",
  --   -- },
  --   -- lazy = false,
  --   -- enabled = true,
  --   -- config = function() require("codeium").setup {} end,
  -- },

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

  -- {
  --   -- "code-stats/code-stats-vim",
  --   "https://gitlab.com/code-stats/code-stats-vim.git",
  --   config = function()
  --     -- REQUIRED: set your API key
  --     -- TODO: Replace with environment variable ??
  --     vim.g["codestats_api_key"] = { os.getenv("CODESTATS_API_KEY") }
  --     -- vim.g['codestats_api_key'] = {os.getenv('CODESTATS_API_KEY')}
  --   end,
  -- },

  -- {
  --   "Exafunction/codeium.vim",
  --   event = "BufEnter",
  --   config = function()
  --     --   require("codeium").setup({})
  --     vim.g.codeium_disable_bindings = 1
  --     vim.keymap.set("i", "<C-g>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true })
  --     -- nvim_set_keymap("i", "<C-g>", "v:lua.codeium#Accept()", { expr = true })
  --     -- vim.keymap.set("i", "<C-g>", function()
  --     -- return vim.fn["codeium#Accept"]()
  --     -- end, { expr = true })
  --     vim.keymap.set("i", "<c-;>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<c-,>", function()
  --       return vim.fn["codeium#CycleCompletions"](-1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<c-x>", function()
  --       return vim.fn["codeium#Clear"]()
  --     end, { expr = true })
  --   end,
  --   -- dependencies = {
  --   --   "nvim-lua/plenary.nvim",
  --   --   "hrsh7th/nvim-cmp",
  --   -- },
  --   -- lazy = false,
  --   -- enabled = true,
  --   -- config = function() require("codeium").setup {} end,
  -- },

  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      --   require("codeium").setup({})
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      -- nvim_set_keymap("i", "<C-g>", "v:lua.codeium#Accept()", { expr = true })
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
}
