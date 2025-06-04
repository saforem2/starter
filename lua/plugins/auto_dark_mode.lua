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
            highlight @keyword.import guifg=#00CCFF
            highlight @keyword.conditional guifg=#D69AFF
            highlight BufferCurrent guifg=#eeeeee
            hi RenderMarkdownH1Bg guibg=#442927
            highlight @markup.list.markdown guifg=#118dc3
            hi RenderMarkdownH1 guifg=#FF5252 cterm=bold gui=bold
            hi @markup.heading.1.markdown guifg=#FF5252 cterm=bold gui=bold
            hi RainbowDelimiterRed guifg=#FF8787
            hi String guifg=#99FFA2
            highlight RenderMarkdownH2Bg guibg=#203a26
            highlight RenderMarkdownH2 guifg=#5eff6c cterm=bold gui=bold
            highlight @markup.heading.2.markdown guifg=#5eff6c gui=bold
            highlight RenderMarkdownH3Bg guibg=#202c3c
            highlight RenderMarkdownH3 guifg=#5ea1ff cterm=bold gui=bold 
            highlight @markup.heading.3.markdown guifg=#5ea1ff cterm=bold gui=bold
            highlight RenderMarkdownH4Bg guibg=#2f223c
            highlight RenderMarkdownH4 guifg=#bd5eff cterm=bold gui=bold
            highlight @markup.heading.4.markdown guifg=#bd5eff cterm=bold gui=bold
            highlight RenderMarkdownH5Bg guibg=#333300
            highlight RenderMarkdownH5 guifg=#FFFF00 cterm=bold gui=bold
            highlight @markup.heading.5.markdown guifg=#FFFF00 cterm=bold gui=bold
            highlight RenderMarkdownH6Bg guibg=#383024
            highlight RenderMarkdownH6 guifg=#ffbd5e cterm=bold gui=bold
            highlight @markup.heading.6.markdown guifg=#ffbd5e gui=bold
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
            highlight RenderMarkdownBullet guifg=#e05661
            highlight @markup.list.markdown guifg=#118dc3

            highlight RenderMarkdownH2Bg guibg=#e3eff4
            highlight RenderMarkdownH2 guifg=#118dc3 cterm=bold gui=bold
            highlight @markup.heading.2.markdown guifg=#118dc3

            highlight RenderMarkdownH3Bg guibg=#e4f2e3
            highlight RenderMarkdownH3 guifg=#1da912 cterm=bold gui=bold 
            highlight @markup.heading.3.markdown guifg=#1da912

            highlight RenderMarkdownH4Bg guibg=#f0edf6
            highlight @markup.heading.4.markdown guifg=#9a77cf
            highlight RenderMarkdownH4 cterm=bold gui=bold guifg=#9a77cf


            highlight RenderMarkdownH5Bg guibg=#eaf3f4
            highlight @markup.heading.5.markdown guifg=#56b6c2
            highlight RenderMarkdownH5 guifg=#56b6c2 cterm=bold gui=bold

            highlight RenderMarkdownH6Bg guibg=#ffe7cb
            highlight @markup.heading.6.markdown guifg=#fd971f
            highlight RenderMarkdownH6 cterm=bold gui=bold guifg=#fd971f
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
