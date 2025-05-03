return {
    -- { "typicode/bg.nvim", lazy = false },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    enabled = true,
    lazy = false,
    config = function()
      require("colorizer").setup({
        filetypes = { "*" }, -- Filetype options.  Accepts table like `user_default_options`
        buftypes = {}, -- Buftype options.  Accepts table like `user_default_options`
        -- Boolean | List of usercommands to enable.  See User commands section.
        user_commands = true, -- Enable all or some usercommands
        lazy_load = false, -- Lazily schedule buffer highlighting setup function
        user_default_options = {
          names = true, -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
          names_opts = { -- options for mutating/filtering names.
            lowercase = true, -- name:lower(), highlight `blue` and `red`
            camelcase = true, -- name, highlight `Blue` and `Red`
            uppercase = false, -- name:upper(), highlight `BLUE` and `RED`
            strip_digits = false, -- ignore names with digits,
            -- highlight `blue` and `red`, but not `blue3` and `red4`
          },
          -- Expects a table of color name to #RRGGBB value pairs.  # is optional
          -- Example: { cool = "#107dac", ["notcool"] = "ee9240" }
          -- Set to false to disable, for example when setting filetype options
          names_custom = false, -- Custom names to be highlighted: table|function|false
          RGB = true, -- #RGB hex codes
          RGBA = true, -- #RGBA hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = true, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS *features*:
          -- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
          tailwind = true, -- Enable tailwind colors
          tailwind_opts = { -- Options for highlighting tailwind names
            update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
          },
          -- parsers can contain values used in `user_default_options`
          sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
          -- Highlighting mode.  'background'|'foreground'|'virtualtext'
          mode = "background", -- Set the display mode
          -- Virtualtext character to use
          virtualtext = "■",
          -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
          virtualtext_inline = false,
          -- Virtualtext highlight mode: 'background'|'foreground'
          virtualtext_mode = "foreground",
          -- update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false,
          -- hooks to invert control of colorizer
          hooks = {
            -- called before line parsing.  Accepts boolean or function that returns boolean
            -- see hooks section below
            disable_line_highlight = false,
          },
        },
      })
    end,
  },
  {
    "linrongbin16/colorbox.nvim",

    -- don't lazy load
    lazy = false,
    -- -- load with highest priority
    -- priority = 1000,
    --
    -- build = function() require("colorbox").update() end,
    -- config = function() require("colorbox").setup() end,
    -- enabled = true,
    -- load with highest priority
    priority = 1000,

    build = function()
      require("colorbox").update()
    end,
    config = function()
      require("colorbox").setup({ filter = false })
    end,
  },
  {
    "CodeGradox/onehalf-lush",
    lazy = false,
    enabled = true,
    -- priority = 1000,
    -- config = function()
    --   vim.api.nvim_set_option("background", "light")
    --   vim.cmd("colorscheme onehalf-lush")
    -- end,
  },

  -- { "navarasu/onedark.nvim.git", name="navarasu-onedark", lazy = false },
  { "saforem2/glitz", lazy = false, enabled = true },
  { "p00f/nvim-ts-rainbow", enabled = true, lazy = false },
  { "NTBBloodbath/doom-one.nvim" },
  { "marko-cerovac/material.nvim" },
  { "sainnhe/sonokai" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "tanvirtin/monokai.nvim" },
  { "folke/lsp-colors.nvim", event = "BufRead" },
  { "brenoprata10/nvim-highlight-colors" },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },
  { "NTBBloodbath/doom-one.nvim" },
  { "marko-cerovac/material.nvim" },
  -- { "sainnhe/sonokai" },
  { "nyoom-engineering/oxocarbon.nvim" },
  -- { "tanvirtin/monokai.nvim" },
  { "yonlu/omni.vim", lazy = false },
  { "rktjmp/lush.nvim" },
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
    "uloco/bluloco.nvim",
    lazy = false,
    enabeld = true,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      require("bluloco").setup({
        -- theme = "onedark",
        italic_comments = true,
        italic_keywords = true,
        italic_functions = false,
        italic_variables = false,
        contrast = true,
        -- dark_sidebar = true,
        -- dark_float = true,
        hide_eob = true,
      })
      -- vim.api.nvim_set_option_value("background", "light", {})
      -- vim.cmd("colorscheme bluoco-light")
      -- vim.cmd("TSEnable highlight")
      -- vim.cmd("syntax enable")
      vim.cmd([[
          highlight @variable.member guifg=#EA76CB
          highlight @string.documentation.python guifg=#cccccc
          highlight @string guifg=#FF5722
          ]])
    end,
  },
  {
    "kjssad/quantum.vim",
    lazy = false,
    enabled = true,
  },
  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    priority = 1000,
    enabled = true,
  },
  {
    "LazyVim/LazyVim",
    -- opts = {
    --   colorscheme = "cyberdream",
    -- },
  },
}
