return {
  {
    'elixir-beam-theme',
    dir = vim.fn.stdpath 'config' .. '/lua/custom/colors',
    name = 'elixir-beam',
    lazy = false,
    priority = 1000,
    config = function()
      require 'custom.colors.elixir-beam'
    end,
  },
}
