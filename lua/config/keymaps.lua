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
--

vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

-- if !get(g:, 'copilot_no_maps')
--   imap <Plug>(copilot-dismiss)     <Cmd>call copilot#Dismiss()<CR>
--   if empty(mapcheck('<C-]>', 'i'))
--     imap <silent><script><nowait><expr> <C-]> copilot#Dismiss() . "\<C-]>"
--   endif
--   imap <Plug>(copilot-next)     <Cmd>call copilot#Next()<CR>
--   imap <Plug>(copilot-previous) <Cmd>call copilot#Previous()<CR>
--   imap <Plug>(copilot-suggest)  <Cmd>call copilot#Suggest()<CR>
--   imap <script><silent><nowait><expr> <Plug>(copilot-accept-word) copilot#AcceptWord()
--   imap <script><silent><nowait><expr> <Plug>(copilot-accept-line) copilot#AcceptLine()
--   try
--     if !has('nvim') && &encoding ==# 'utf-8'
--       " avoid 8-bit meta collision with UTF-8 characters
--       let s:restore_encoding = 1
--       silent noautocmd set encoding=cp949
--     endif
--     if empty(mapcheck('<M-]>', 'i'))
--       imap <M-]> <Plug>(copilot-next)
--     endif
--     if empty(mapcheck('<M-[>', 'i'))
--       imap <M-[> <Plug>(copilot-previous)
--     endif
--     if empty(mapcheck('<M-Bslash>', 'i'))
--       imap <M-Bslash> <Plug>(copilot-suggest)
--     endif
--     if empty(mapcheck('<M-Right>', 'i'))
--       imap <M-Right> <Plug>(copilot-accept-word)
--     endif
--     if empty(mapcheck('<M-C-Right>', 'i'))
--       imap <M-C-Right> <Plug>(copilot-accept-line)
--     endif
--   finally
--     if exists('s:restore_encoding')
--       silent noautocmd set encoding=utf-8
--     endif
--   endtry
-- endif

vim.keymap.set(
  { "v" },
  "<leader>c",
  "require('osc52').copy_visual()",
  { desc = "copy visual selection to system clipboard" }
)
vim.keymap.set(
  { "n" },
  "<leader>c",
  "require('osc52').copy_operator()",
  { desc = "copy visual selection to system clipboard" }
)

-- vim.keymap.set({ "n" }, "[v", [[<Plug>Markdown_MoveToNextHeader<CR>]], { desc = "Set cursor to next heading" })
-- vim.keymap.set({ "n" }, "]v", [[:<Plug>Markdown_MoveToPreviousHeader<CR>]], { desc = "Set cursor to previous heading" })
-- vim.keymap.set({ "n" }, "[v", "<Plug>(Markdown_MoveToPreviousHeader)<cr>", { desc = "Set cursor to previous heading" })
-- vim.keymap.set({ "n" }, "]v", "<Plug>(Markdown_MoveToNextHeader)<cr>", { desc = "Set cursor to next heading" })
vim.keymap.set({ "n" }, "<leader>\\", "<cmd>QuartoPreview<cr>", { desc = "Quarto Preview" })
vim.keymap.set({ "n" }, "0", "^", { desc = "Beginning of line" })
vim.keymap.set({ "n" }, "X", [[:keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>]], { desc = "Split line" })
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
