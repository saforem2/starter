if true then
  return {}
end

return {

  {

    -- for lsp features in code cells / embedded code
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      verbose = {
        no_code_found = false,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "mason.nvim",
      { "mason-org/mason-lspconfig.nvim", config = function() end },
      { "saghen/blink.cmp" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { -- nice loading notifications
        -- PERF: but can slow down startup
        "j-hui/fidget.nvim",
        enabled = false,
        opts = {},
      },
      {
        {
          "folke/lazydev.nvim",
          ft = "lua", -- only load on lua files
          opts = {
            library = {
              -- See the configuration section for more details
              -- Load luvit types when the `vim.uv` word is found
              { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
          },
        },
        { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
        -- { -- optional completion source for require statements and module annotations
        --   "hrsh7th/nvim-cmp",
        --   opts = function(_, opts)
        --     opts.sources = opts.sources or {}
        --     table.insert(opts.sources, {
        --       name = "lazydev",
        --       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        --     })
        --   end,
        -- },
        -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
      },
      { "folke/neoconf.nvim", opts = {}, enabled = false },
    },
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
            },
          },
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- Use this to add any additional keymaps
            -- for specific lsp servers
            -- ---@type LazyKeysSpec[]
            -- keys = {},
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return ret
    end,
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- setup autoformat
      LazyVim.format.register(LazyVim.lsp.formatter())

      -- setup keymaps
      LazyVim.lsp.on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      LazyVim.lsp.setup()
      LazyVim.lsp.on_dynamic_capability(require("lazyvim.plugins.lsp.keymaps").on_attach)

      -- diagnostics signs
      if vim.fn.has("nvim-0.10.0") == 0 then
        if type(opts.diagnostics.signs) ~= "boolean" then
          for severity, icon in pairs(opts.diagnostics.signs.text) do
            local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
            name = "DiagnosticSign" .. name
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
          end
        end
      end

      if vim.fn.has("nvim-0.10") == 1 then
        -- inlay hints
        if opts.inlay_hints.enabled then
          LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
            if
              vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
          end)
        end

        -- code lens
        if opts.codelens.enabled and vim.lsp.codelens then
          LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = buffer,
              callback = vim.lsp.codelens.refresh,
            })
          end)
        end
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = LazyVim.config.icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup({
          ensure_installed = vim.tbl_deep_extend(
            "force",
            ensure_installed,
            LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}
          ),
          handlers = { setup },
        })
      end

      if LazyVim.lsp.is_enabled("denols") and LazyVim.lsp.is_enabled("vtsls") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        LazyVim.lsp.disable("vtsls", is_deno)
        LazyVim.lsp.disable("denols", function(root_dir, config)
          if not is_deno(root_dir) then
            config.settings.deno.enable = false
          end
          return false
        end)
      end
    end,
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     { "saghen/blink.cmp" },
  --     { "williamboman/mason.nvim" },
  --     { "williamboman/mason-lspconfig.nvim" },
  --     { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  --     { -- nice loading notifications
  --       -- PERF: but can slow down startup
  --       "j-hui/fidget.nvim",
  --       enabled = false,
  --       opts = {},
  --     },
  --     {
  --       {
  --         "folke/lazydev.nvim",
  --         ft = "lua", -- only load on lua files
  --         opts = {
  --           library = {
  --             -- See the configuration section for more details
  --             -- Load luvit types when the `vim.uv` word is found
  --             { path = "luvit-meta/library", words = { "vim%.uv" } },
  --           },
  --         },
  --       },
  --       { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  --       { -- optional completion source for require statements and module annotations
  --         "hrsh7th/nvim-cmp",
  --         opts = function(_, opts)
  --           opts.sources = opts.sources or {}
  --           table.insert(opts.sources, {
  --             name = "lazydev",
  --             group_index = 0, -- set group index to 0 to skip loading LuaLS completions
  --           })
  --         end,
  --       },
  --       -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
  --     },
  --     { "folke/neoconf.nvim", opts = {}, enabled = false },
  --   },
  --   opts = {
  --           servers = {
  --               lua_ls = {}
  --           }
  --       },
  --   config = function(_, opts)
  --     local lspconfig = require("lspconfig")
  --     local util = require("lspconfig.util")
  --     for server, config in pairs(opts.servers) do
  --        -- passing config.capabilities to blink.cmp merges with capabilities in your
  --        -- `opts[server].capabilities`, if you've defined it
  --        config.capabilities = reqauire('blink.cmp').get_lsp_capabilities(config.capabilities)
  --               lspconfig[server].setup(config)
  --           end
  --     require("mason").setup()
  --     require("mason-lspconfig").setup({
  --       automatic_installation = true,
  --     })
  --     require("mason-tool-installer").setup({
  --       ensure_installed = {
  --         "black",
  --         "stylua",
  --         "shfmt",
  --         "isort",
  --         "tree-sitter-cli",
  --         "jupytext",
  --         "ruff",
  --         "pyright",
  --       },
  --     })
  --
  --     vim.api.nvim_create_autocmd("LspAttach", {
  --       group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  --       callback = function(event)
  --         local function map(keys, func, desc)
  --           vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
  --         end
  --         local function vmap(keys, func, desc)
  --           vim.keymap.set("v", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
  --         end
  --
  --         local client = vim.lsp.get_client_by_id(event.data.client_id)
  --         assert(client, "LSP client not found")
  --
  --         ---@diagnostic disable-next-line: inject-field
  --         client.server_capabilities.document_formatting = true
  --
  --         map("gS", vim.lsp.buf.document_symbol, "[g]o so [S]ymbols")
  --         map("gD", vim.lsp.buf.type_definition, "[g]o to type [D]efinition")
  --         map("gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
  --         map("K", vim.lsp.buf.hover, "[K] hover documentation")
  --         map("gh", vim.lsp.buf.signature_help, "[g]o to signature [h]elp")
  --         map("gI", vim.lsp.buf.implementation, "[g]o to [I]mplementation")
  --         map("gr", vim.lsp.buf.references, "[g]o to [r]eferences")
  --         map("[d", function()
  --           vim.diagnostic.jump({ count = 1 })
  --         end, "previous [d]iagnostic ")
  --         map("]d", function()
  --           vim.diagnostic.jump({ count = -1 })
  --         end, "next [d]iagnostic ")
  --         map("<leader>ll", vim.lsp.codelens.run, "[l]ens run")
  --         map("<leader>lR", vim.lsp.buf.rename, "[l]sp [R]ename")
  --         map("<leader>lf", vim.lsp.buf.format, "[l]sp [f]ormat")
  --         vmap("<leader>lf", vim.lsp.buf.format, "[l]sp [f]ormat")
  --         map("<leader>lq", vim.diagnostic.setqflist, "[l]sp diagnostic [q]uickfix")
  --       end,
  --     })
  --
  --     local lsp_flags = {
  --       allow_incremental_sync = true,
  --       debounce_text_changes = 150,
  --     }
  --
  --     vim.lsp.handlers["textDocument/hover"] =
  --       vim.lsp.with(vim.lsp.handlers.hover, { border = require("style").border })
  --     vim.lsp.handlers["textDocument/signatureHelp"] =
  --       vim.lsp.with(vim.lsp.handlers.signature_help, { border = require("style").border })
  --
  --     local capabilities = vim.lsp.protocol.make_client_capabilities()
  --     capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
  --     capabilities.textDocument.completion.completionItem.snippetSupport = true
  --
  --     -- also needs:
  --     -- $home/.config/marksman/config.toml :
  --     -- [core]
  --     -- markdown.file_extensions = ["md", "markdown", "qmd"]
  --     lspconfig.marksman.setup({
  --       capabilities = capabilities,
  --       filetypes = { "markdown", "quarto" },
  --       root_dir = util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
  --     })
  --
  --     -- lspconfig.r_language_server.setup({
  --     --   capabilities = capabilities,
  --     --   flags = lsp_flags,
  --     --   settings = {
  --     --     r = {
  --     --       lsp = {
  --     --         rich_documentation = false,
  --     --       },
  --     --     },
  --     --   },
  --     -- })
  --
  --     lspconfig.cssls.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --     })
  --
  --     lspconfig.html.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --     })
  --
  --     lspconfig.emmet_language_server.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --     })
  --
  --     lspconfig.yamlls.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --       settings = {
  --         yaml = {
  --           schemaStore = {
  --             enable = true,
  --             url = "",
  --           },
  --         },
  --       },
  --     })
  --
  --     lspconfig.jsonls.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --     })
  --
  --     lspconfig.dotls.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --     })
  --
  --     lspconfig.ts_ls.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --       filetypes = { "js", "javascript", "typescript", "ojs" },
  --     })
  --
  --     local function get_quarto_resource_path()
  --       local function strsplit(s, delimiter)
  --         local result = {}
  --         for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
  --           table.insert(result, match)
  --         end
  --         return result
  --       end
  --
  --       local f = assert(io.popen("quarto --paths", "r"))
  --       local s = assert(f:read("*a"))
  --       f:close()
  --       return strsplit(s, "\n")[2]
  --     end
  --
  --     local lua_library_files = vim.api.nvim_get_runtime_file("", true)
  --     local lua_plugin_paths = {}
  --     local resource_path = get_quarto_resource_path()
  --     if resource_path == nil then
  --       vim.notify_once("quarto not found, lua library files not loaded")
  --     else
  --       table.insert(lua_library_files, resource_path .. "/lua-types")
  --       table.insert(lua_plugin_paths, resource_path .. "/lua-plugin/plugin.lua")
  --     end
  --
  --     lspconfig.lua_ls.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --       settings = {
  --         Lua = {
  --           completion = {
  --             callSnippet = "Replace",
  --           },
  --           runtime = {
  --             version = "LuaJIT",
  --             -- plugin = lua_plugin_paths, -- handled by lazydev
  --           },
  --           diagnostics = {
  --             disable = { "trailing-space" },
  --           },
  --           workspace = {
  --             -- library = lua_library_files, -- handled by lazydev
  --             checkThirdParty = false,
  --           },
  --           doc = {
  --             privateName = { "^_" },
  --           },
  --           telemetry = {
  --             enable = false,
  --           },
  --         },
  --       },
  --     })
  --
  --     lspconfig.vimls.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --     })
  --
  --     lspconfig.julials.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --     })
  --
  --     lspconfig.bashls.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --       filetypes = { "sh", "bash" },
  --     })
  --
  --     -- Add additional languages here.
  --     -- See `:h lspconfig-all` for the configuration.
  --     -- Like e.g. Haskell:
  --     -- lspconfig.hls.setup {
  --     --   capabilities = capabilities,
  --     --   flags = lsp_flags
  --     -- }
  --
  --     -- lspconfig.clangd.setup {
  --     --   capabilities = capabilities,
  --     --   flags = lsp_flags,
  --     -- }
  --
  --     lspconfig.rust_analyzer.setup({
  --       capabilities = capabilities,
  --       settings = {
  --         ["rust-analyzer"] = {
  --           diagnostics = {
  --             enable = false,
  --           },
  --         },
  --       },
  --     })
  --
  --     lspconfig.ruff.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --     })
  --
  --     -- See https://github.com/neovim/neovim/issues/23291
  --     -- disable lsp watcher.
  --     -- Too lags on linux for python projects
  --     -- because pyright and nvim both create too many watchers otherwise
  --     if capabilities.workspace == nil then
  --       capabilities.workspace = {}
  --       capabilities.workspace.didChangeWatchedFiles = {}
  --     end
  --     capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
  --
  --     lspconfig.pyright.setup({
  --       capabilities = capabilities,
  --       flags = lsp_flags,
  --       settings = {
  --         python = {
  --           analysis = {
  --             autoSearchPaths = true,
  --             useLibraryCodeForTypes = true,
  --             diagnosticMode = "workspace",
  --           },
  --         },
  --       },
  --       root_dir = function(fname)
  --         return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname)
  --           or util.path.dirname(fname)
  --       end,
  --     })
  --   end,
  -- },
}
