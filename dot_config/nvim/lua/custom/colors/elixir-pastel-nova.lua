-- File: lua/colors/elixir-pastel-nova.lua
-- Catppuccin Mocha inspired theme

local colors = {
  bg_dark = '#181825', -- Mantle
  surface = '#313244', -- Surface0
  fg = '#cdd6f4', -- Text
  comment = '#6c7086', -- Overlay0
  identifier = '#b4befe', -- Lavender  → variables
  func = '#80b4aa', -- Blue      → functions
  statement = '#cba6f7', -- Mauve     → if/do/end/def
  preproc = '#f5c2e7', -- Pink      → use/import/@doc
  type = '#f9e2af', -- Yellow    → modules/types
  constant = '#fab387', -- Peach     → atoms
}

local set = vim.api.nvim_set_hl

local function set_highlights()
  set(0, 'Normal', { fg = colors.fg })
  set(0, 'Comment', { fg = colors.comment, italic = true })
  set(0, 'Identifier', { fg = colors.identifier })
  set(0, 'Function', { fg = colors.func })
  set(0, 'Statement', { fg = colors.statement })
  set(0, 'PreProc', { fg = colors.preproc })
  set(0, 'Type', { fg = colors.type })
  set(0, 'Constant', { fg = colors.constant })
  set(0, 'Todo', { fg = colors.constant, bg = colors.surface, bold = true })
end

set_highlights()
