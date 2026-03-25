local M = {}

function M.reload()
  for name, _ in pairs(package.loaded) do
    if name:match '^custom' then
      package.loaded[name] = nil
    end
  end
  local config_dir = vim.fn.stdpath 'config'
  local f = io.open(config_dir .. '/init.lua', 'r')
  if f then
    for line in f:lines() do
      if not line:match '^%s*%-%-' then
        local mod = line:match 'require%s*[\'"]([^\'"]+)[\'"]'
        if mod and mod:match 'theme' then
          local path = config_dir .. '/lua/' .. mod:gsub('%.', '/') .. '.lua'
          local ok, specs = pcall(dofile, path)
          if ok and type(specs) == 'table' then
            for _, spec in ipairs(specs) do
              if type(spec.config) == 'function' then
                pcall(spec.config, spec, {})
              end
            end
          end
        end
      end
    end
    f:close()
  end
  vim.notify('Config reloaded', vim.log.levels.INFO)
end

function M.restart()
  require('persistence').save()
  io.open('/tmp/.nvim_restore', 'w'):close()
  vim.cmd 'cquit! 42'
end

vim.keymap.set('n', '<leader>vr', M.reload, { desc = '[V]im [R]eload config (themes)' })
vim.keymap.set('n', '<leader>vR', M.restart, { desc = '[V]im [R]estart & restore session' })

return M
