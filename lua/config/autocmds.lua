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
      virtual_text = { current_line = true },
    })

    -- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.opt.foldmethod = "expr"
    -- -- vim.opt.foldtext = ""
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "markdown.mdx", "quarto" },
  callback = function()
    vim.keymap.set("n", "]v", "<Plug>Markdown_MoveToNextHeader", { buffer = true })
    vim.keymap.set("n", "[v", "<Plug>Markdown_MoveToPreviousHeader", { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.textwidth = 79
    vim.opt_local.formatoptions = "jcroql"
  end,
})

-- vim.api.nvim_create_autocmd(On, opts)
--       vim.cmd[[
--         autogroup markdownmappings
--           autocmd!
--           autocmd FileType markdown nmap <buffer> ]v <Plug>Markdown_MoveToNextHeader
--           autocmd FileType markdown nmap <buffer> [v <Plug>Markdown_MoveToPreviousHeader
--       ]]
--

-- set tab size 4 for bash files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
  end,
})
