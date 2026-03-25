return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  keys = {
    { '\\', ':Neotree toggle source=buffers<CR>', desc = 'NeoTree toggle buffers', silent = true },
  },
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window
    popup_border_style = 'rounded', -- Optional: Customize border style
    enable_git_status = true, -- Disable git status for buffers
    enable_diagnostics = true, -- Show diagnostics for buffers
    sources = {
      'buffers', -- Use the buffers source only
    },
    source_selector = {
      winbar = false, -- Disable source selector in winbar
      statusline = false, -- Disable source selector in statusline
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function()
          require('neo-tree.command').execute { action = 'close' }
        end,
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true, -- Highlight the current buffer
      },
      group_empty_dirs = true, -- Group empty directories
      show_unloaded = true, -- Show unloaded buffers
      window = {
        position = 'top', -- Position of the Neo-tree window
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ['\\'] = 'close_window', -- Close Neo-tree window
          ['<CR>'] = 'open', -- Open buffer on Enter
          ['d'] = 'buffer_delete', -- Delete buffer
          ['l'] = 'focus_preview',
          ['s'] = 'open_split',
          ['v'] = 'open_vsplit',
          ['P'] = {
            'toggle_preview',
            config = {
              use_float = true, -- Use floating window for preview
            },
          },
        },
      },
    },
  },
}
