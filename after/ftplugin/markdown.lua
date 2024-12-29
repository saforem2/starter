vim.b.slime_cell_delimiter = "```"

-- wrap text, but by word no character
-- indent the wrappped line
vim.wo.wrap = false
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.wo.showbreak = "|"
vim.opt_local.conceallevel = 0

vim.opt.shiftwidth = 2 -- Size of an indent
vim.pt.tabstop = 2 -- Number of spaces tabs count for
