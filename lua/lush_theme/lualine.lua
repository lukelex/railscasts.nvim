local colors = require("utils/colors")

-- Lualine groups are placed as follows: "a > b > c < b < a"
return {
  normal = {
    a = { bg = colors.light_green, fg = colors.black, gui = "bold" },
    b = { bg = colors.black, fg = colors.light_green },
    c = { bg = colors.grey, fg = colors.white }
  },
  insert = {
    a = { bg = colors.dark_orange, fg = colors.black, gui = "bold" },
    b = { bg = colors.black, fg = colors.dark_orange },
    c = { bg = colors.grey, fg = colors.white }
  },
  visual = {
    a = { bg = colors.light_brown, fg = colors.black, gui = "bold" },
    b = { bg = colors.black, fg = colors.light_brown },
    c = { bg = colors.grey, fg = colors.white }
  },
  replace = {
    a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
    b = { bg = colors.black, fg = colors.yellow },
    c = { bg = colors.grey, fg = colors.white }
  },
  command = {
    a = { bg = colors.red, fg = colors.black, gui = "bold" },
    b = { bg = colors.black, fg = colors.red },
    c = { bg = colors.grey, fg = colors.white }
  },
  inactive = {
    a = { bg = colors.black, fg = colors.cyan, gui = "bold" },
    b = { bg = colors.cyan, fg = colors.black },
    c = { bg = colors.grey, fg = colors.white }
  }
}
