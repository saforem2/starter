return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        min_window_height = 50,
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            "class",
            "function",
            "method",
          },
        },
      })
    end,
  },

  -- {
  --   "nfrid/markdown-togglecheck",
  --   dependencies = { "nfrid/treesitter-utils" },
  --   ft = { "markdown", "qmd" },
  -- },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>tT",
        "<CMD>TSJToggle<CR>",
        desc = "Toggle Treesitter Join",
      },
      {
        "<leader>tj",
        "<CMD>TSJJoin<CR>",
        desc = "Treesitter Join",
      },
      {
        "<leader>ts",
        "<CMD>TSJSplit<CR>",
        desc = "Treesitter Split",
      },
    },
    cmd = { "TSJToggle", "TSJJoin", "TSJSplit" },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      "mfussenegger/nvim-ts-hint-textobject",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "tadmccorkle/markdown.nvim",
    },

    build = ":TSUpdate",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        matchup = {
          enable = true,
        },
        ensure_installed = {
          -- "r",
          "python",
          "markdown",
          "markdown_inline",
          "julia",
          "bash",
          "yaml",
          "lua",
          "vim",
          "query",
          "vimdoc",
          "html",
          "css",
          "dot",
          "javascript",
          "mermaid",
          "typescript",
        },
        markdown = {
          enable = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        -- textobjects = {
        --   select = {
        --     enable = true,
        --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        --     keymaps = {
        --       -- You can use the capture groups defined in textobjects.scm
        --       ["af"] = "@function.outer",
        --       ["if"] = "@function.inner",
        --       ["ip"] = "@parameter.inner",
        --       ["ap"] = "@parameter.outer",
        --       ["ib"] = "@block.inner",
        --       ["ab"] = "@block.outer",
        --       ["im"] = "@class.inner", -- m as in "(M)odule"
        --       ["am"] = "@class.outer",
        --       ["aa"] = "@call.outer", -- a as in "function (A)pplication"
        --       ["ia"] = "@call.inner",
        --       ["a/"] = "@comment.outer",
        --       ["i/"] = "@comment.outer",
        --       ["ao"] = "@codechunk.outer",
        --       ["io"] = "@codechunk.inner",
        --     },
        --   },
        --   move = {
        --     enable = true,
        --     set_jumps = true, -- whether to set jumps in the jumplist
        --     goto_next_start = {
        --       ["]h"] = "@header",
        --       ["]f"] = "@function.outer",
        --       ["]m"] = "@class.outer",
        --       ["]p"] = "@parameter.outer",
        --       ["]]"] = "@block.outer",
        --       ["]b"] = "@block.outer",
        --       ["]a"] = "@call.outer",
        --       ["]/"] = "@comment.outer",
        --     },
        --     goto_next_end = {
        --       ["]F"] = "@function.outer",
        --       ["]M"] = "@class.outer",
        --       ["]P"] = "@parameter.outer",
        --       ["]["] = "@block.outer",
        --       ["]B"] = "@block.outer",
        --       ["]A"] = "@call.outer",
        --       ["]\\"] = "@comment.outer",
        --     },
        --     goto_previous_start = {
        --       ["[h"] = "@header",
        --       ["[f"] = "@function.outer",
        --       ["[m"] = "@class.outer",
        --       ["[p"] = "@parameter.outer",
        --       ["[["] = "@block.outer",
        --       ["[b"] = "@block.outer",
        --       ["[a"] = "@call.outer",
        --       ["[/"] = "@comment.outer",
        --     },
        --     goto_previous_end = {
        --       ["[F"] = "@function.outer",
        --       ["[M"] = "@class.outer",
        --       ["[P"] = "@parameter.outer",
        --       ["[]"] = "@block.outer",
        --       ["[B"] = "@block.outer",
        --       ["[A"] = "@call.outer",
        --       ["[\\"] = "@comment.outer",
        --     },
        --   },
        -- },
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSHighlightCapturesUnderCursor",
    enabled = false,
  },
}
