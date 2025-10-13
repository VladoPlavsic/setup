local colors = {
  bg = '#1e1e2e',
  fg = '#e0def4',
  purple = '#a277ff',
  magenta = '#ff79c6',
  teal = '#2dd4bf',
  yellow = '#facc15',
  orange = '#f97316',
  red = '#ef4444',
  comment = '#6e6a86',
  cursorln = '#2a273f',
  visualbg = '#433c59',
  statusbg = '#3b3052',
  linenr = '#555169',
}

local set = vim.api.nvim_set_hl

-- General UI
set(0, 'Normal', { fg = colors.fg, bg = colors.bg })
set(0, 'Comment', { fg = colors.comment, italic = true })
set(0, 'Constant', { fg = colors.yellow })
set(0, 'String', { fg = colors.teal })
set(0, 'Number', { fg = colors.yellow })
set(0, 'Identifier', { fg = colors.purple })
set(0, 'Function', { fg = colors.magenta, bold = true })
set(0, 'Statement', { fg = colors.purple, bold = true })
set(0, 'Keyword', { fg = colors.magenta })
set(0, 'Operator', { fg = colors.teal })
set(0, 'Type', { fg = colors.orange })
set(0, 'Special', { fg = colors.teal })
set(0, 'Error', { fg = colors.red, bold = true })
set(0, 'Todo', { fg = colors.orange, bg = '#3b3052', bold = true })
set(0, 'MatchParen', { fg = '#000000', bg = colors.yellow })

-- Visuals
set(0, 'CursorLine', { bg = colors.cursorln })
set(0, 'Visual', { bg = colors.visualbg })
set(0, 'LineNr', { fg = colors.linenr })
set(0, 'CursorLineNr', { fg = colors.orange, bold = true })
set(0, 'StatusLine', { fg = colors.fg, bg = colors.statusbg })
set(0, 'StatusLineNC', { fg = colors.comment, bg = colors.cursorln })
