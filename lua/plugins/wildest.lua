return {
  -- {
  --   "gelguy/wilder.nvim",
  --   enabled = true,
  --   lazy = true,
  --   event = "CmdlineEnter",
  --   dependencies = { "romgrk/fzy-lua-native" },
  --   config = function()
  --     local wilder = require("wilder")
  --     wilder.setup({ modes = { ":", "/", "?" } })
  --     -- Disable Python remote plugin
  --     wilder.set_option("use_python_remote_plugin", 0)
  --
  --     wilder.set_option("pipeline", {
  --       wilder.branch(
  --         wilder.cmdline_pipeline({
  --           fuzzy = 1,
  --           fuzzy_filter = wilder.lua_fzy_filter(),
  --         }),
  --         wilder.vim_search_pipeline()
  --       ),
  --     })
  --
  --     wilder.set_option(
  --       "renderer",
  --       wilder.renderer_mux({
  --         [":"] = wilder.popupmenu_renderer({
  --           highlighter = wilder.lua_fzy_highlighter(),
  --           left = {
  --             " ",
  --             wilder.popupmenu_devicons(),
  --           },
  --           right = {
  --             " ",
  --             wilder.popupmenu_scrollbar(),
  --           },
  --         }),
  --         ["/"] = wilder.wildmenu_renderer({
  --           highlighter = wilder.lua_fzy_highlighter(),
  --         }),
  --       })
  --     )
  --   end,
  -- },
  {
    "catgoose/wildest.nvim",
    build = "make -C csrc",
    enabled = false,
    config = function()
      local w = require("wildest")

      w.setup({
        modes = { ":", "/", "?" },
        next_key = "<Tab>",
        previous_key = "<S-Tab>",
        accept_key = "<Down>",
        reject_key = "<Up>",

        pipeline = w.branch(w.cmdline_pipeline({ fuzzy = true }), w.search_pipeline()),

        renderer = w.popupmenu_renderer({
          highlighter = w.basic_highlighter(),
          left = { " ", w.popupmenu_devicons() },
          right = { " ", w.popupmenu_scrollbar() },
        }),
      })

      -- local w = require("wildest")
      --
      -- w.setup({
      --   modes = { ":", "/", "?" },
      --   next_key = "<Tab>",
      --   previous_key = "<S-Tab>",
      --   accept_key = "<Down>",
      --   reject_key = "<Up>",
      --   trigger = "auto", -- or 'tab' if you prefer to lasso manually
      --   noselect = true, -- don't auto-select the first varmint
      --   longest_prefix = false, -- set true for wildmode=list:longest behavior
      --   pipeline_timeout = 5000, -- cancel slow pipelines after 5s
      --   skip_commands = { "Man" }, -- skip completions for ornery commands
      --
      --   pipeline = w.branch(
      --     -- Lua expression completion for :lua and :=
      --     w.lua_pipeline(),
      --     -- Fuzzy help tag completion for :help
      --     w.help_pipeline({ fuzzy = true }),
      --     -- Main cmdline completion with fuzzy filtering
      --     w.cmdline_pipeline({ fuzzy = true }),
      --     -- Search mode: buffer lines
      --     w.search_pipeline()
      --   ),
      --
      --   renderer = w.renderer_mux({
      --     [":"] = w.popupmenu_border_theme({
      --       border = "single",
      --       highlighter = w.fzy_highlighter(),
      --       left = { " ", w.popupmenu_devicons() },
      --       right = { " ", w.popupmenu_scrollbar() },
      --     }),
      --     ["/"] = w.wildmenu_renderer({
      --       highlighter = w.basic_highlighter(),
      --       separator = " | ",
      --     }),
      --   }),
      -- })
    end,
  },
}
