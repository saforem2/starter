-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- use `vim.keymap.set` instead
-- better up/down
-- map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
-- map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

local nmap = function(key, effect)
  vim.keymap.set("n", key, effect, { silent = true, noremap = true })
end

local vmap = function(key, effect)
  vim.keymap.set("v", key, effect, { silent = true, noremap = true })
end

local imap = function(key, effect)
  vim.keymap.set("i", key, effect, { silent = true, noremap = true })
end

local function toggle_light_dark_theme()
  if vim.o.background == "light" then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end

local function get_color_scheme()
  if vim.o.background == "light" then
    return "bluoco-light"
  else
    return "onelight"
  end
end

local cmap = function(key, effect)
  vim.keymap.set("c", key, effect, { silent = true, noremap = true })
end

-- save with ctrl+s
imap("<C-s>", "<esc>:update<cr><esc>")
nmap("<C-s>", "<cmd>:update<cr><esc>")

-- keep selection after indent / dedent
vmap(">", ">gv")
vmap("<", "<gv")

-- center after search and jumps
nmap("n", "nzz")
nmap("<c-d>", "<c-d>zz")
nmap("<c-u>", "<c-u>zz")

-- BarBar
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map("n", "H", "<Cmd>BufferPrevious<CR>", opts)
map("n", "L", "<Cmd>BufferNext<CR>", opts)

-- Re-order to previous/next
-- map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
-- map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

-- Goto buffer in position...
-- map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
-- map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
-- map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
-- map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
-- map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
-- map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
-- map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
-- map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
-- map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
-- map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)

-- Goto pinned/unpinned buffer
--                 :BufferGotoPinned
--                 :BufferGotoUnpinned

-- Close buffer
map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)

-- Wipeout buffer
--                 :BufferWipeout

-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight

-- Magic buffer-picking mode
map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
map("n", "<C-s-p>", "<Cmd>BufferPickDelete<CR>", opts)

-- Sort automatically by...
map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
map("n", "<Space>bn", "<Cmd>BufferOrderByName<CR>", opts)
map("n", "<Space>bD", "<Cmd>BufferOrderByDirectory<CR>", opts)
map("n", "<Space>bd", "<Cmd>BufferClose<CR>", opts)
map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

map("i", "<C-j>", 'copilot#Accept("")', {
  expr = true,
  replace_keycodes = false,
})
map("i", "<C-l>", 'copilot#AcceptLine("")', {
  expr = true,
  replace_keycodes = false,
})

map("i", "<C-\\>", "copilot#Suggest()", {
  expr = true,
  replace_keycodes = false,
})

map("i", "<C-.>", 'copilot#Next("")', {
  expr = true,
  replace_keycodes = false,
})
map("i", "<C-,>", 'copilot#Previous("")', {
  expr = true,
  replace_keycodes = false,
})
-- map("i", "<C-k>", 'copilot#Suggest("")', {
--   expr = true,
--   replace_keycodes = false,
-- })

map("i", "<c-g>", 'codeium#Accept()', {
  expr = true,
  replace_keycodes = false,
})

-- map <c-x> to clear
map("i", "<c-x>", 'codeium#Clear()', {
  expr = true,
  replace_keycodes = false,
})

-- map <c-.> to cycle completions
-- map("i", "<c-.>", 'codeium#CycleCompletions(1)', {
--   expr = true,
--   replace_keycodes = false,
-- })

-- vim.keymap.set("i", "<c-g>", function()
-- return vim.fn["codeium#Accept"]()
-- end, { expr = true })
-- -- nvim_set_keymap("i", "<C-g>", "v:lua.codeium#Accept()", { expr = true })
-- vim.keymap.set("i", "<C-g>", function()
-- return vim.fn["codeium#Accept"]()
-- end, { expr = true })
-- vim.keymap.set("i", "<c-.>", function()
--   return vim.fn["codeium#CycleCompletions"](1)
-- end, { expr = true })
-- vim.keymap.set("i", "<c-,>", function()
--   return vim.fn["codeium#CycleCompletions"](-1)
-- end, { expr = true })
-- vim.keymap.set("i", "<c-x>", function()
-- return vim.fn["codeium#Clear"]()
-- end, { expr = true })

-- map("i", "<C-k>", "<Plug>(copilot-suggest) <Cmd>call copilot#Suggest()<CR>", { expr = true, replace_keycodes = false })
-- map("i", "<C-k>", 'copilot#Suggest("\\<CR>")', { expr = true, replace_keycodes = false })
-- map("i", "<C-l>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
-- map("i", "<C-j>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
-- vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
--   expr = true,
--   replace_keycodes = false,
-- })
-- vim.g.copilot_no_tab_map = true

-- vim.keymap.set(
--   { "v" },
--   "<leader>c",
--   "require('osc52').copy_visual()",
--   { desc = "copy visual selection to system clipboard" }
-- )
-- vim.keymap.set(
--   { "n" },
--   "<leader>c",
--   "require('osc52').copy_operator()",
--   { desc = "copy visual selection to system clipboard" }
-- )
map("v", "<leader>c", "<Plug>(osc52-copy-visual)", { desc = "Copy to system clipboard" })
map("n", "<leader>c", "<Plug>(osc52-copy-operator)", { desc = "Copy to system clipboard" })
map("n", "[[", "<Plug>(markdown_go_prev_heading)<CR>", { desc = "Jump to Previous Heading" })
map("n", "]]", "<Plug>(markdown_go_next_heading)<CR>", { desc = "Jump to Next Heading" })
map("n", "<leader>\\", "<cmd>QuartoPreview<cr>", { desc = "Quarto Preview" })
map("n", "0", "^", { desc = "Beginning of line" })
map("n", "X", [[:keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>]], { desc = "Split line" })
-- map("n", "<leader>/",)

