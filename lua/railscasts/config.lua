local M = {}

local options = {
  high_contrast = false,
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

end

function M.get()
  return options
end

return M
