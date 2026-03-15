-- For `plugins/markview.lua` users.
return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  enabled = false,

  -- Completion for `blink.cmp`
  dependencies = { "saghen/blink.cmp" },
  config = function()
    require("markview").setup({
      vim.api.nvim_set_keymap(
        "i",
        "<Ctrl-m>",
        "<CMD>Markview HybridToggle<CR>",
        { desc = "Toggles `hybrid mode` globally." }
      ),
      -- Your config here
    })
  end,
}
