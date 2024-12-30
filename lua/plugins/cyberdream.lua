return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    enabled = true,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Add a custom keybinding to toggle the colorscheme
        cache = false,
        -- vim.api.nvim_set_keymap("n", "<leader>tt", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true }),
        colorscheme = "cyberdream",
        -- Enable transparent background
        transparent = true,
        -- Enable italics comments
        italic_comments = false,

        -- Replace all fillchars with ' ' for the ultimate clean look
        hide_fillchars = false,

        -- Modern borderless telescope theme
        borderless_telescope = true,

        -- Set terminal colors used in `:terminal`
        terminal_colors = true,

        theme = {
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
            Keyword = { fg = "#00CCFF" },
            CursorLine = { bg = "#252525" },
            ["@type.builtin.python"] = { fg = "#EC407A" },
            -- sym{"@type.builtin.python"} = { fg = "#EC407A" },
            -- sym"@keyword.conditional" = { fg = "#FF3BD3" },
            -- sym"@variable.member" = { fg = "#FA99CD" },
            -- sym"@Identifier" = { fg = "#65d8ee", bold = true },
            -- sym"RenderMarkdownCodeInline" = { fg = "#D3FF3B", bg = "#1c1c1c" },
            -- sym"@property" = { fg = "#00ff00", bold = true },
            -- Complete list can be found in `lua/cyberdream/theme.lua`
          },

          -- Override a highlight group entirely using the color palette
          overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
            -- Example:
            return {
              -- Normal = { bg = "#1c1c1c", fg = "#B3B3B3" },
              Comment = { italic = false, fg = "#5F6972" },
              -- ["@variable"] = { fg = "#cccccc" },
              ["@keyword.conditional"] = { fg = "#FF3BD3" },
              ["@variable.member"] = { fg = "#FA99CD" },
              ["@Identifier"] = { fg = "#65d8ee", bold = true },
              ["RenderMarkdownCodeInline"] = { fg = "#D3FF3B", bg = "#1c1c1c" },
              ["Number"] = { fg = "#FF00FF" },
              -- ["@type.builtin.python"] = { fg = "#EC407A" },
              ["semshiBuiltin"] = { fg= "#00CCFF" },
              ["@keyword.type.python"] = { fg = "#38D9A9" },
              ["Keyword"] = { fg="#00F364" },
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
          -- colors = {
          --   -- For a list of colors see `lua/cyberdream/colours.lua`
          --   -- Example:
          --   bg = "#1c1c1c",
          --   -- green = "#00ff00",
          --   -- magenta = "#ff00ff",
          -- },
        },
      })
    end,
  },
}
