return {
  { "lewis6991/gitsigns.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false,},
  { "nvim-lualine/lualine.lua", enabled = false },
  {
    "romgrk/barbar.nvim",
    lazy = false,
    enabled = true,
    dependencies = {
      -- "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = true
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
  },
}
