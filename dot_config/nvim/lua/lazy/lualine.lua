return {
  {
    lazy = false,
    -- See lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    config = function(_, opts)
      require('lualine').setup(opts)
      local hide_stl = function()
        vim.opt.laststatus = 0
      end
      hide_stl()
      vim.defer_fn(hide_stl, 0)
      vim.api.nvim_create_autocmd({ 'VimEnter', 'UIEnter', 'ColorScheme', 'BufEnter', 'WinEnter' }, {
        callback = hide_stl,
      })
    end,
    opts = {
      options = {
        icons_enabled = vim.g.have_nerd_font,
        theme = 'auto',
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {
          function()
            local encoding = vim.o.fileencoding
            if encoding == '' then
              return vim.bo.fileformat .. ' :: ' .. vim.bo.filetype
            else
              return encoding .. ' :: ' .. vim.bo.fileformat .. ' :: ' .. vim.bo.filetype
            end
          end,
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },
}
