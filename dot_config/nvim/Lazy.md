## A short instruction on how to use Lazy plugin manager

Plugins can be added with a link (or for a github repo: 'owner/repo' link).

e.g.
```lua
require('lazy').setup({
    'mhartington/oceanic-next',
}
```

Plugins can also be added by using a table,
with the first argument being the link and the following
keys can be used to configure plugin behavior/loading/etc.

Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.

e.g.
```lua
require('lazy').setup({
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
      },
    },
  },
}
```

Alternatively, use `config = function() ... end` for full control over the configuration.
If you prefer to call `setup` explicitly, use:

e.g.
```lua
 {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup({
            -- Your gitsigns configuration here  
        })
    end,
 }

