return {
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        onelight = {
          constant = {
            fg = "#F92672",
          },
        },
      })
    end,
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      {
        "<leader>v",
        function()
          require("oklch-color-picker").pick_under_cursor()
        end,
        desc = "Color pick under cursor",
      },
    },
    ---@type oklch.Opts
    opts = {
      highlight = {
        enabled = true,
        edit_delay = 60,
        scroll_delay = 0,
        style = "background",
        bold = false,
        italic = false,
        virtual_text = "■ ",
        priority = 175,
        ignore_ft = { "blink-cmp-menu" },
      },
    },
  },
  {
    "folke/lsp-colors.nvim",
    event = "BufReadPost",
  },
}
