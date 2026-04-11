local M = {}

function M.has_hl(group)
  return vim.fn.hlexists(group) == 1
end

function M.link_target(preferred, fallback)
  if M.has_hl(preferred) then
    return preferred
  end
  return fallback
end

return M
