return {
  { "lewis6991/gitsigns.nvim", enabled = true },
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-lualine/lualine.lua", enabled = false },
  {
    "romgrk/barbar.nvim",
    lazy = false,
    enabled = true,
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = true
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      animation = true,
      -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
      -- Valid options are 'left' (the default), 'previous', and 'right'
      focus_on_close = "left",

      -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
      -- hide = { extensions = true, inactive = true },
      hide = { extensions = true },

      -- Disable highlighting alternate buffers
      highlight_alternate = false,

      -- Disable highlighting file icons in inactive buffers
      highlight_inactive_file_icons = false,

      -- Enable highlighting visible buffers
      highlight_visible = false,

      icons = {
        -- Configure the base icons on the bufferline.
        -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
        buffer_index = false,
        buffer_number = false,
        -- button = "",
        -- Enables / disables diagnostic symbols
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
          [vim.diagnostic.severity.WARN] = { enabled = false },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = true },
        },
        gitsigns = {
          added = { enabled = true, icon = "+" },
          changed = { enabled = true, icon = "~" },
          deleted = { enabled = true, icon = "-" },
        },
        filetype = {
          -- Sets the icon's highlight group.
          -- If false, will use nvim-web-devicons colors
          custom_colors = false,

          -- Requires `nvim-web-devicons` if `true`
          enabled = true,
        },
        separator = { left = "▎", right = "" },

        -- If true, add an additional separator at the end of the buffer list
        separator_at_end = true,

        -- Configure the icons on the bufferline when modified or pinned.
        -- Supports all the base icon options.
        modified = { button = "●" },
        pinned = { button = "", filename = true },

        -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
        preset = "powerline",

        -- Configure the icons on the bufferline based on the visibility of a buffer.
        -- Supports all the base icon options, plus `modified` and `pinned`.
        -- alternate = { filetype = { enabled = false } },
        current = { buffer_index = false },
        inactive = { },
        visible = { modified = { buffer_number = false } },
      },
      -- insert_at_start = true,
      -- …etc.
    },
  },
}
