return {
  {
    "okuuva/auto-save.nvim",
    version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle", -- optional for lazy loading on command
    keys = {
      { "<leader>n", "<cmd>ASToggle<CR>", desc = "Toggle auto-save" },
    },
    -- event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      condition = function(buf)
        local bufname = vim.api.nvim_buf_get_name(buf)
        if bufname:match("%(proposed%)") or bufname:match("%(NEW FILE") then
          return false
        end
        return true
      end,
    },
  },
}
