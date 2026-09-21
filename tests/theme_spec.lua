vim.cmd.colorscheme("railscasts")

local function highlight(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local fixtures = {
  ["ruby.rb"] = "class Episode",
  ["lua.lua"] = "local Episode",
  ["config.yaml"] = "episode:",
}

for name, marker in pairs(fixtures) do
  local content = table.concat(vim.fn.readfile("tests/fixtures/" .. name), "\n")
  assert(content:find(marker, 1, true), "invalid fixture: " .. name)
end

assert(vim.g.colors_name == "railscasts")
assert(highlight("Normal").bg == 0x2B2B2B)
assert(highlight("diffRemoved").fg == highlight("DiffDelete").fg)
assert(require("lualine.themes.railscasts").normal.a.bg == "#87AF5F")
assert(highlight("GitSignsDelete").fg == highlight("DiffDelete").fg)
assert(highlight("BlinkCmpMenuSelection").bg == highlight("PmenuSel").bg)
assert(highlight("IblScope").fg == 0xAF5F00)
assert(highlight("@keyword.import").fg == highlight("Keyword").fg)
assert(highlight("@string.regex").fg == highlight("String").fg)
assert(highlight("@lsp.type.function").fg == highlight("Function").fg)
assert(highlight("@lsp.type.class").fg == highlight("Type").fg)
assert(highlight("DiagnosticError").fg == 0xDA4939)
assert(highlight("DiagnosticWarn").fg == 0xCC7833)
assert(highlight("DiagnosticInfo").fg == 0x6E9CBE)
assert(highlight("DiagnosticOk").fg == 0x87AF5F)

vim.g.railscasts_high_contrast = true
vim.cmd.colorscheme("railscasts")
assert(require("railscasts.colors").dark_green == "#5FAF5F")
