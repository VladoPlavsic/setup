return {
  {
    -- See lualine as statusline
    'nvim-lualine/lualine.nvim',
    lazy = false,
    -- See `:help lualine.txt`

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
