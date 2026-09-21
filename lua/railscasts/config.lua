local M = {}

local options = {
  high_contrast = vim.g.railscasts_high_contrast == true,
  transparent = false,
  dim_inactive = false,
}

function M.setup(user_options)
  assert(type(user_options) == "table", "railscasts.setup expects a table")

  for name, value in pairs(user_options) do
    assert(options[name] ~= nil, "unknown Railscasts option: " .. name)
    assert(type(value) == "boolean", "Railscasts option " .. name .. " must be a boolean")
    options[name] = value
  end

  -- Preserve the original global option for existing configurations.
  vim.g.railscasts_high_contrast = options.high_contrast
end

function M.get()
  return options
end

return M
