-- return {}
-- return {} if true else
--
--
-- M.colors = {
--     red = "#E06C75",
--     dark_red = "#BE5046",
--     diff_red = "#2c1517",
--     green = "#98C379",
--     dark_green = "#59843b",
--     dimm_green = "#41602b",
--     diff_green = "#1e2718",
--     yellow = "#E5C07B",
--     diff_yellow = "#3e2e1e",
--     dark_yellow = "#D19A66",
--     blue = "#61AFEF",
--     dimm_blue = "#0d4c7f",
--     purple = "#C678DD",
--     dimm_purple = "#633c6e",
--     diff_purple = "#27182C",
--     cyan = "#56B6C2",
--     white = "#ABB2BF",
--     black = "#1f1f1f",
--     dimm_black = "#1c1c1c",
--     dark_black = "#1a1a1a",
--     comment_grey = "#5C6370",
--     gutter_fg_grey = "#4B5263",
--     cursor_grey = "#2C323C",
--     dimm_cursor_grey = "#21262d",
--     dark_cursor_grey = "#1d2228",
--     visual_grey = "#3E4452",
--     special_grey = "#3B4048",
--     bracket_grey = "#7C828C",
-- }


return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    enabled = true,
    priority = 1000,
    config = function()
      -- if vim.o.background == 'light' then
      --   vim.cmd("colorscheme bluoco-light")
      -- else
      --   vim.cmd("colorscheme cyberdream")
      -- end
      require("cyberdream").setup({
        -- Add a custom keybinding to toggle the colorscheme
        vim.api.nvim_set_keymap("n", "<leader>tt", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true }),
        -- vim.cmd("colorscheme ".. require('config.keymaps').get_color_scheme()),
        -- Enable transparent background
        transparent = true,
        -- Enable italics comments
        italic_comments = false,

        -- Replace all fillchars with ' ' for the ultimate clean look
        hide_fillchars = false,

        -- Modern borderless telescope theme
        borderless_pickers = true,

        -- Set terminal colors used in `:terminal`
        terminal_colors = true,
        extensions = {
          blinkcmp = true,
          cmp = true,
          fzflua = true,
          lazy = true,
          markdown = true,
          mini = true,
          noice = true,
          rainbow_delimiters = true,
          treesitter = true,
          trouble = true,
          whichkey = true,
        },

        opts = {
          variant = "auto", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`

          highlights = {
            -- Highlight groups to override, adding new groups is also possible
            -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values

            -- Example:
            -- Comment = { fg = "#696969", bg = "NONE", italic = true },
            -- Normal = { fg = "#cccccc" },
            -- sym"@variable" = { fg = ""},
            -- Keyword = { fg = "#ffa94d" },
            -- Normal = { fg = "#cccccc" },
            -- Identifier = { fg = "#eeeeee" },
            CursorLine = { bg = "#252525" },
            -- Complete list can be found in `lua/cyberdream/theme.lua`
          },

          -- Override a highlight group entirely using the color palette
          overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
            -- Example:
            return {
              Keyword = { fg = "#00CCFF" },
              -- Normal = { bg = "#1c1c1c", fg = "#B3B3B3" },
              Comment = { italic = false, fg = "#5F6972" },
              CopilotSuggestion = { fg = "#FF3BD3", bg = "#1c1c1c" },
              BufferDefaultCurrentADDED = { bg = "NONE" },
              BufferDefaultCurrentCHANGED = { bg = "NONE" },
              BufferDefaultCurrentDELETED = { bg = "NONE" },
              -- ["@variable"] = { fg = "#cccccc" },
              ["@keyword.import"] = { fg = "#D3FF3B" },
              ["@keyword.type"] = { fg = "#E599F7" },
              ["@keyword.conditional"] = { fg = "#FF3BD3" },
              ["@variable.member"] = { fg = "#FA99CD" },
              ["@Identifier"] = { fg = "#65d8ee", bold = true },
              ["RenderMarkdownCodeInline"] = { fg = "#D3FF3B", bg = "#1c1c1c" },
              ["@string.documentation"] = { fg = "#838383" },

              -- ["RenderMarkdownH1Bg"] = {
              --   bg = "#FF8787",
              --   fg = "#000000",
              --   bold = true,
              -- },
              -- ["RenderMarkdownH1"] = {
              --   fg = "#1c1c1c",
              -- },
              -- -- ["@markup.heading.2"] = {
              -- ["RenderMarkdownH2Bg"] = {
              --   bg = "#81E9FD",
              --   fg = "#000000",
              -- },
              -- ["RenderMarkdownH2"] = {
              --   fg = "#1c1c1c",
              -- },
              -- -- ["@markup.heading.3"] = {
              -- ["RenderMarkdownH3Bg"] = {
              --   bg = "#69DB7C",
              --   fg = "#222222",
              -- },
              -- ["RenderMarkdownH3"] = {
              --   fg = "#1c1c1c",
              -- },

              -- ["@property"] = { fg = colors.blue, bold = true },
              --         -- ["@property"] = { fg = colors.magenta, bold = true },
              --         ["@variable"] = { fg = "#cccccc" },
              --         ["@keyword.conditional"] = { fg = "#FF3BD3" },
              --         ["@variable.member"] = { fg = "#FA99CD" },
              --         ["@Identifier"] = { fg = "#65d8ee", bold = true },
            }
          end,

          -- Override a color entirely
          colors = {
            -- For a list of colors see `lua/cyberdream/colours.lua`
            -- Example:
            -- bg = "#1c1c1c",
            -- green = "#00ff00",
            -- magenta = "#ff00ff",
          },
        },
      })
    end,
  },
}
