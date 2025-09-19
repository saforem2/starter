return {
  { "machakann/vim-sandwich" },
  { "vim-python/python-syntax" },
  { "Vimjas/vim-python-pep8-indent" },
  {
    "tridactyl/vim-tridactyl",
    enabled = true,
    event = "VeryLazy",
  },
  { "knubie/vim-kitty-navigator" },
  { "fladson/vim-kitty", lazy = false, enabled = true },
  { "Bekaboo/deadcolumn.nvim", lazy = false, enabled = true },
  { "p00f/nvim-ts-rainbow", lazy = false, enabled = true },
  { "wakatime/vim-wakatime", lazy = false },
  { "jghauser/mkdir.nvim" },
  { "rktjmp/lush.nvim", lazy = false, enabled = true },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinLeave" },
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },
  { -- gh copilot
    "zbirenbaum/copilot.lua",
    enabled = true,
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-j>",
            -- accept_word = false,
            -- accept_line = false,
            next = "<C-]>",
            prev = "<C-[>",
            dismiss = "<C-\\>",
          },
        },
        panel = { enabled = false },
      })
    end,
  },
  {
    "OXY2DEV/ui.nvim",
    lazy = false,
    enabled = false,
    config = function()
      require("ui").setup({
        popupmenu = {
          enable = true,

          winconfig = {},
          tooltip = nil,

          styles = {
            default = {
              padding_left = " ",
              padding_right = " ",

              icon = nil,
              text = nil,

              normal_hl = nil,
              select_hl = "CursorLine",
              icon_hl = nil,
            },

            example = {
              condition = function()
                return true
              end,

              icon = "I ",
            },
          },
        },

        cmdline = {
          enable = true,

          styles = {
            default = {
              cursor = "Cursor",
              filetype = "vim",

              icon = { { "I ", "@comment" } },
              offset = 0,

              title = nil,
              winhl = "",
            },

            example = {
              condition = function()
                return true
              end,

              cursor = "@comment",
            },
          },
        },

        message = {
          enable = true,

          message_winconfig = {},
          list_winconfig = {},
          confirm_winconfig = {},
          history_winconfig = {},

          ignore = function()
            return false
          end,

          showcmd = {
            max_width = 10,
            modifier = nil,
          },

          msg_styles = {
            default = {
              duration = 1000,

              modifier = nil,
              decorations = {
                icon = { { "I " } },
              },
            },

            example = {
              condition = function()
                return true
              end,

              decorations = {
                icon = { { "B " } },
              },
            },
          },

          is_list = function()
            return false
          end,

          list_styles = {
            default = {
              modifier = nil,

              row = nil,
              col = nil,

              width = nil,
              height = nil,

              winhl = nil,
            },

            example = {
              condition = function()
                return true
              end,

              border = "rounded",
            },
          },
          confirm_styles = {
            default = {
              modifier = nil,

              row = nil,
              col = nil,

              width = nil,
              height = nil,

              winhl = nil,
            },

            example = {
              condition = function()
                return true
              end,

              border = "rounded",
            },
          },
        },
      })
    end,
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
            icon = "<U+F188> ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = "<U+F00C> ", color = "info" },
          HACK = { icon = "<U+F490> ", color = "warning" },
          WARN = { icon = "<U+F071> ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = "<U+F43A> ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = "<U+EA74> ", color = "hint", alt = { "INFO" } },
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
          keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding cha racters, wide_fg acts accordingly but with fg)
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
}
