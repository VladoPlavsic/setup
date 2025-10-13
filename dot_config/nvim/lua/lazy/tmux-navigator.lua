return {
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
    config = function()
      -- Optional: Disable default mappings to avoid conflicts
      vim.g.tmux_navigator_no_mappings = 1
    end,
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<leader>th', '<cmd>TmuxNavigateLeft<CR>', silent = true, desc = '[T]mux left' },
      { '<leader>tj', '<cmd>TmuxNavigateDown<CR>', silent = true, desc = '[T]mux down' },
      { '<leader>tk', '<cmd>TmuxNavigateUp<CR>', silent = true, desc = '[T]mux up' },
      { '<leader>tl', '<cmd>TmuxNavigateRight<CR>', silent = true, desc = '[T]mux right' },
      { '<leader>tp', '<cmd>TmuxNavigatePrevious<CR>', silent = true, desc = '[T]mux previous' },
    },
    opts = {},
  },
}
