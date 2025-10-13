return {
  {
    'psliwka/vim-dirtytalk',
    build = ':DirtytalkUpdate',
    config = function()
      vim.opt.spelllang = { 'en', 'programming' }
    end,
    keys = {
      {
        'sc',
        mode = { 'n' },
        function()
          local spell_set = vim.opt.spell:get()

          if spell_set then
            vim.opt.spell = false
          else
            vim.opt.spell = true
          end
        end,
        desc = 'Spell Check',
      },
    },
  },
}
