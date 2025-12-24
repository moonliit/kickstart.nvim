-- lua/custom/themes/init.lua
local M = {}

function M.load(name)
  -- reset highlights so reloads are clean
  vim.cmd 'highlight clear'
  vim.cmd 'syntax reset'

  -- apply your theme file (Pattern A executes on require)
  require('custom.themes.' .. name)
end

return M
