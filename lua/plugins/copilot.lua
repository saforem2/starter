return {
  { -- gh copilot
    "zbirenbaum/copilot.lua",
    enabled = true,
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-j>",
            -- accept_word = false,
            -- accept_line = false,
            next = "<C-]>",
            prev = "<C-[>",
            dismiss = "<C-\\>",
          },
        },
        panel = { enabled = false },
      })
    end,
  },
}
