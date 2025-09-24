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
  -- { "p00f/nvim-ts-rainbow", lazy = false, enabled = true },
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
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      -- require("rainbow-delimiters.setup").setup({})
      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
          strategy = {
              [''] = 'rainbow-delimiters.strategy.global',
              vim = 'rainbow-delimiters.strategy.local',
          },
          query = {
              [''] = 'rainbow-delimiters',
              lua = 'rainbow-blocks',
          },
          priority = {
              [''] = 110,
              lua = 210,
          },
          highlight = {
              'RainbowDelimiterRed',
              'RainbowDelimiterYellow',
              'RainbowDelimiterBlue',
              'RainbowDelimiterOrange',
              'RainbowDelimiterGreen',
              'RainbowDelimiterViolet',
              'RainbowDelimiterCyan',
          },
      }
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
