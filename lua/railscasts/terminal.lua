local M = {}

function M.apply(colors)
  local ansi = {
    colors.background,
    colors.red,
    colors.light_orange,
    colors.moss,
    colors.cyan,
    colors.purple,
    colors.light_green,
    colors.white,
    colors.dark_grey,
    colors.dark_orange,
    colors.moss,
    colors.light_orange,
    colors.cyan,
    colors.purple,
    colors.light_green,
    colors.white,
  }

  for index, color in ipairs(ansi) do
    vim.g["terminal_color_" .. (index - 1)] = color
  end
end

return M
