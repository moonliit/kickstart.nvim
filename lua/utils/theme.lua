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

function M.palette()
  return vim.g.theme_palette or {}
end

function M.color(name, fallback)
  local palette = M.palette()
  return palette[name] or fallback
end

return M
