-- if true then return {} end

return {
  { "saforem2/glitz", lazy = false, enabled = true },
  { "p00f/nvim-ts-rainbow" },

  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },
  { "NTBBloodbath/doom-one.nvim" },
  { "marko-cerovac/material.nvim" },
  { "sainnhe/sonokai" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "tanvirtin/monokai.nvim" },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },
  { "rktjmp/lush.nvim", lazy = false, enabled = true },
  { "folke/lsp-colors.nvim", event = "BufRead" },
  { "brenoprata10/nvim-highlight-colors" },
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
  -- { "rktjmp/lush.nvim" },
  { "p00f/nvim-ts-rainbow" },
  { "NTBBloodbath/doom-one.nvim" },
  { "marko-cerovac/material.nvim" },
  -- { "sainnhe/sonokai" },
  { "nyoom-engineering/oxocarbon.nvim" },
  -- { "tanvirtin/monokai.nvim" },
  { "yonlu/omni.vim", lazy = false },
  { "lyokha/vim-publish-helper", lazy = false, enabled = true },
  { "vim-pandoc/vim-pandoc-syntax", lazy = false, filetypes = { "markdown", "vimwiki", "quarto" } },
  { "Bekaboo/deadcolumn.nvim", lazy = false, enabled = true },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    priority = 1000,
    enabled = true,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
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
}
