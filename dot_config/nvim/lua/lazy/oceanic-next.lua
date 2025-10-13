return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    -- 'sainnhe/gruvbox-material',
    -- 'haunsingh/nord.nvim',
    -- 'liuchengxu/space-vim-dark',
    'mhartington/oceanic-next',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      -- vim.g.gruvbox_material_enable_italic = true
      -- vim.g.nord_italic = true
      -- vim.g.nord_cursorline_transparent = true
      -- vim.g.nord_disable_background = true
      vim.cmd.colorscheme 'OceanicNext'
    end,
  },
}
