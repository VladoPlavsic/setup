return {
  {
    'elixir-pastel-nova-theme',
    dir = vim.fn.stdpath 'config' .. '/lua/custom/colors',
    name = 'elixir-pastel-nova',
    lazy = false,
    priority = 1000,
    config = function()
      require 'custom.colors.elixir-pastel-nova'
    end,
  },
}
