return {
  {
    'elixir-pastel-theme',
    dir = vim.fn.stdpath 'config' .. '/lua/custom/colors',
    name = 'elixir-pastel',
    lazy = false,
    priority = 1000,
    config = function()
      require 'custom.colors.elixir-pastel'
    end,
  },
}
