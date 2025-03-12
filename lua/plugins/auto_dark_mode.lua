-- return {}
return {
  {
    "f-person/auto-dark-mode.nvim",
    enabled = true,
    lazy = false,
    -- opts = {
    config = function()
      require("auto-dark-mode").setup({
        set_dark_mode = function()
          vim.api.nvim_set_option_value("background", "dark", {})
          vim.cmd("colorscheme cyberdream")
          vim.cmd([[
            highlight BufferCurrent guifg=#eeeeee
          ]])
        end,
        set_light_mode = function()
          vim.api.nvim_set_option_value("background", "light", {})
          vim.cmd("colorscheme onelight")
          vim.cmd("TSEnable highlight")
          vim.cmd("syntax enable")
          -- " highlight @string guifg=#F8FCDC guibg=#F8FCDC
          vim.cmd([[
              highlight Normal guibg=#FFFFFF
              highlight @variable.member guifg=#EA76CB
              highlight @string guifg=#FD971F guibg=#FFE7CB
              highlight @string.documentation.python guibg=#FFFFFF guifg=#757575
              highlight @variable guifg=#444444
              highlight semshiImported guifg=#05A551
              highlight @module guifg=#01A9F4
              highlight @function.call guifg=#EC407A
              " highlight @string.documentation.python guifg=#cccccc
              " highlight @string guifg=#FF5722
              " highlight @string.documentation.python guifg=#cccccc
              " highlight @string guifg=#FF5722
              highlight BufferCurrent guifg=#111111
              ]])
        end,
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        fallback = "light",
      })
    end,
  },
}
