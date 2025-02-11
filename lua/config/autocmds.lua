-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
    -- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.opt.foldmethod = "expr"
    -- -- vim.opt.foldtext = ""
  end,
})

-- vim.api.nvim_create_autocmd(On, opts)
--       vim.cmd[[
--         autogroup markdownmappings
--           autocmd!
--           autocmd FileType markdown nmap <buffer> ]v <Plug>Markdown_MoveToNextHeader
--           autocmd FileType markdown nmap <buffer> [v <Plug>Markdown_MoveToPreviousHeader
--       ]]
