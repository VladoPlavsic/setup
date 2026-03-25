return {
  {
    dir = vim.fn.stdpath 'config' .. '/lua/custom/floterminal', -- local path to plugin folder
    config = function()
      require 'custom.floterminal.init'
    end,
    keys = {
      {
        '<leader>to',
        mode = { 'n' },
        function()
          vim.cmd 'Floterminal'
          vim.cmd 'startinsert'
        end,
        desc = 'toggle floating terminal',
      },
      {
        '<leader>tq',
        mode = { 't' },
        function()
          vim.cmd 'Floterminal'
        end,
        desc = 'toggle floating terminal',
      },
    },
  },
}
