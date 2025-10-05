-- if true then
--   return {}
-- end

return {
  {
    "neko-night/nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- { "typicode/bg.nvim", lazy = false },
  -- { "navarasu/onedark.nvim.git", name = "navarasu-onedark", lazy = false },
  -- { "navarasu/onedark.nvim.git", lazy = false, enabled = true },
  -- { "saforem2/glitz", lazy = false, enabled = true },
  { "nyoom-engineering/oxocarbon.nvim" },
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
  -- {
  --   "LazyVim/LazyVim",
  --   -- opts = {
  --   --   colorscheme = "cyberdream",
  --   -- },
  -- },
  -- { "sainnhe/sonokai" },
  -- { "tanvirtin/monokai.nvim" },
  --
  -- { "p00f/nvim-ts-rainbow", enabled = true, lazy = false },
  { "NTBBloodbath/doom-one.nvim" },
  { "marko-cerovac/material.nvim" },
  { "sainnhe/sonokai" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "tanvirtin/monokai.nvim" },
  { "folke/lsp-colors.nvim", event = "BufRead" },
  { "brenoprata10/nvim-highlight-colors" },
  -- {
  --   "HiPhish/rainbow-delimiters.nvim",
  --   config = function()
  --     require("rainbow-delimiters.setup").setup({})
  --   end,
  -- },
  { "NTBBloodbath/doom-one.nvim" },
  { "marko-cerovac/material.nvim" },
  { "yonlu/omni.vim", lazy = false },
  { "rktjmp/lush.nvim" },
  {
    "CodeGradox/onehalf-lush",
    lazy = false,
    enabled = false,
    opts = {},
    -- priority = 1000,
    -- config = function()
    --   vim.api.nvim_set_option("background", "light")
    --   vim.cmd("colorscheme onehalf-lush")
    -- end,
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
}
