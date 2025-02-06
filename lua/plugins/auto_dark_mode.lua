-- return {}
return {
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd("colorscheme cyberdream")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd("colorscheme bluoco-light")
        vim.cmd("TSEnable highlight")
        vim.cmd("syntax enable")
        vim.cmd([[
            highlight @variable.member guifg=#EA76CB
            highlight @string.documentation.python guifg=#cccccc
            highlight @string guifg=#FF5722
            ]])
      end,
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
