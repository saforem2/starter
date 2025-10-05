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
-- nmap("n", "nzz")
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- nmap("<c-d>", "<c-d>zz")
-- nmap("<c-u>", "<c-u>zz")

-- BarBar
-- local map = vim.api.nvim_set_keymap
local map = LazyVim.safe_keymap_set
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
-- map("n", "<C-s-p>", "<Cmd>BufferPickDelete<CR>", opts)

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
map("i", "<esc>", "<C-C>", { desc = "Escape from insert mode" })

-- map("i", "<C-\\>", "copilot#Suggest()", {
--   expr = true,
--   replace_keycodes = false,
-- })
--
-- map("i", "<C-.>", 'copilot#Next("")', {
--   expr = true,
--   replace_keycodes = false,
-- })
-- map("i", "<C-,>", 'copilot#Previous("")', {
--   expr = true,
--   replace_keycodes = false,
-- })
-- map("i", "<C-k>", 'copilot#Suggest("")', {
--   expr = true,
--   replace_keycodes = false,
-- })

map("i", "<c-g>", "codeium#Accept()", {
  expr = true,
  replace_keycodes = false,
})

-- map <c-x> to clear
-- map("i", "<c-x>", "codeium#Clear()", {
--   expr = true,
--   replace_keycodes = false,
-- })

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
--

map("v", "<leader>c", "<Plug>(osc52-copy-visual)", { desc = "Copy to system clipboard" })
map("n", "<leader>c", "<Plug>(osc52-copy-operator)", { desc = "Copy to system clipboard" })
map("n", "[h", "MkdnPrevHeading", { desc = "Jump to Previous Heading" })
map("n", "]h", "MkdnNextHeading", { desc = "Jump to Next Heading" })
map("n", "<leader>\\", "<cmd>QuartoPreview<cr>", { desc = "Quarto Preview" })
map("n", "0", "^", { desc = "Beginning of line" })
map("n", "X", [[:keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>]], { desc = "Split line" })


-- This file is automatically loaded by lazyvim.config.init

-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
-- local map = LazyVim.safe_keymap_set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
-- map("n", "<S-h>", "<cmd>BufferPrevious<cr>", { desc = "Prev Buffer" })
-- map("n", "<S-l>", "<cmd>BufferNext<cr>", { desc = "Next Buffer" })
map("n", "H", ":BufferPrevious<CR>", { desc = "Prev Buffer" })
map("n", "L", ":BufferNext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>BufferPrevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>BufferNext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  LazyVim.cmp.actions.snippet_stop()
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- location list
map("n", "<leader>xl", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })

-- quickfix list
map("n", "<leader>xq", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- formatting
map({ "n", "v" }, "<leader>cf", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- stylua: ignore start

-- toggle options
LazyVim.format.snacks_toggle():map("<leader>uf")
LazyVim.format.snacks_toggle(true):map("<leader>uF")
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
Snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<leader>uA")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark" , name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.animate():map("<leader>ua")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.scroll():map("<leader>uS")
Snacks.toggle.profiler():map("<leader>dpp")
Snacks.toggle.profiler_highlights():map("<leader>dph")

if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
  map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
  map("n", "<leader>gl", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, { desc = "Git Log" })
  map("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })
end

map("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
map({"n", "x" }, "<leader>gY", function()
  Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
end, { desc = "Git Browse (copy)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", function() vim.treesitter.inspect_tree() vim.api.nvim_input("I") end, { desc = "Inspect Tree" })

-- LazyVim Changelog
map("n", "<leader>L", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })

-- floating terminal
map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
map("n", "<c-/>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
map("n", "<c-_>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
Snacks.toggle.zen():map("<leader>uz")

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- native snippets. only needed on < 0.11, as 0.11 creates these by default
if vim.fn.has("nvim-0.11") == 0 then
  map("s", "<Tab>", function()
    return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
  end, { expr = true, desc = "Jump Next" })
  map({ "i", "s" }, "<S-Tab>", function()
    return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
  end, { expr = true, desc = "Jump Previous" })
end


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
