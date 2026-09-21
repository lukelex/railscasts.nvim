vim.cmd.colorscheme("railscasts")

local function highlight(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local colors = require("railscasts.colors")
local fixtures = {
  ["ruby.rb"] = "class Episode",
  ["lua.lua"] = "local Episode",
  ["config.yaml"] = "episode:",
}
local fixture_languages = {
  ["ruby.rb"] = "ruby",
  ["lua.lua"] = "lua",
  ["config.yaml"] = "yaml",
}

for name, marker in pairs(fixtures) do
  local content = table.concat(vim.fn.readfile("tests/fixtures/" .. name), "\n")
  assert(content:find(marker, 1, true), "invalid fixture: " .. name)
end

local parser_dir = vim.env.RAILSCASTS_PARSER_DIR
if parser_dir and parser_dir ~= "" then
  for name in pairs(fixtures) do
    local language = fixture_languages[name]
    local content = table.concat(vim.fn.readfile("tests/fixtures/" .. name), "\n")
    vim.treesitter.language.add(language, { path = parser_dir .. "/" .. language .. ".so" })
    local tree = vim.treesitter.get_string_parser(content, language):parse()[1]
    assert(not tree:root():has_error(), "Tree-sitter parse error: " .. name)
  end
end

local kitty_colors = {
  colors.background,
  colors.beige_grey,
  colors.blue,
  colors.cyan,
  colors.dark_grey,
  colors.dark_orange,
  colors.light_green,
  colors.light_grey,
  colors.light_orange,
  colors.moss,
  colors.purple,
  colors.red,
  colors.white,
}
local kitty_config = table.concat(vim.fn.readfile("extras/kitty.conf"), "\n")
for _, color in ipairs(kitty_colors) do
  assert(kitty_config:find(color, 1, true), "missing Kitty palette color: " .. color)
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
assert(highlight("lCursor").bg == 0xE6E1DC)
assert(highlight("lCursor").fg == 0x2B2B2B)
assert(highlight("Special").fg == 0x87AF5F)
assert(highlight("DiffAdd").fg == 0x87AF5F)
assert(highlight("Delimiter").fg == 0xE6E1DC)
assert(highlight("TabLine").bg == 0x333435)
assert(require("lualine.themes.railscasts").normal.c.bg == "#333435")
assert(vim.g.terminal_color_0 == "#2B2B2B")
assert(vim.g.terminal_color_1 == "#DA4939")
assert(vim.g.terminal_color_6 == "#87AF5F")
assert(vim.g.terminal_color_15 == "#F3F4F5")

require("railscasts").setup {
  high_contrast = true,
  transparent = true,
  dim_inactive = true,
}
vim.cmd.colorscheme("railscasts")
assert(require("railscasts.colors").dark_green == "#5FAF5F")
assert(highlight("Normal").bg == nil)
assert(highlight("NormalNC").bg == nil)
assert(highlight("NormalNC").fg == 0xC7A66D)
