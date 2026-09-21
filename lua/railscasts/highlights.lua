local M = {}

function M.apply(name, options)
  vim.api.nvim_set_hl(0, name, options)
end

function M.link(names, target)
  for _, name in ipairs(names) do
    M.apply(name, { link = target })
  end
end

function M.apply_many(names, options)
  for _, name in ipairs(names) do
    M.apply(name, options)
  end
end

return M
