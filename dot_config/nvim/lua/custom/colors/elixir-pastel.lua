-- File: lua/colors/elixirbeam.lua
-- A custom Elixir-inspired theme

local colors = {
  bg_supadark = '#1e1e2f', -- Dark background
  bg_lessark = '#2a2a3c', -- Less dark same gamma background
  fg = '#dcdcdc', -- Light gray for foreground
  purple = '#b39ddb', -- Softer pastel purple
  pink = '#ff8b8b', -- Softer pink
  green = '#a5d6a7', -- Softer green
  blue = '#90caf9', -- Softer blue
  yellow = '#ffe082', -- Softer yellow
  red = '#ef9a9a', -- Softer red
  gray = '#a0a0a0', -- Gray for comments
}

-- Set highlights
local function set_highlights()
  vim.cmd('highlight Normal guibg=NONE' .. ' guifg=' .. colors.fg) -- transparent bg
  -- vim.cmd('highlight Normal guibg=' .. colors.bg_lessark .. ' guifg=' .. colors.fg)
  vim.cmd('highlight Comment guifg=' .. colors.gray .. ' gui=italic')
  vim.cmd('highlight Identifier guifg=' .. colors.purple)
  vim.cmd('highlight Statement guifg=' .. colors.red)
  vim.cmd('highlight PreProc guifg=' .. colors.blue)
  vim.cmd('highlight Type guifg=' .. colors.yellow)
  vim.cmd('highlight Constant guifg=' .. colors.pink)
  vim.cmd('highlight Function guifg=' .. colors.blue)
  vim.cmd('highlight Todo guifg=' .. colors.red .. ' guibg=' .. colors.bg_supadark)
end

set_highlights()
