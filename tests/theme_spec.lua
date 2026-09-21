vim.cmd.colorscheme("railscasts")

local function highlight(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

assert(vim.g.colors_name == "railscasts")
assert(highlight("Normal").bg == 0x2B2B2B)
assert(highlight("diffRemoved").fg == highlight("DiffDelete").fg)
assert(require("lualine.themes.railscasts").normal.a.bg == "#87AF5F")
assert(highlight("GitSignsDelete").fg == highlight("DiffDelete").fg)
assert(highlight("BlinkCmpMenuSelection").bg == highlight("PmenuSel").bg)
assert(highlight("IblScope").fg == 0xAF5F00)

vim.g.railscasts_high_contrast = true
vim.cmd.colorscheme("railscasts")
assert(require("railscasts.colors").dark_green == "#5FAF5F")
