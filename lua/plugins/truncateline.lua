return {
  {
    "rlychrisg/truncateline.nvim",
    -- NOTE: these keybinds are not set by default and will need to be set
    -- either here, or wherever you set your keybinds.
    -- map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)
    keys = {
      {
        "<leader>uX",
        ":TemporaryToggle<CR>",
        { noremap = true, silent = true, desc = "TruncateLine temporary toggle" },
      },

      {
        "<leader>ux",
        ":ToggleTruncate<CR>",
        { noremap = true, silent = true, desc = "TruncateLine toggle" },
      },
    },
    opts = {
      enabled_on_start = true,

      -- this will be appended to the virtual text to distinguish it from the actual text
      -- to disable this behaviour, set truncate_str to ""
      truncate_str = "...",

      -- how many characters from the start of the line should be displayed
      -- Note: you might want the total of this setting,
      -- along with truncate_str, to be less than your sidescrolloff
      -- setting, to prevent obscuring text.
      line_start_length = 8,

      -- time for in ms for a temporary toggle
      temporary_toggle_dur = 2000,

      -- which highlight group should be used for virtual text.
      -- "Comment", or "Normal" are good choices, but anything in
      -- :highlight can be used. you can also create your own and
      -- set the colour in your colour scheme's config.
      hilight_group = "Comment",
    },
  },
}
