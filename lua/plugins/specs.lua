if true then
  return {}
end

return {
  {
    "edluffy/specs.nvim",
    lazy = false,
    enabled = true,
    config = function()
      require("specs").setup({
        show_jumps = true,
        min_jump = 30,
        popup = {
          delay_ms = 0, -- delay before popup displays
          inc_ms = 10, -- time increments used for fade/resize effects
          blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
          width = 10,
          height = 10,
          winhl = "Pmenu",
          fader = require("specs").linear_fader,
          resizer = require("specs").shrink_resizer,
        },
        ignore_filetypes = {},
        ignore_buftypes = { nofile = true },
      })
    end,
  },
}
