return {

  {
    -- "MeanderingProgrammer/markdown.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    enabled = true,
    ft = { "markdown", "quarto" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
      -- {
      --   "echasnovski/mini.icons",
      --   version = false,
      --   config = function()
      --     require("mini.icons").setup()
      --   end,
      -- },
      -- { "echasnovski/mini.icons" },
    },
    opts = {
      -- heading = {
      --   -- Turn on / off heading icon & background rendering
      --   enabled = true,
      --   -- Turn on / off any sign column related rendering
      --   sign = true,
      --   -- Determines how icons fill the available space:
      --   --  inline:  underlying '#'s are concealed resulting in a left aligned icon
      --   --  overlay: result is left padded with spaces to hide any additional '#'
      --   position = "inline",
      --   -- Replaces '#+' of 'atx_h._marker'
      --   -- The number of '#' in the heading determines the 'level'
      --   -- The 'level' is used to index into the array using a cycle
      --   icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      --   -- icons = { "1️⃣ ", "2️⃣ ", "3️⃣ ", "4️⃣ ", "5️⃣ ", "6️⃣ " }, -- {
      --   -- Added to the sign column if enabled
      --   -- The 'level' is used to index into the array using a cycle
      --   signs = { "󰫎 " },
      --   -- signs = { "" },
      --   -- Width of the heading background:
      --   --  block: width of the heading text
      --   --  full:  full width of the window
      --   -- Can also be an array of the above values in which case the 'level' is used
      --   -- to index into the array using a clamp
      --   width = "block",
      --   -- Amount of padding to add to the left of headings
      --   left_pad = 0,
      --   -- Amount of padding to add to the right of headings when width is 'block'
      --   right_pad = 0,
      --   -- Minimum width to use for headings when width is 'block'
      --   min_width = 0,
      --   -- Determins if a border is added above and below headings
      --   border = false,
      --   -- Highlight the start of the border using the foreground highlight
      --   border_prefix = true,
      --   -- Used above heading for border
      --   above = "▄",
      --   -- Used below heading for border
      --   below = "▀",
      --   -- The 'level' is used to index into the array using a clamp
      --   -- Highlight for the heading icon and extends through the entire line
      --   backgrounds = {
      --     "RenderMarkdownH1Bg",
      --     "RenderMarkdownH2Bg",
      --     "RenderMarkdownH3Bg",
      --     "RenderMarkdownH4Bg",
      --     "RenderMarkdownH5Bg",
      --     "RenderMarkdownH6Bg",
      --   },
      --   -- The 'level' is used to index into the array using a clamp
      --   -- Highlight for the heading and sign icons
      --   foregrounds = {
      --     "RenderMarkdownH1",
      --     "RenderMarkdownH2",
      --     "RenderMarkdownH3",
      --     "RenderMarkdownH4",
      --     "RenderMarkdownH5",
      --     "RenderMarkdownH6",
      --   },
      -- },
    },
    config = function()
      require("render-markdown").setup({
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
          style = "full",
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
  { "vim-pandoc/vim-pandoc-syntax", lazy = false, filetypes = { "markdown", "vimwiki", "quarto" } },
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
          md = true,
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
              updated_title = updated_title:gsub("^######", "󰲫 ")
              updated_title = updated_title:gsub("^#####", "󰲩 ")
              updated_title = updated_title:gsub("^####", "󰲧 ")
              updated_title = updated_title:gsub("^###", "󰲥 ")
              updated_title = updated_title:gsub("^##", "󰲣 ")
              updated_title = updated_title:gsub("^#", "󰲡 ")
              -- updated_title = updated_title:gsub("^######", "######")
              -- updated_title = updated_title:gsub("^#####", "#####")
              -- updated_title = updated_title:gsub("^####", "####")
              -- updated_title = updated_title:gsub("^###", "###")
              -- updated_title = updated_title:gsub("^##", "##")
              -- updated_title = updated_title:gsub("^#", "#")
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
    enabled = true,
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
