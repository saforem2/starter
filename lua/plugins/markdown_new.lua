return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
      require("render-markdown").setup({
        heading = {
          -- Useful context to have when evaluating values.
          -- | level    | the number of '#' in the heading marker         |
          -- | sections | for each level how deeply nested the heading is |

          -- Turn on / off heading icon & background rendering.
          enabled = true,
          -- Additional modes to render headings.
          render_modes = false,
          -- Turn on / off atx heading rendering.
          atx = true,
          -- Turn on / off setext heading rendering.
          setext = true,
          -- Turn on / off sign column related rendering.
          sign = true,
          -- Replaces '#+' of 'atx_h._marker'.
          -- Output is evaluated depending on the type.
          -- | function | `value(context)`              |
          -- | string[] | `cycle(value, context.level)` |
          -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
          -- Determines how icons fill the available space.
          -- | eol     | '#'s are concealed and icon is placed at right most column   |
          -- | right   | '#'s are concealed and icon is appended to right side        |
          -- | inline  | '#'s are concealed and icon is inlined on left side          |
          -- | overlay | icon is left padded with spaces and overlayed hiding all '#' |
          position = "overlay",
          -- Added to the sign column if enabled.
          -- Output is evaluated by `cycle(value, context.level)`.
          signs = { "󰫎 " },
          -- Width of the heading background.
          -- | block | width of the heading text |
          -- | full  | full width of the window  |
          -- Can also be a list of the above values evaluated by `clamp(value, context.level)`.
          width = "full",
          -- Amount of margin to add to the left of headings.
          -- Margin available space is computed after accounting for padding.
          -- If a float < 1 is provided it is treated as a percentage of available window space.
          -- Can also be a list of numbers evaluated by `clamp(value, context.level)`.
          left_margin = 0,
          -- Amount of padding to add to the left of headings.
          -- Output is evaluated using the same logic as 'left_margin'.
          left_pad = 0,
          -- Amount of padding to add to the right of headings when width is 'block'.
          -- Output is evaluated using the same logic as 'left_margin'.
          right_pad = 0,
          -- Minimum width to use for headings when width is 'block'.
          -- Can also be a list of integers evaluated by `clamp(value, context.level)`.
          min_width = 0,
          -- Determines if a border is added above and below headings.
          -- Can also be a list of booleans evaluated by `clamp(value, context.level)`.
          border = false,
          -- Always use virtual lines for heading borders instead of attempting to use empty lines.
          border_virtual = false,
          -- Highlight the start of the border using the foreground highlight.
          border_prefix = false,
          -- Used above heading for border.
          above = "▄",
          -- Used below heading for border.
          below = "▀",
          -- Highlight for the heading icon and extends through the entire line.
          -- Output is evaluated by `clamp(value, context.level)`.
          backgrounds = {
            "RenderMarkdownH1Bg",
            "RenderMarkdownH2Bg",
            "RenderMarkdownH3Bg",
            "RenderMarkdownH4Bg",
            "RenderMarkdownH5Bg",
            "RenderMarkdownH6Bg",
          },
          -- Highlight for the heading and sign icons.
          -- Output is evaluated using the same logic as 'backgrounds'.
          foregrounds = {
            "RenderMarkdownH1",
            "RenderMarkdownH2",
            "RenderMarkdownH3",
            "RenderMarkdownH4",
            "RenderMarkdownH5",
            "RenderMarkdownH6",
          },
          -- Define custom heading patterns which allow you to override various properties based on
          -- the contents of a heading.
          -- The key is for healthcheck and to allow users to change its values, value type below.
          -- | pattern    | matched against the heading text @see :h lua-patterns |
          -- | icon       | optional override for the icon                        |
          -- | background | optional override for the background                  |
          -- | foreground | optional override for the foreground                  |
          custom = {},
        },
        completions = { lsp = { enabled = true } },
        -- Your config here
        enabled = true,
        -- preset = "obsidian",
        win_options = {
          conceallevel = {
            -- Used when not being rendered, get user setting
            default = 0,
            -- default = vim.api.nvim_get_option_value("conceallevel", { 2 }),
            -- Used when being rendered, concealed text is completely hidden
            rendered = 2,
          },
        },
        file_types = {
          "markdown",
          "quarto",
        },
        code = {
          -- Turn on / off code block & inline code rendering
          enabled = true,
          -- Turn on / off any sign column related rendering
          sign = true,
          -- Determines how code blocks & inline code are rendered:
          --  none:     disables all rendering
          --  normal:   adds highlight group to code blocks & inline code, adds padding to code blocks
          --  language: adds language icon to sign column if enabled and icon + name above code blocks
          --  full:     normal + language
          style = "normal",
          -- Determines where language icon is rendered:
          --  right: right side of code block
          --  left:  left side of code block
          position = "right",
          -- Amount of padding to add around the language
          language_pad = 0,
          -- An array of language names for which background highlighting will be disabled
          -- Likely because that language has background highlights itself
          disable_background = { "diff" },
          -- Width of the code block background:
          --  block: width of the code block
          --  full:  full width of the window
          width = "block",
          -- Amount of padding to add to the left of code blocks
          left_pad = 0,
          -- Amount of padding to add to the right of code blocks when width is 'block'
          right_pad = 0,
          -- Minimum width to use for code blocks when width is 'block'
          min_width = 0,
          -- Determins how the top / bottom of code block are rendered:
          --  thick: use the same highlight as the code body
          --  thin:  when lines are empty overlay the above & below icons
          border = "thick",
          -- Used above code blocks for thin border
          above = "▄",
          -- Used below code blocks for thin border
          below = "▀",
          -- Highlight for code blocks
          highlight = "RenderMarkdownCode",
          -- Highlight for inline code
          highlight_inline = "RenderMarkdownCodeInline",
        },
      })
    end,
  },

  { -- install without yarn or npm
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "quarto" },
    lazy = true,
    -- build = function() vim.fn["mkdp#util#install"]() end,
  },

  { "ellisonleao/glow.nvim", config = true, cmd = "Glow", ft = { "markdown", "quarto" } },
  -- {
  --   "hedyhli/markdown-toc.nvim",
  --   ft = "markdown", -- Lazy load on markdown filetype
  --   cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
  --   opts = {
  --     -- Your configuration here (optional)
  --   },
  -- },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown", "quarto" },
    config = function()
      require("mkdnflow").setup({
        mappings = {
          MkdnFoldSection = { "n", "<leader>k" },
          MkdnUnfoldSection = { "n", "<leader>K" },
        },
        filetypes = {
          rmd = true,
          markdown = true,
          qmd = true,
        },

        -- SAMPLE FOLDTEXT CONFIGURATION RECIPE WITH COMMENTS
        -- Other config options
        foldtext = {
          title_transformer = function()
            local function my_title_transformer(text)
              local updated_title = text:gsub("%b{}", "")
              updated_title = updated_title:gsub("^%s*", "")
              updated_title = updated_title:gsub("%s*$", "")
              -- updated_title = updated_title:gsub("^######", "░░░░░▓")
              -- updated_title = updated_title:gsub("^#####", "░░░░▓▓")
              -- updated_title = updated_title:gsub("^####", "░░░▓▓▓")
              -- updated_title = updated_title:gsub("^###", "░░▓▓▓▓")
              -- updated_title = updated_title:gsub("^##", "░▓▓▓▓▓")
              -- updated_title = updated_title:gsub("^#", "▓▓▓▓▓▓")
              -- updated_title = updated_title:gsub("^######", "󰲫 ")
              -- updated_title = updated_title:gsub("^#####", "󰲩 ")
              -- updated_title = updated_title:gsub("^####", "󰲧 ")
              -- updated_title = updated_title:gsub("^###", "󰲥 ")
              -- updated_title = updated_title:gsub("^##", "󰲣 ")
              -- updated_title = updated_title:gsub("^#", "󰲡 ")
              updated_title = updated_title:gsub("^######", "######")
              updated_title = updated_title:gsub("^#####", "#####")
              updated_title = updated_title:gsub("^####", "####")
              updated_title = updated_title:gsub("^###", "###")
              updated_title = updated_title:gsub("^##", "##")
              updated_title = updated_title:gsub("^#", "#")
              return updated_title
            end
            return my_title_transformer
          end,
          object_count_icon_set = "nerdfont", -- Use/fall back on the nerdfont icon set
          object_count_opts = function()
            local opts = {
              link = false, -- Prevent links from being counted
              blockquote = { -- Count block quotes (these aren't counted by default)
                icon = " ",
                count_method = {
                  pattern = { "^>.+$" },
                  tally = "blocks",
                },
              },
              fncblk = {
                -- Override the icon for fenced code blocks with 
                icon = " ",
              },
            }
            return opts
          end,
          line_count = false, -- Prevent lines from being counted
          word_count = true, -- Count the words in the section
          fill_chars = {
            left_edge = "╾────",
            right_edge = "───",
            item_separator = " · ",
            section_separator = " // ",
            left_inside = " ┝",
            right_inside = "┥ ",
            middle = "─",
          },
        },
      })
    end,
  },

  {
    "tadmccorkle/markdown.nvim",
    event = "VeryLazy",
    enabled = false,
    -- lazy = false,
    ft = { "markdown", "quarto" },
    opts = {
      -- mappings = {
      --   inline_surround_toggle = "gs", -- (string|boolean) toggle inline style
      --   inline_surround_toggle_line = "gss", -- (string|boolean) line-wise toggle inline style
      --   inline_surround_delete = "ds", -- (string|boolean) delete emphasis surrounding cursor
      --   inline_surround_change = "cs", -- (string|boolean) change emphasis surrounding cursor
      --   link_add = "gl", -- (string|boolean) add link
      --   link_follow = "gx", -- (string|boolean) follow link
      --   go_curr_heading = "]c", -- (string|boolean) set cursor to current section heading
      --   go_parent_heading = "]p", -- (string|boolean) set cursor to parent section heading
      --   go_next_heading = "]]", -- (string|boolean) set cursor to next section heading
      --   go_prev_heading = "[[", -- (string|boolean) set cursor to previous section heading
      -- },
    },
    config = function(_, opts)
      require("markdown").setup(opts)
    end,
  },
}
