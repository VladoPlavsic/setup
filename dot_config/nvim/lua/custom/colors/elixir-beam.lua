local colors = {
  bg_dark = '#1e1e2e',
  fg = '#e0def4',
  purple = '#a277ff',   -- identifiers / variables
  magenta = '#ff79c6',  -- constants / atoms
  teal = '#2dd4bf',     -- functions
  yellow = '#facc15',   -- types / modules
  orange = '#f97316',   -- preprocessor / macros
  red = '#ef4444',      -- statements / keywords
  comment = '#6e6a86',
}

local set = vim.api.nvim_set_hl

local function set_highlights()
  set(0, 'Normal',     { fg = colors.fg })
  set(0, 'Comment',    { fg = colors.comment, italic = true })
  set(0, 'Identifier', { fg = colors.purple })
  set(0, 'Function',   { fg = colors.teal })
  set(0, 'Statement',  { fg = colors.red })
  set(0, 'PreProc',    { fg = colors.orange })
  set(0, 'Type',       { fg = colors.yellow })
  set(0, 'Constant',   { fg = colors.magenta })
  set(0, 'Todo',       { fg = colors.orange, bg = colors.bg_dark, bold = true })
end

set_highlights()
