return {
    {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = LazyVim.config.icons

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
          component_separators = "",
          section_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },

        lualine_c = {
          LazyVim.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          Snacks.profiler.status(),
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return { fg = Snacks.util.color("Statement") } end,
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return { fg = Snacks.util.color("Special") } end,
          },
          -- {
          --   "diff",
          --   symbols = {
          --     added = icons.git.added,
          --     modified = icons.git.modified,
          --     removed = icons.git.removed,
          --   },
          --   source = function()
          --     local gitsigns = vim.b.gitsigns_status_dict
          --     if gitsigns then
          --       return {
          --         added = gitsigns.added,
          --         modified = gitsigns.changed,
          --         removed = gitsigns.removed,
          --       }
          --     end
          --   end,
          -- },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    }

    -- do not add trouble symbols if aerial is enabled
    -- And allow it to be overriden for some buffer types (see autocmds)
    if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      table.insert(opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
    end

    return opts
  end,
    }
}
-- if true then
--   return {}
-- end
--
-- local codestats = require("codestats")
-- local xp = function()
--   return codestats.get_xp(0) .. "/" .. codestats.get_xp() -- current buf language xp
-- end
--
-- local function ins_left(component)
--   local config = require("config.lualine.default")
--   table.insert(config.sections.lualine_c, component)
-- end
--
-- return {
--   {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     init = function()
--       vim.g.lualine_laststatus = vim.o.laststatus
--       if vim.fn.argc(-1) > 0 then
--         -- set an empty statusline till lualine loads
--         vim.o.statusline = " "
--       else
--         -- hide the statusline on the starter page
--         vim.o.laststatus = 0
--       end
--     end,
--     opts = function(_, opts)
--       -- PERF: we don't need this lualine require madness 🤷
--       -- local lualine_require = require("lualine_require")
--       -- lualine_require.require = require
--       local config = require("config.lualine.default")
--       opts.sections.lualine_z = {}
--       opts.sections.lualine_z = {
--         "location",
--         "filetype",
--         {
--           xp,
--           fmt = function(s)
--             return s and (s ~= "0/0" or nil) and s .. " xp"
--           end,
--         },
--       }
--     end,
--   },
-- }
-- -- opts.sections.lualine_a = {
-- --             ins_left {
-- --                 function()
-- --                     return ' '
-- --                 end,
-- --             },
-- --         },
-- --     end,
-- --   },
-- -- }
--
-- -- return {
-- --     {
-- --   "nvim-lualine/lualine.nvim",
-- --   event = "VeryLazy",
-- --   init = function()
-- --     vim.g.lualine_laststatus = vim.o.laststatus
-- --     if vim.fn.argc(-1) > 0 then
-- --       -- set an empty statusline till lualine loads
-- --       vim.o.statusline = " "
-- --     else
-- --       -- hide the statusline on the starter page
-- --       vim.o.laststatus = 0
-- --     end
-- --   end,
-- --   opts = function()
-- --     -- PERF: we don't need this lualine require madness 🤷
-- --     local lualine_require = require("lualine_require")
-- --     lualine_require.require = require
-- --
-- --     local icons = LazyVim.config.icons
-- --
-- --     vim.o.laststatus = vim.g.lualine_laststatus
-- --
-- --     local opts = {
-- --       options = {
-- --         theme = "auto",
-- --         globalstatus = vim.o.laststatus == 3,
-- --         disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
-- --       },
-- --       sections = {
-- --         lualine_a = { "mode" },
-- --         lualine_b = { "branch" },
-- --
-- --         lualine_c = {
-- --           LazyVim.lualine.root_dir(),
-- --           {
-- --             "diagnostics",
-- --             symbols = {
-- --               error = icons.diagnostics.Error,
-- --               warn = icons.diagnostics.Warn,
-- --               info = icons.diagnostics.Info,
-- --               hint = icons.diagnostics.Hint,
-- --             },
-- --           },
-- --           { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
-- --           { LazyVim.lualine.pretty_path() },
-- --         },
-- --         lualine_x = {
-- --           Snacks.profiler.status(),
-- --           -- stylua: ignore
-- --           {
-- --             function() return require("noice").api.status.command.get() end,
-- --             cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
-- --             color = function() return { fg = Snacks.util.color("Statement") } end,
-- --           },
-- --           -- stylua: ignore
-- --           {
-- --             function() return require("noice").api.status.mode.get() end,
-- --             cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
-- --             color = function() return { fg = Snacks.util.color("Constant") } end,
-- --           },
-- --           -- stylua: ignore
-- --           {
-- --             function() return "  " .. require("dap").status() end,
-- --             cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
-- --             color = function() return { fg = Snacks.util.color("Debug") } end,
-- --           },
-- --           -- stylua: ignore
-- --           {
-- --             require("lazy.status").updates,
-- --             cond = require("lazy.status").has_updates,
-- --             color = function() return { fg = Snacks.util.color("Special") } end,
-- --           },
-- --           {
-- --             "diff",
-- --             symbols = {
-- --               added = icons.git.added,
-- --               modified = icons.git.modified,
-- --               removed = icons.git.removed,
-- --             },
-- --             source = function()
-- --               local gitsigns = vim.b.gitsigns_status_dict
-- --               if gitsigns then
-- --                 return {
-- --                   added = gitsigns.added,
-- --                   modified = gitsigns.changed,
-- --                   removed = gitsigns.removed,
-- --                 }
-- --               end
-- --             end,
-- --           },
-- --         },
-- --         lualine_y = {
-- --           { "progress", separator = " ", padding = { left = 1, right = 0 } },
-- --           { "location", padding = { left = 0, right = 1 } },
-- --         },
-- --         lualine_z = {
-- --           function()
-- --             return " " .. os.date("%R")
-- --           end,
-- --         },
-- --       },
-- --       extensions = { "neo-tree", "lazy", "fzf" },
-- --     }
-- --
-- --     -- do not add trouble symbols if aerial is enabled
-- --     -- And allow it to be overriden for some buffer types (see autocmds)
-- --     if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
-- --       local trouble = require("trouble")
-- --       local symbols = trouble.statusline({
-- --         mode = "symbols",
-- --         groups = {},
-- --         title = false,
-- --         filter = { range = true },
-- --         format = "{kind_icon}{symbol.name:Normal}",
-- --         hl_group = "lualine_c_normal",
-- --       })
-- --       table.insert(opts.sections.lualine_c, {
-- --         symbols and symbols.get,
-- --         cond = function()
-- --           return vim.b.trouble_lualine ~= false and symbols.has()
-- --         end,
-- --       })
-- --     end
-- --
-- --     return opts
-- --   end,
-- --     }
-- -- }
-- -- if true then
-- --   return {}
-- -- end
-- --
--
-- -- return {
-- --     {
-- --         "nvim-lualine/lualine.nvim",
-- --         event = "VeryLazy",
-- --         enabled = true,
-- --         init = function()
-- --             vim.g.lualine_laststatus = vim.o.laststatus
-- --             if vim.fn.argc(-1) > 0 then
-- --                 vim.o.statusline = " "
-- --             else
-- --                 vim.o.laststatus = 0
-- --             end
-- --         end,
-- --         config = function()
-- --             require("config.lualine")
-- --         end,
-- --     },
-- -- }
-- -- return {
-- --   {
-- --     "nvim-lualine/lualine.nvim",
-- --     event = "VeryLazy",
-- --     init = function()
-- --       vim.g.lualine_laststatus = vim.o.laststatus
-- --       if vim.fn.argc(-1) > 0 then
-- --         -- set an empty statusline till lualine loads
-- --         vim.o.statusline = " "
-- --       else
-- --         -- hide the statusline on the starter page
-- --         vim.o.laststatus = 0
-- --       end
-- --     end,
-- --     config = function()
-- --         require("config.lualine-evil")
-- --     end,
-- --     },
-- -- }
-- -- config = function()
-- --   -- Eviline config for lualine
-- --   -- Author: shadmansaleh
-- --   -- Credit: glepnir
-- --   local lualine = require("lualine")
-- --
-- --     -- Color table for highlights
-- --     -- stylua: ignore
-- -- local colors = {
-- --     bg       = '#202328',
-- --     fg       = '#bbc2cf',
-- --     yellow   = '#ECBE7B',
-- --     cyan     = '#008080',
-- --     darkblue = '#081633',
-- --     green    = '#98be65',
-- --     orange   = '#FF8800',
-- --     violet   = '#a9a1e1',
-- --     magenta  = '#c678dd',
-- --     blue     = '#51afef',
-- --     red      = '#ec5f67',
-- -- }
-- --
-- --   local conditions = {
-- --     buffer_not_empty = function()
-- --       return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
-- --     end,
-- --     hide_in_width = function()
-- --       return vim.fn.winwidth(0) > 80
-- --     end,
-- --     check_git_workspace = function()
-- --       local filepath = vim.fn.expand("%:p:h")
-- --       local gitdir = vim.fn.finddir(".git", filepath .. ";")
-- --       return gitdir and #gitdir > 0 and #gitdir < #filepath
-- --     end,
-- --   }
-- --
-- --   -- Config
-- --   local config = {
-- --     options = {
-- --       -- Disable sections and component separators
-- --       component_separators = "",
-- --       section_separators = "",
-- --       theme = {
-- --         -- We are going to use lualine_c an lualine_x as left and
-- --         -- right section. Both are highlighted by c theme .  So we
-- --         -- are just setting default looks o statusline
-- --         normal = { c = { fg = colors.fg, bg = colors.bg } },
-- --         inactive = { c = { fg = colors.fg, bg = colors.bg } },
-- --       },
-- --     },
-- --     sections = {
-- --       -- these are to remove the defaults
-- --       lualine_a = {},
-- --       lualine_b = {},
-- --       lualine_y = {},
-- --       lualine_z = {},
-- --       -- These will be filled later
-- --       lualine_c = {},
-- --       lualine_x = {},
-- --     },
-- --     inactive_sections = {
-- --       -- these are to remove the defaults
-- --       lualine_a = {},
-- --       lualine_b = {},
-- --       lualine_y = {},
-- --       lualine_z = {},
-- --       lualine_c = {},
-- --       lualine_x = {},
-- --     },
-- --   }
-- --
-- --   -- Inserts a component in lualine_c at left section
-- --   local function ins_left(component)
-- --     table.insert(config.sections.lualine_c, component)
-- --   end
-- --
-- --   -- Inserts a component in lualine_x at right section
-- --   local function ins_right(component)
-- --     table.insert(config.sections.lualine_x, component)
-- --   end
-- --
-- --   ins_left({
-- --     function()
-- --       return "▊"
-- --     end,
-- --     color = { fg = colors.blue }, -- Sets highlighting of component
-- --     padding = { left = 0, right = 1 }, -- We don't need space before this
-- --   })
-- --
-- --   ins_left({
-- --     -- mode component
-- --     function()
-- --       return ""
-- --     end,
-- --     color = function()
-- --       -- auto change color according to neovims mode
-- --       local mode_color = {
-- --         n = colors.red,
-- --         i = colors.green,
-- --         v = colors.blue,
-- --         ["␖"] = colors.blue,
-- --         V = colors.blue,
-- --         c = colors.magenta,
-- --         no = colors.red,
-- --         s = colors.orange,
-- --         S = colors.orange,
-- --         ["␓"] = colors.orange,
-- --         ic = colors.yellow,
-- --         R = colors.violet,
-- --         Rv = colors.violet,
-- --         cv = colors.red,
-- --         ce = colors.red,
-- --         r = colors.cyan,
-- --         rm = colors.cyan,
-- --         ["r?"] = colors.cyan,
-- --         ["!"] = colors.red,
-- --         t = colors.red,
-- --       }
-- --       return { fg = mode_color[vim.fn.mode()] }
-- --     end,
-- --     padding = { right = 1 },
-- --   })
-- --
-- --   ins_left({
-- --     -- filesize component
-- --     "filesize",
-- --     cond = conditions.buffer_not_empty,
-- --   })
-- --
-- --   ins_left({
-- --     "filename",
-- --     cond = conditions.buffer_not_empty,
-- --     color = { fg = colors.magenta, gui = "bold" },
-- --   })
-- --
-- --   ins_left({ "location" })
-- --
-- --   ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })
-- --
-- --   ins_left({
-- --     "diagnostics",
-- --     sources = { "nvim_diagnostic" },
-- --     symbols = { error = " ", warn = " ", info = " " },
-- --     diagnostics_color = {
-- --       error = { fg = colors.red },
-- --       warn = { fg = colors.yellow },
-- --       info = { fg = colors.cyan },
-- --     },
-- --   })
-- --
-- --   -- Insert mid section. You can make any number of sections in neovim :)
-- --   -- for lualine it's any number greater then 2
-- --   ins_left({
-- --     function()
-- --       return "%="
-- --     end,
-- --   })
-- --
-- --   ins_left({
-- --     -- Lsp server name .
-- --     function()
-- --       local msg = "No Active Lsp"
-- --       local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
-- --       local clients = vim.lsp.get_clients()
-- --       if next(clients) == nil then
-- --         return msg
-- --       end
-- --       for _, client in ipairs(clients) do
-- --         local filetypes = client.config.filetypes
-- --         if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
-- --           return client.name
-- --         end
-- --       end
-- --       return msg
-- --     end,
-- --     icon = " LSP:",
-- --     color = { fg = "#ffffff", gui = "bold" },
-- --   })
-- --
-- --   -- Add components to right sections
-- --   ins_right({
-- --     "o:encoding", -- option component same as &encoding in viml
-- --     fmt = string.upper, -- I'm not sure why it's upper case either ;)
-- --     cond = conditions.hide_in_width,
-- --     color = { fg = colors.green, gui = "bold" },
-- --   })
-- --
-- --   ins_right({
-- --     "fileformat",
-- --     fmt = string.upper,
-- --     icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
-- --     color = { fg = colors.green, gui = "bold" },
-- --   })
-- --
-- --   ins_right({
-- --     "branch",
-- --     icon = "",
-- --     color = { fg = colors.violet, gui = "bold" },
-- --   })
-- --
-- --   ins_right({
-- --     "diff",
-- --     -- Is it me or the symbol for modified us really weird
-- --     symbols = { added = " ", modified = "󰝤 ", removed = " " },
-- --     diff_color = {
-- --       added = { fg = colors.green },
-- --       modified = { fg = colors.orange },
-- --       removed = { fg = colors.red },
-- --     },
-- --     cond = conditions.hide_in_width,
-- --   })
-- --
-- --   ins_right({
-- --     function()
-- --       return "▊"
-- --     end,
-- --     color = { fg = colors.blue },
-- --     padding = { left = 1 },
-- --   })
--
-- -- Now don't forget to initialize lualine
-- --   lualine.setup(config)
-- -- end,
-- -- opts = function()
-- --   -- PERF: we don't need this lualine require madness 🤷
-- --   local lualine_require = require("lualine_require")
-- --   lualine_require.require = require
-- --
-- --   local icons = LazyVim.config.icons
-- --
-- --   vim.o.laststatus = vim.g.lualine_laststatus
-- --
-- --   local opts = {
-- --     options = {
-- --       theme = "auto",
-- --       globalstatus = vim.o.laststatus == 3,
-- --       disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
-- --     },
-- --     sections = {
-- --       lualine_a = { "mode" },
-- --       lualine_b = { "branch" },
-- --
-- --       lualine_c = {
-- --         LazyVim.lualine.root_dir(),
-- --         {
-- --           "diagnostics",
-- --           symbols = {
-- --             error = icons.diagnostics.Error,
-- --             warn = icons.diagnostics.Warn,
-- --             info = icons.diagnostics.Info,
-- --             hint = icons.diagnostics.Hint,
-- --           },
-- --         },
-- --         { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
-- --         { LazyVim.lualine.pretty_path() },
-- --       },
-- --       lualine_x = {
-- --         Snacks.profiler.status(),
-- --         -- stylua: ignore
-- --         {
-- --           function() return require("noice").api.status.command.get() end,
-- --           cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
-- --           color = function() return { fg = Snacks.util.color("Statement") } end,
-- --         },
-- --         -- stylua: ignore
-- --         {
-- --           function() return require("noice").api.status.mode.get() end,
-- --           cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
-- --           color = function() return { fg = Snacks.util.color("Constant") } end,
-- --         },
-- --         -- stylua: ignore
-- --         {
-- --           function() return "  " .. require("dap").status() end,
-- --           cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
-- --           color = function() return { fg = Snacks.util.color("Debug") } end,
-- --         },
-- --         -- stylua: ignore
-- --         {
-- --           require("lazy.status").updates,
-- --           cond = require("lazy.status").has_updates,
-- --           color = function() return { fg = Snacks.util.color("Special") } end,
-- --         },
-- --         {
-- --           "diff",
-- --           symbols = {
-- --             added = icons.git.added,
-- --             modified = icons.git.modified,
-- --             removed = icons.git.removed,
-- --           },
-- --           source = function()
-- --             local gitsigns = vim.b.gitsigns_status_dict
-- --             if gitsigns then
-- --               return {
-- --                 added = gitsigns.added,
-- --                 modified = gitsigns.changed,
-- --                 removed = gitsigns.removed,
-- --               }
-- --             end
-- --           end,
-- --         },
-- --       },
-- --       lualine_y = {
-- --         { "progress", separator = " ", padding = { left = 1, right = 0 } },
-- --         { "location", padding = { left = 0, right = 1 } },
-- --       },
-- --       lualine_z = {
-- --         function()
-- --           return " " .. os.date("%R")
-- --         end,
-- --       },
-- --     },
-- --     extensions = { "neo-tree", "lazy", "fzf" },
-- --   }
-- --
-- --   -- do not add trouble symbols if aerial is enabled
-- --   -- And allow it to be overriden for some buffer types (see autocmds)
-- --   if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
-- --     local trouble = require("trouble")
-- --     local symbols = trouble.statusline({
-- --       mode = "symbols",
-- --       groups = {},
-- --       title = false,
-- --       filter = { range = true },
-- --       format = "{kind_icon}{symbol.name:Normal}",
-- --       hl_group = "lualine_c_normal",
-- --     })
-- --     table.insert(opts.sections.lualine_c, {
-- --       symbols and symbols.get,
-- --       cond = function()
-- --         return vim.b.trouble_lualine ~= false and symbols.has()
-- --       end,
-- --     })
-- --   end
-- --
-- --   return opts
-- -- end,
-- -- },
-- -- }
