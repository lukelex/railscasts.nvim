local M = {}

local options = {
  high_contrast = false,
  transparent = false,
  darker_background = false,
  dim_inactive = false,
}

function M.setup(user_options)
  assert(type(user_options) == "table", "railscasts.setup expects a table")

  local updated_options = vim.tbl_extend("force", {}, options)
  for name, value in pairs(user_options) do
    assert(options[name] ~= nil, "unknown Railscasts option: " .. name)
    assert(type(value) == "boolean", "Railscasts option " .. name .. " must be a boolean")
    updated_options[name] = value
  end

  assert(
    not (updated_options.transparent and updated_options.darker_background),
    "Railscasts transparent and darker_background options cannot both be true"
  )
  options = updated_options
end

function M.get()
  return options
end

return M
