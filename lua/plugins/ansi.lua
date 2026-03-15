return {
  {
    "0xferrous/ansi.nvim",
    config = function()
      require("ansi").setup({
        auto_enable = false, -- Auto-enable for configured filetypes
        filetypes = { "log", "ansi" }, -- Filetypes to auto-enable
      })
    end,
  },
  -- {
  --   "m00qek/baleia.nvim",
  --   version = "*",
  --   config = function()
  --     vim.g.baleia = require("baleia").setup({})
  --
  --     -- Command to colorize the current buffer
  --     vim.api.nvim_create_user_command("BaleiaColorize", function()
  --       vim.g.baleia.once(vim.api.nvim_get_current_buf())
  --     end, { bang = true })
  --
  --     -- Command to show logs
  --     vim.api.nvim_create_user_command("BaleiaLogs", vim.cmd.messages, { bang = true })
  --   end,
  -- },
}
