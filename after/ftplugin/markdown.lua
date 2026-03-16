vim.b.slime_cell_delimiter = "```"

-- wrap text, but by word no character
-- indent the wrappped line
vim.wo.wrap = false
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.wo.showbreak = "|"

vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.tabstop = 4 -- Number of spaces tabs count for

-- Toggle checkboxes: [ ] <-> [x]
vim.keymap.set("n", "<CR>", function()
  local line = vim.api.nvim_get_current_line()
  if line:match("%- %[ %]") then
    vim.api.nvim_set_current_line((line:gsub("%- %[ %]", "- [x]", 1)))
  elseif line:match("%- %[x%]") then
    vim.api.nvim_set_current_line((line:gsub("%- %[x%]", "- [ ]", 1)))
  end
end, { buffer = 0, desc = "Toggle checkbox" })