-- local wk = require("which-key")
-- local non_lsp_mappings = {
--   ["<leader>"] = {
--     e = { vim.cmd.Ex, "Open file explorer" },
--     p = { "\"_dP", "Paste without overwrite" },
--     ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggle comment" },
--     s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and replace word under cursor" },
--     -- t = { ":Today<CR>", "Open today's note" },
--   },
--   J = { "mzJ`z", "Join lines and keep cursor position" },
--   ["<C-d>"] = { "<C-d>zz", "Half page down and center" },
--   ["<C-u>"] = { "<C-u>zz", "Half page up and center" },
--   n = { "nzzzv", "Next search result and center" },
--   N = { "Nzzzv", "Previous search result and center" },
--   Q = { "<nop>", "Disable Ex mode" },
-- }
--
-- wk.register(non_lsp_mappings)

-- vim.keymap.set({ "n" }, "[v", [[<Plug>Markdown_MoveToNextHeader<CR>]], { desc = "Set cursor to next heading" })
-- vim.keymap.set({ "n" }, "]v", [[:<Plug>Markdown_MoveToPreviousHeader<CR>]], { desc = "Set cursor to previous heading" })
-- vim.keymap.set({ "n" }, "[v", "<Plug>(Markdown_MoveToPreviousHeader)<cr>", { desc = "Set cursor to previous heading" })
-- vim.keymap.set({ "n" }, "]v", "<Plug>(Markdown_MoveToNextHeader)<cr>", { desc = "Set cursor to next heading" })
--
-- vim.keymap.set({ "n" }, "<leader>\\", "<cmd>QuartoPreview<cr>", { desc = "Quarto Preview" })
-- vim.keymap.set({ "n" }, "0", "^", { desc = "Beginning of line" })
-- vim.keymap.set({ "n" }, "X", [[:keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>]], { desc = "Split line" })
--     ["<leader>\\"] = {"<cmd>QuartoPreview<cr>", desc = "Quarto Preview"},
--     ["0"] = {"^", desc = "Beginning of line"},
--     ["X"] = {
--         [[:keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>]],
--         desc = "Split line"
--     },
-- v = {
--     ["<leader>c"] = {
--         require('osc52').copy_visual(),
--     },
-- },
-- n = {
--     -- ["<leader>c"] = {
--     --     require('osc52').copy_operator(),
--     --     expr = true,
--     -- },
--     ["[["] = {
--         "<Plug>(markdown_go_prev_heading)<CR>",
--         desc="Jump to Previous Heading",
--     },
--     ["]]"] = {
--         "<Plug>(markdown_go_next_heading)<CR>",
--         desc="Jump to Next Heading",
--     },
--     -- ["[["] = {
--     --     "<Plug>(Markdown_MoveToPreviousHeader)<CR>",
--     --     desc="Set cursor to previous heading",
--     -- },
--     -- ["]]"] = {
--     --     "<Plug>(Markdown_MoveToNextHeader)<CR>",
--     --     desc="Set cursor to next heading",
--     -- },
--     ["<leader>cc"] = {
--         "<leader>c_",
--         remap = true,
--     },
--     ["<S-W"] = {
--         "<cmd>HopWord<CR>",
--         desc = "Hop Word",
--         opts = opts,
--     },
--     ["<S-h>"] = {
--         "<cmd>HopChar2<CR>",
--         desc = "Hop Char 2",
--         opts = opts,
--     },
--     ["<leader>b<"] = {
--         "<cmd>BufferMovePrevious<cr>",
--         desc="[BarBar] Buffer Move Previous",
--         opts = opts,
--     },
--     ["<leader>b>"] = {
--         "<cmd>BufferMoveNext<cr>",
--         desc="[BarBar] Buffer Move Next"
--     },
--     -- second key is the lefthand side of the map
--     -- mappings seen under group name "Buffer"
--     ["\\"] = {
--         "<cmd>lua require('notify').dismiss()<CR>",
--         desc = "Dismiss Notification"
--     },
--     ["gD"] = {
--         vim.lsp.buf.declaration,
--     },
--     ["<leader>d"] = {[["_d]], desc = "Beginning of line"},
--     ["<C-J>"] = {"J", desc = "Join line"},
--     ["<leader>bn"] = {"<cmd>tabnew<cr>", desc = "New tab"},
--     ["<leader>bD"] = {
--         function()
--             require("astronvim.utils.status").heirline.buffer_picker(
--                 function(bufnr)
--                     require("astronvim.utils.buffer").close(bufnr)
--                 end)
--         end,
--         desc = "Pick to close"
--     },
--     -- tables with the `name` key will be registered with which-key if it's installed
--     -- this is useful for naming menus
--     ["<leader>b"] = {name = "Buffers"},
--     ["<leader>tr"] = {"<cmd>IronRepl<cr>", desc = "Iron REPL"},
--     ["<leader>t<space>"] = {"<cmd>IronFocus<cr>", desc = "Iron Focus"},
--     ["<leader>tH"] = {"<cmd>IronHide<cr>", desc = "Iron Hide"}
--     -- quick save
--     -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
-- },
