-- File: lua/colors/elixir-pastel.lua
-- A custom Elixir-inspired theme

local colors = {
  bg_supadark = '#1e1e2f',
  fg = '#dcdcdc',
  purple = '#b39ddb',
  pink = '#ff8b8b',
  blue = '#90caf9',
  yellow = '#ffe082',
  red = '#ef9a9a',
  gray = '#a0a0a0',
}

local set = vim.api.nvim_set_hl

local function set_highlights()
  set(0, 'Normal',     { fg = colors.fg })
  set(0, 'Comment',    { fg = colors.gray, italic = true })
  set(0, 'Identifier', { fg = colors.purple })
  set(0, 'Statement',  { fg = colors.red })
  set(0, 'PreProc',    { fg = colors.blue })
  set(0, 'Type',       { fg = colors.yellow })
  set(0, 'Constant',   { fg = colors.pink })
  set(0, 'Function',   { fg = colors.blue })
  set(0, 'Todo',       { fg = colors.red, bg = colors.bg_supadark })
end

set_highlights()
