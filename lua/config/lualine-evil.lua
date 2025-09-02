local hl_name = "Normal" -- Example highlight group name
local rgb = true -- Request RGB values
local highlight_info = vim.api.nvim_get_hl_by_name(hl_name, rgb)

if highlight_info then
  -- Access color information
  local fg_color = highlight_info.fg
  local bg_color = highlight_info.bg
  -- ... other color attributes
  print(string.format("Foreground color: %s, Background color: %s", fg_color, bg_color))
else
  print(string.format("Highlight group '%s' not found", hl_name))
end

-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = highlight_info.fg,
  fg       = highlight_info.bg,
  yellow   = highlight_info.yellow,
  cyan     = highlight_info.cyan,
  darkblue = highlight_info.darkblue,
  green    = highlight_info.green,
  orange   = highlight_info.orange,
  violet   = highlight_info.violet,
  magenta  = highlight_info.magenta,
  blue     = highlight_info.blue,
  red      = highlight_info.red,
}
  -- cyan     = '#008080',
  -- darkblue = '#081633',
  -- green    = '#98be65',
  -- orange   = '#FF8800',
  -- violet   = '#a9a1e1',
  -- magenta  = '#c678dd',
  -- blue     = '#51afef',
  -- red      = '#ec5f67',
-- }

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = highlight_info.fg, bg = highlight_info.bg } },
      inactive = { c = { fg = highlight_info.fg, bg = highlight_info.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = highlight_info.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    return ' '
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = highlight_info.red,
      i = highlight_info.green,
      v = highlight_info.blue,
      ['␖'] = highlight_info.blue,
      V = highlight_info.blue,
      c = highlight_info.magenta,
      no = highlight_info.red,
      s = highlight_info.orange,
      S = highlight_info.orange,
      ['␓'] = highlight_info.orange,
      ic = highlight_info.yellow,
      R = highlight_info.violet,
      Rv = highlight_info.violet,
      cv = highlight_info.red,
      ce = highlight_info.red,
      r = highlight_info.cyan,
      rm = highlight_info.cyan,
      ['r?'] = highlight_info.cyan,
      ['!'] = highlight_info.red,
      t = highlight_info.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = highlight_info.magenta, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = highlight_info.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    error = { fg = highlight_info.red },
    warn = { fg = highlight_info.yellow },
    info = { fg = highlight_info.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = highlight_info.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = highlight_info.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = highlight_info.violet, gui = 'bold' },
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  diff_color = {
    added = { fg = highlight_info.green },
    modified = { fg = highlight_info.orange },
    removed = { fg = highlight_info.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = highlight_info.blue },
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
