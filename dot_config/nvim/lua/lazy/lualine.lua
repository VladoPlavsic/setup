return {
  {
    -- See lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        component_separator = '|',
        section_separators = '',
        theme = {
          normal = { a = { fg = '#0e0c18', bg = '#cba6f7', gui = 'bold' }, b = { fg = '#cdd6f4', bg = '#313244' }, c = { fg = '#6c7086' } },
          insert = { a = { fg = '#0e0c18', bg = '#fab387', gui = 'bold' }, b = { fg = '#cdd6f4', bg = '#313244' }, c = { fg = '#6c7086' } },
          visual = { a = { fg = '#0e0c18', bg = '#b4befe', gui = 'bold' }, b = { fg = '#cdd6f4', bg = '#313244' }, c = { fg = '#6c7086' } },
          replace = { a = { fg = '#0e0c18', bg = '#f5c2e7', gui = 'bold' }, b = { fg = '#cdd6f4', bg = '#313244' }, c = { fg = '#6c7086' } },
          command = { a = { fg = '#0e0c18', bg = '#f9e2af', gui = 'bold' }, b = { fg = '#cdd6f4', bg = '#313244' }, c = { fg = '#6c7086' } },
          inactive = { a = { fg = '#6c7086', bg = '#181825' }, b = { fg = '#6c7086', bg = '#181825' }, c = { fg = '#6c7086' } },
        },
      },
      tabline = {
        lualine_a = { 'buffers' },
        lualine_z = { 'tabs' },
      },
    },
  },
}
