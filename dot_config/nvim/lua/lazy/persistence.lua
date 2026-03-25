return {
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    keys = {
      {
        '<leader>vs',
        function()
          require('persistence').load()
        end,
        desc = '[V]im [S]ession restore (cwd)',
      },
      {
        '<leader>vS',
        function()
          require('persistence').select()
        end,
        desc = '[V]im [S]ession select',
      },
      {
        '<leader>vl',
        function()
          require('persistence').load { last = true }
        end,
        desc = '[V]im session restore [L]ast',
      },
      {
        '<leader>vx',
        function()
          require('persistence').stop()
        end,
        desc = '[V]im session [X] stop saving',
      },
    },
  },
}
