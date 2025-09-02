return {

  { "vim-pandoc/vim-pandoc-syntax", lazy = false, enabled = true },
  {
    "KeitaNakamura/tex-conceal.vim",
    lazy = false,
    enabled = true,
    -- config = function()
    -- end,
  },

  -- {
  --   "quarto-dev/quarto-vim",
  --   lazy = false,
  --   requires = {
  --     { "vim-pandoc/vim-pandoc-syntax" },
  --   },
  --   ft = { "quarto" },
  -- },
  {
    "quarto-dev/quarto-vim",
    -- enabled = true,
    lazy = false,
    ft = { "quarto", "markdown" },
    requires = { "vim-pandoc/vim-pandoc-syntax" },
    -- dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
    -- note: needs additional syntax highlighting enabled for markdown
    -- in `nvim-treesitter`
    config = function()
      -- conceal can be tricky because both
      -- the treesitter highlighting and the
      -- regex vim syntax files can define conceal
      -- s
      -- see `:h conceallevel`
      -- vim.opt.conceallevel = 0
      -- -- disable conceal in markdown/quarto
      vim.g["pandoc#syntax#conceal#use"] = true
      -- -- embeds are already handled by treesitter injectons
      vim.g["pandoc#syntax#codeblocks#embeds#use"] = true
      vim.g["pandoc#syntax#conceal#blacklist"] = { "codeblock_delim", "codeblock_start" }
      -- but allow some types of conceal in math regions:
      -- see `:h g:tex_conceal`
      vim.g["tex_conceal"] = "gm"
    end,
  },

  { -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
    -- for complete functionality (language features)
    "quarto-dev/quarto-nvim",
    enabled = true,
    lazy = false,
    ft = { "quarto" },
    -- opts = {},
    dependencies = {
      -- for language features in code cells
      -- configured in lua/plugins/lsp.lua and
      -- added as a nvim-cmp source in lua/plugins/completion.lua
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("quarto").setup({
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "curly",
          languages = { "python", "julia", "bash", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "slime", -- "molten", "slime", "iron" or <function>
          ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
          -- Takes precedence over `default_method`
          never_run = { "yaml" }, -- filetypes which are never sent to a code runner
        },
      })
    end,
  },

  { -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    "GCBallesteros/jupytext.nvim",
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
        r = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
    },
  },

  { -- send code from python/r/qmd documets to a terminal or REPL
    -- like ipython, R, bash
    "jpalardy/vim-slime",
    dev = false,
    init = function()
      vim.b["quarto_is_python_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context("python")
      end

      vim.cmd([[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
      return [a:text, "\n"]
      else
      return [a:text]
      end
      end
      endfunction
      ]])

      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = true
      vim.g.slime_python_ipython = 1
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true

      local function mark_terminal()
        local job_id = vim.b.terminal_job_id
        vim.print("job_id: " .. job_id)
      end

      local function set_terminal()
        vim.fn.call("slime#config", {})
      end
      vim.keymap.set("n", "<leader>cm", mark_terminal, { desc = "[m]ark terminal" })
      vim.keymap.set("n", "<leader>cs", set_terminal, { desc = "[s]et terminal" })
    end,
  },

  -- { -- paste an image from the clipboard or drag-and-drop
  --   "HakonHarnes/img-clip.nvim",
  --   event = "BufEnter",
  --   ft = { "markdown", "quarto", "latex" },
  --   opts = {
  --     default = {
  --       dir_path = "img",
  --     },
  --     filetypes = {
  --       markdown = {
  --         url_encode_path = true,
  --         template = "![$CURSOR]($FILE_PATH)",
  --         drag_and_drop = {
  --           download_images = false,
  --         },
  --       },
  --       quarto = {
  --         url_encode_path = true,
  --         template = "![$CURSOR]($FILE_PATH)",
  --         drag_and_drop = {
  --           download_images = false,
  --         },
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("img-clip").setup(opts)
  --     vim.keymap.set("n", "<leader>ii", ":PasteImage<cr>", { desc = "insert [i]mage from clipboard" })
  --   end,
  -- },

  { -- preview equations
    "jbyuki/nabla.nvim",
    keys = {
      { "<leader>qm", ':lua require"nabla".toggle_virt()<cr>', desc = "toggle [m]ath equations" },
    },
  },

  {
    "benlubas/molten-nvim",
    enabled = false,
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
    end,
    keys = {
      { "<leader>mi", ":MoltenInit<cr>", desc = "[m]olten [i]nit" },
      {
        "<leader>mv",
        ":<C-u>MoltenEvaluateVisual<cr>",
        mode = "v",
        desc = "molten eval visual",
      },
      { "<leader>mr", ":MoltenReevaluateCell<cr>", desc = "molten re-eval cell" },
    },
  },
}

-- return {
--   -- { "vim-pandoc/vim-pandoc-syntax" },
--     --
--     {
--         "KeitaNakamura/tex-conceal.vim",
--         lazy = false,
--         enabled = true,
--         -- config = function()
--         -- end,
--     },
--
--   { -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
--     -- for complete functionality (language features)
--     'quarto-dev/quarto-nvim',
--     ft = { 'quarto', "markdown", "qmd" },
--     dev = false,
--     enabled = true,
--     opts = {
--       lspFeatures = {
--         enabled = true,
--         diagnostics = {
--           enabled = true,
--           triggers = { "BufWritePost" },
--         },
--         completion = {
--           enabled = true,
--         },
--         languages = { 'r', 'python', 'julia', 'bash', 'lua', 'html', 'dot', 'javascript', 'typescript', 'ojs' },
--       },
--       keymap = {
--         hover = 'K',
--         definition = 'gd',
--         rename = '<leader>lR',
--         references = 'gr',
--       },
--       codeRunner = {
--         enabled = true,
--         default_method = 'slime',
--       },
--     },
--     dependencies = {
--       -- for language features in code cells
--       -- configured in lua/plugins/lsp.lua and
--       -- added as a nvim-cmp source in lua/plugins/completion.lua
--       -- 'jmbuhr/otter.nvim',
--       {
--         "jmbuhr/otter.nvim",
--         dev = false,
--         enabled = true,
--         opts = {
--           lsp = {
--             hover = {
--               border = require('style').border
--             }
--           }
--         }
--       },
--       {
--         'quarto-dev/quarto-vim',
--         -- enabled = true,
--         lazy = false,
--         ft = { "quarto", "markdown", "qmd" },
--         -- dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
--         -- note: needs additional syntax highlighting enabled for markdown
--         -- in `nvim-treesitter`
--         config = function()
--           -- conceal can be tricky because both
--           -- the treesitter highlighting and the
--           -- regex vim syntax files can define conceal
--           -- s
--           -- see `:h conceallevel`
--           -- vim.opt.conceallevel = 0
--           -- -- disable conceal in markdown/quarto
--           -- vim.g['pandoc#syntax#conceal#use'] = true
--           -- -- embeds are already handled by treesitter injectons
--           -- vim.g['pandoc#syntax#codeblocks#embeds#use'] = true
--           -- vim.g['pandoc#syntax#conceal#blacklist'] = { 'codeblock_delim', 'codeblock_start' }
--           -- but allow some types of conceal in math regions:
--           -- see `:h g:tex_conceal`
--           vim.g['tex_conceal'] = 'gm'
--         end
--       },
--     },
--   },
--
--   { -- directly open ipynb files as quarto docuements
--     -- and convert back behind the scenes
--     -- needs:
--     -- pip install jupytext
--     'GCBallesteros/jupytext.nvim',
--     opts = {
--       custom_language_formatting = {
--         python = {
--           extension = 'qmd',
--           style = 'quarto',
--           force_ft = 'quarto', -- you can set whatever filetype you want here
--         },
--         r = {
--           extension = 'qmd',
--           style = 'quarto',
--           force_ft = 'quarto', -- you can set whatever filetype you want here
--         },
--       },
--     },
--   },
--
--   { -- send code from python/r/qmd documets to a terminal or REPL
--     -- like ipython, R, bash
--     'jpalardy/vim-slime',
--     init = function()
--       vim.b['quarto_is_python_chunk'] = false
--       Quarto_is_in_python_chunk = function()
--         require('otter.tools.functions').is_otter_language_context 'python'
--       end
--
--       vim.cmd [[
--       let g:slime_dispatch_ipython_pause = 100
--       function SlimeOverride_EscapeText_quarto(text)
--       call v:lua.Quarto_is_in_python_chunk()
--       if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
--       return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
--       else
--       if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
--       return [a:text, "\n"]
--       else
--       return [a:text]
--       end
--       end
--       endfunction
--       ]]
--
--       vim.g.slime_target = 'neovim'
--       vim.g.slime_python_ipython = 1
--     end,
--     config = function()
--       local function mark_terminal()
--         vim.g.slime_last_channel = vim.b.terminal_job_id
--       end
--
--       local function set_terminal()
--         vim.b.slime_config = { jobid = vim.g.slime_last_channel }
--       end
--       vim.keymap.set('n', '<leader>cm', mark_terminal, { desc = '[m]ark terminal' })
--       vim.keymap.set('n', '<leader>cs', set_terminal, { desc = '[s]et terminal' })
--     end,
--   },
--
--   { -- paste an image from the clipboard or drag-and-drop
--     'HakonHarnes/img-clip.nvim',
--     event = 'BufEnter',
--     ft = { 'markdown', 'quarto', 'latex' },
--     opts = {
--       default = {
--         dir_path = 'img',
--       },
--       filetypes = {
--         markdown = {
--           url_encode_path = true,
--           template = '![$CURSOR]($FILE_PATH)',
--           drag_and_drop = {
--             download_images = false,
--           },
--         },
--         quarto = {
--           url_encode_path = true,
--           template = '![$CURSOR]($FILE_PATH)',
--           drag_and_drop = {
--             download_images = false,
--           },
--         },
--       },
--     },
--     config = function(_, opts)
--       require('img-clip').setup(opts)
--       vim.keymap.set('n', '<leader>ii', ':PasteImage<cr>', { desc = 'insert [i]mage from clipboard' })
--     end,
--   },
--
--   { -- preview equations
--     'jbyuki/nabla.nvim',
--     keys = {
--       { '<leader>qm', ':lua require"nabla".toggle_virt()<cr>', desc = 'toggle [m]ath equations' },
--     },
--   },
--
--   {
--     'benlubas/molten-nvim',
--     enabled = false,
--     build = ':UpdateRemotePlugins',
--     init = function()
--       vim.g.molten_image_provider = 'image.nvim'
--       vim.g.molten_output_win_max_height = 20
--       vim.g.molten_auto_open_output = false
--     end,
--     keys = {
--       { '<leader>mi', ':MoltenInit<cr>', desc = '[m]olten [i]nit' },
--       {
--         '<leader>mv',
--         ':<C-u>MoltenEvaluateVisual<cr>',
--         mode = 'v',
--         desc = 'molten eval visual',
--       },
--       { '<leader>mr', ':MoltenReevaluateCell<cr>', desc = 'molten re-eval cell' },
--     },
--   },
-- }
