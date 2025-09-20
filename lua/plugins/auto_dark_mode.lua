-- highlight BufferDefaultCurrent guibg=none
-- highlight BufferDefaultCurrentADDED guibg=none guifg=
-- highlight BufferDefaultCurrentCHANGED guibg=none
-- highlight BufferDefaultCurrentDELTED guibg=none
-- highlight BufferDefaultCurrentERROR guibg=none
-- highlight BufferDefaultCurrentHINT guibg=none
-- highlight BufferDefaultCurrentINFO guibg=none
-- highlight BufferDefaultCurrentIndex guibg=none
-- highlight BufferDefaultCurrentMod guibg=none
-- highlight BufferDefaultCurrentSign guibg=none
-- highlight BufferDefaultCurrentTarget guibg=none
-- highlight BufferDefaultCurrentWarn guibg=none
-- highlight BufferCurrentChanged guibg=none
-- highlight BufferCurrentDeleted guibg=none
-- highlight BufferCurrentAdded guibg=none
-- highlight FlashCursor guibg=none
-- highlight FlashLabel guibg=none
-- highlight NoiceCursor guibg=none
-- hi TabLineSel guibg=none
-- hi TermCursor guibg=none
-- -- return {}
return {
  {
    "f-person/auto-dark-mode.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter"
    },
    enabled = true,
    lazy = false,
    -- opts = {
    config = function()
      require("auto-dark-mode").setup({
        set_dark_mode = function()
          vim.api.nvim_set_option_value("background", "dark", {})
          vim.cmd("colorscheme cyberdream")
          local highlight = vim.api.nvim_set_hl
            highlight(0, "Normal", { bg = "#1c1c1c" })
            highlight(0, "@keyword.import", { fg = "#00CCFF" })
            highlight(0, "@keyword.conditional", { fg = "#D69AFF" })
            highlight(0, "BufferCurrent", { fg = "#eeeeee" })
            highlight(0, "RenderMarkdownH1Bg", { bg = "#442927" })
            highlight(0, "@markup.list.markdown", { fg = "#118dc3" })
            highlight(0, "RenderMarkdownH1", { fg = "#FF5252", bold = true })
            highlight(0, "@markup.heading.1.markdown", { fg = "#FF5252", bold = true })
            highlight(0, "RainbowDelimiterRed", { fg = "#FF8787" })
            highlight(0, "String", { fg = "#99FFA2" })
            highlight(0, "RenderMarkdownH2Bg", { bg = "#203a26" })
            highlight(0, "RenderMarkdownH2", { fg = "#5eff6c", bold = true })
            highlight(0, "@markup.heading.2.markdown", { fg = "#5eff6c", bold = true })
            highlight(0, "RenderMarkdownH3Bg", { bg = "#202c3c" })
            highlight(0, "RenderMarkdownH3", { fg = "#5ea1ff", bold = true })
            highlight(0, "@markup.heading.3.markdown", { fg = "#5ea1ff", bold = true })
            highlight(0, "RenderMarkdownH4Bg", { bg = "#2f223c" })
            highlight(0, "RenderMarkdownH4", { fg = "#bd5eff", bold = true })
            highlight(0, "@markup.heading.4.markdown", { fg = "#bd5eff", bold = true })
            highlight(0, "RenderMarkdownH5Bg", { bg = "#333300" })
            highlight(0, "RenderMarkdownH5", { fg = "#FFFF00", bold = true })
            highlight(0, "@markup.heading.5.markdown", { fg = "#FFFF00", bold = true })
            highlight(0, "RenderMarkdownH6Bg", { bg = "#383024" })
            highlight(0, "RenderMarkdownH6", { fg = "#ffbd5e", bold = true })
            highlight(0, "@markup.heading.6.markdown", { fg = "#ffbd5e", bold = true })
            highlight(0, "BufferDefaultCurrent", { bg = "none" })
            highlight(0, "BufferDefaultCurrentADDED", { bg = "none" })
            highlight(0, "BufferDefaultCurrentCHANGED", { bg = "none" })
            highlight(0, "BufferDefaultDELETED", { bg = "none" })
            highlight(0, "BufferDefaultCurrentERROR", { bg = "none" })
            highlight(0, "BufferDefaultCurrentHINT", { bg = "none" })
            highlight(0, "BufferDefaultCurrentINFO", { bg = "none" })
            highlight(0, "BufferDefaultCurrentIndex", { bg = "none" })
            highlight(0, "BufferDefaultCurrentMod", { bg = "none" })
            highlight(0, "BufferDefaultCurrentSign", { bg = "none" })
            highlight(0, "BufferDefaultCurrentTarget", { bg = "none" })
            highlight(0, "BufferDefaultCurrentWarn", { bg = "none" })
            highlight(0, "BufferDefaultCurrentChanged", { bg = "none" })
            highlight(0, "BufferDefaultCurrentDeleted", { bg = "none" })
            highlight(0, "BufferDefaultCurrentAdded", { bg = "none" })
            highlight(0, "FlashCursor", { bg = "none" })
            highlight(0, "NoiceCursor", { bg = "none" })
            highlight(0, "TabLineSel",  { bg = "none" })
            highlight(0, "TermCursor", { bg = "none" })
            highlight(0, "BufferDefaultCurrentCHANGED", { bg = "none" })
          -- vim.cmd([[
          --   highlight @keyword.import guifg=#00CCFF
          --   highlight @keyword.conditional guifg=#D69AFF
          --   highlight BufferCurrent guifg=#eeeeee
          --   hi RenderMarkdownH1Bg guibg=#442927
          --   highlight @markup.list.markdown guifg=#118dc3
          --   hi RenderMarkdownH1 guifg=#FF5252 cterm=bold gui=bold
          --   hi @markup.heading.1.markdown guifg=#FF5252 cterm=bold gui=bold
          --   hi RainbowDelimiterRed guifg=#FF8787
          --   hi String guifg=#99FFA2
          --   highlight RenderMarkdownH2Bg guibg=#203a26
          --   highlight RenderMarkdownH2 guifg=#5eff6c cterm=bold gui=bold
          --   highlight @markup.heading.2.markdown guifg=#5eff6c gui=bold
          --   highlight RenderMarkdownH3Bg guibg=#202c3c
          --   highlight RenderMarkdownH3 guifg=#5ea1ff cterm=bold gui=bold 
          --   highlight @markup.heading.3.markdown guifg=#5ea1ff cterm=bold gui=bold
          --   highlight RenderMarkdownH4Bg guibg=#2f223c
          --   highlight RenderMarkdownH4 guifg=#bd5eff cterm=bold gui=bold
          --   highlight @markup.heading.4.markdown guifg=#bd5eff cterm=bold gui=bold
          --   highlight RenderMarkdownH5Bg guibg=#333300
          --   highlight RenderMarkdownH5 guifg=#FFFF00 cterm=bold gui=bold
          --   highlight @markup.heading.5.markdown guifg=#FFFF00 cterm=bold gui=bold
          --   highlight RenderMarkdownH6Bg guibg=#383024
          --   highlight RenderMarkdownH6 guifg=#ffbd5e cterm=bold gui=bold
          --   highlight @markup.heading.6.markdown guifg=#ffbd5e gui=bold
          -- ]])
        end,
        set_light_mode = function()
          vim.api.nvim_set_option_value("background", "light", {})
          vim.cmd("colorscheme onelight")
	  -- vim.cmd("TSEnable highlight")
          vim.cmd("syntax enable")
          -- " highlight @string guifg=#F8FCDC guibg=#F8FCDC
          -- replace vim.cmd with lua equiv
          local highlight = vim.api.nvim_set_hl
            highlight(0, "Normal", { bg = "#FFFFFF" })
            highlight(0, "@variable.member", { fg = "#EA76CB" })
            highlight(0, "@string", { fg = "#FD971F", bg = "none" })
            highlight(0, "@function.builtin", { fg = "#1da912" })
            highlight(0, "@string.documentation.python", { bg = "#FFFFFF", fg = "#757575" })
            highlight(0, "@variable", { fg = "#444444" })
            highlight(0, "semshiImported", { fg = "#05A551" })
            highlight(0, "@module", { fg = "#01A9F4" })
            highlight(0, "@function.call", { fg = "#EC407A" })
            highlight(0, "BufferCurrent", { fg = "#111111" })
            highlight(0, "RenderMarkdownBullet", { fg = "#e05661" })
            highlight(0, "@markup.list.markdown", { fg = "#118dc3" })
            highlight(0, "RenderMarkdownH2Bg", { bg = "#e3eff4" })
            highlight(0, "RenderMarkdownH2", { fg = "#118dc3", bold = true })
            highlight(0, "@markup.heading.2.markdown", { fg = "#118dc3" })
            highlight(0, "RenderMarkdownH3Bg", { bg = "#e4f2e3" })
            highlight(0, "RenderMarkdownH3", { fg = "#1da912", bold = true })
            highlight(0, "@markup.heading.3.markdown", { fg = "#1da912" })
            highlight(0, "RenderMarkdownH4Bg", { bg = "#f0edf6" })
            highlight(0, "@markup.heading.4.markdown", { fg = "#9a77cf" })
            highlight(0, "RenderMarkdownH4", { fg = "#9a77cf", bold = true })
            highlight(0, "RenderMarkdownH5Bg", { bg = "#eaf3f4" })
            highlight(0, "@markup.heading.5.markdown", { fg = "#56b6c2" })
            highlight(0, "RenderMarkdownH5", { fg = "#56b6c2", bold = true })
            highlight(0, "RenderMarkdownH6Bg", { bg = "#ffe7cb" })
            highlight(0, "@markup.heading.6.markdown", { fg = "#fd971f" })
            highlight(0, "RenderMarkdownH6", { fg = "#fd971f", bold = true })
          -- vim.cmd([[
          --   highlight Normal guibg=#FFFFFF
          --   highlight @variable.member guifg=#EA76CB
          --   " highlight @string guifg=#FD971F guibg=#FFE7CB
          --   highlight @string guifg=#FD971F guibg=none
          --   highlight @function.builtin guifg=#1da912
          --   highlight @string.documentation.python guibg=#FFFFFF guifg=#757575
          --   highlight @variable guifg=#444444
          --   highlight semshiImported guifg=#05A551
          --   highlight @module guifg=#01A9F4
          --   highlight @function.call guifg=#EC407A
          --   " highlight @string.documentation.python guifg=#cccccc
          --   " highlight @string guifg=#FF5722
          --   " highlight @string.documentation.python guifg=#cccccc
          --   " highlight @string guifg=#FF5722
          --   highlight BufferCurrent guifg=#111111
          --   highlight RenderMarkdownBullet guifg=#e05661
          --   highlight @markup.list.markdown guifg=#118dc3
          --
          --   highlight RenderMarkdownH2Bg guibg=#e3eff4
          --   highlight RenderMarkdownH2 guifg=#118dc3 cterm=bold gui=bold
          --   highlight @markup.heading.2.markdown guifg=#118dc3
          --
          --   highlight RenderMarkdownH3Bg guibg=#e4f2e3
          --   highlight RenderMarkdownH3 guifg=#1da912 cterm=bold gui=bold 
          --   highlight @markup.heading.3.markdown guifg=#1da912
          --
          --   highlight RenderMarkdownH4Bg guibg=#f0edf6
          --   highlight @markup.heading.4.markdown guifg=#9a77cf
          --   highlight RenderMarkdownH4 cterm=bold gui=bold guifg=#9a77cf
          --
          --
          --   highlight RenderMarkdownH5Bg guibg=#eaf3f4
          --   highlight @markup.heading.5.markdown guifg=#56b6c2
          --   highlight RenderMarkdownH5 guifg=#56b6c2 cterm=bold gui=bold
          --
          --   highlight RenderMarkdownH6Bg guibg=#ffe7cb
          --   highlight @markup.heading.6.markdown guifg=#fd971f
          --   highlight RenderMarkdownH6 cterm=bold gui=bold guifg=#fd971f
          --   ]])
        end,
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        fallback = "light",
      })
    end,
  },
}
