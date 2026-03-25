return {
  {
    'MagicDuck/grug-far.nvim',
    opts = {},
    keys = {
      {
        '<leader>sR',
        function()
          require('grug-far').open { prefill = { search = vim.fn.expand '<cword>' } }
        end,
        mode = { 'n' },
        desc = '[S]earch and [R]eplace (grug-far)',
      },
      {
        '<leader>sR',
        function()
          require('grug-far').open { prefill = { search = require('grug-far').get_visual_selection() } }
        end,
        mode = { 'v' },
        desc = '[S]earch and [R]eplace selection (grug-far)',
      },
    },
  },
}
