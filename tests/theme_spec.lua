vim.cmd.colorscheme("railscasts")

local function highlight(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local colors = require("railscasts.colors")
local fixtures = {
  ["ruby.rb"] = "class Episode",
  ["lua.lua"] = "local Episode",
  ["config.yaml"] = "episode:",
  ["release.sh"] = "set -euo pipefail",
  ["example.ts"] = "interface Episode",
  ["package.json"] = '"name": "railscasts.nvim"',
  ["guide.md"] = "# Railscasts",
  ["index.html"] = "<title>Railscasts</title>",
  ["theme.css"] = "--accent: #ffc66d;",
  ["example.py"] = "class Episode:",
  ["example.js"] = "export function label",
  ["component.tsx"] = "export function EpisodeLabel",
  ["example.go"] = "type Episode struct",
  ["example.rs"] = "struct Episode",
  ["example.sql"] = "SELECT title, published",
  ["example.toml"] = 'name = "Railscasts"',
  ["Dockerfile"] = "FROM ruby:3.4-alpine",
  ["Makefile"] = "all:",
}
local fixture_languages = {
  ["ruby.rb"] = "ruby",
  ["lua.lua"] = "lua",
  ["config.yaml"] = "yaml",
  ["release.sh"] = "bash",
  ["example.ts"] = "typescript",
  ["package.json"] = "json",
  ["guide.md"] = "markdown",
  ["index.html"] = "html",
  ["theme.css"] = "css",
  ["example.py"] = "python",
  ["example.js"] = "javascript",
  ["component.tsx"] = "tsx",
  ["example.go"] = "go",
  ["example.rs"] = "rust",
  ["example.sql"] = "sql",
  ["example.toml"] = "toml",
  ["Dockerfile"] = "dockerfile",
  ["Makefile"] = "make",
}
local default_capture_spec = {
  query = "(_) @text",
  groups = { ["@text"] = "Normal" },
}
local capture_specs = {
  ruby = {
    query = [[
      (comment) @comment
      (string) @string
      (method name: (identifier) @function)
    ]],
    groups = { ["@comment"] = "Comment", ["@string"] = "String", ["@function"] = "Function" },
  },
  lua = {
    query = [[
      (comment) @comment
      (string) @string
      (function_declaration name: (_) @function)
    ]],
    groups = { ["@comment"] = "Comment", ["@string"] = "String", ["@function"] = "Function" },
  },
  yaml = {
    query = [[
      (block_mapping_pair key: (_) @field.yaml)
      (double_quote_scalar) @string
    ]],
    groups = { ["@field.yaml"] = "Function", ["@string"] = "String" },
  },
  bash = {
    query = [[
      (comment) @comment
      (string) @string
      (command name: (command_name) @function)
    ]],
    groups = { ["@comment"] = "Comment", ["@string"] = "String", ["@function"] = "Function" },
  },
  typescript = {
    query = [[
      (comment) @comment
      (string) @string
      (function_declaration name: (identifier) @function)
    ]],
    groups = { ["@comment"] = "Comment", ["@string"] = "String", ["@function"] = "Function" },
  },
  json = {
    query = [[
      (pair key: (string) @label.json)
      (string) @string
    ]],
    groups = { ["@label.json"] = "String", ["@string"] = "String" },
  },
  markdown = {
    query = [[
      (atx_heading) @markup.heading
      (block_quote) @markup.quote
    ]],
    groups = { ["@markup.heading"] = "Title", ["@markup.quote"] = "Comment" },
  },
  html = {
    query = [[
      (tag_name) @tag
      (attribute_name) @tag.attribute
    ]],
    groups = { ["@tag"] = "Function", ["@tag.attribute"] = "Identifier" },
  },
  css = {
    query = [[
      (class_selector) @type
      (property_name) @property
    ]],
    groups = { ["@type"] = "Identifier", ["@property"] = "Identifier" },
  },
}

for name, marker in pairs(fixtures) do
  local content = table.concat(vim.fn.readfile("tests/fixtures/" .. name), "\n") .. "\n"
  assert(content:find(marker, 1, true), "invalid fixture: " .. name)
end

local parser_dir = vim.env.RAILSCASTS_PARSER_DIR
if parser_dir and parser_dir ~= "" then
  for name in pairs(fixtures) do
    local language = fixture_languages[name]
    local content = table.concat(vim.fn.readfile("tests/fixtures/" .. name), "\n") .. "\n"
    vim.treesitter.language.add(language, { path = parser_dir .. "/" .. language .. ".so" })
    local tree = vim.treesitter.get_string_parser(content, language):parse()[1]
    assert(not tree:root():has_error(), "Tree-sitter parse error: " .. name)

    local spec = capture_specs[language] or default_capture_spec
    local query = vim.treesitter.query.parse(language, spec.query)
    local captures = {}
    for capture, _ in query:iter_captures(tree:root(), content, 0, -1) do
      captures["@" .. query.captures[capture]] = true
    end
    for capture, group in pairs(spec.groups) do
      assert(captures[capture], "missing Tree-sitter capture " .. capture .. " for " .. name)
      assert(highlight(capture).fg == highlight(group).fg, "unexpected highlight for " .. capture)
    end
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

-- Core UI
assert(highlight("Normal").bg == 0x2B2B2B)
assert(highlight("lCursor").bg == 0xE6E1DC)
assert(highlight("lCursor").fg == 0x2B2B2B)
assert(highlight("Delimiter").fg == 0xE6E1DC)
assert(highlight("TabLine").bg == 0x333435)
assert(highlight("PmenuSel").bg == 0x87AF5F)
assert(highlight("WinBar").bg == 0x005F00)
assert(require("lualine.themes.railscasts").normal.c.bg == "#333435")
assert(vim.g.terminal_color_0 == "#2B2B2B")
assert(vim.g.terminal_color_1 == "#DA4939")
assert(vim.g.terminal_color_6 == "#87AF5F")
assert(vim.g.terminal_color_15 == "#F3F4F5")

-- Diagnostics and diffs
assert(highlight("DiagnosticError").fg == 0xDA4939)
assert(highlight("DiagnosticWarn").fg == 0xCC7833)
assert(highlight("DiagnosticInfo").fg == 0x6E9CBE)
assert(highlight("DiagnosticOk").fg == 0x87AF5F)
assert(highlight("DiffAdd").fg == 0x87AF5F)
assert(highlight("diffRemoved").fg == highlight("DiffDelete").fg)
assert(highlight("GitSignsDelete").fg == highlight("DiffDelete").fg)

-- Documented plugin integrations
assert(require("lualine.themes.railscasts").normal.a.bg == "#87AF5F")
assert(highlight("CmpItemKind").fg == highlight("Function").fg)
assert(highlight("BlinkCmpMenuSelection").bg == highlight("PmenuSel").bg)
assert(highlight("NeoTreeDirectoryName").fg == highlight("Directory").fg)
assert(highlight("OilDelete").fg == highlight("DiffDelete").fg)
assert(highlight("WhichKey").fg == highlight("Function").fg)
assert(highlight("LazyButtonActive").bg == highlight("PmenuSel").bg)
assert(highlight("NoiceFormatProgressDone").fg == highlight("DiffAdd").fg)
assert(highlight("SnacksPickerMatch").bg == highlight("Search").bg)
assert(highlight("SnacksPickerGitStatusAdded").fg == highlight("DiffAdd").fg)
assert(highlight("MiniFilesDirectory").fg == highlight("Directory").fg)
assert(highlight("MiniPickMatchRanges").bg == highlight("Search").bg)
assert(highlight("TroubleSignError").fg == highlight("DiagnosticError").fg)
assert(highlight("TroubleCode").fg == highlight("Number").fg)
assert(highlight("NotifyERRORTitle").fg == highlight("DiagnosticError").fg)
assert(highlight("NotifyWARNBody").bg == highlight("NormalFloat").bg)
assert(highlight("BufferLineBufferSelected").bg == highlight("TabLineSel").bg)
assert(highlight("DressingInputBorder").fg == highlight("TelescopeBorder").fg)
assert(highlight("DapUIBreakpointsInfo").fg == highlight("DiagnosticInfo").fg)
assert(highlight("DiffviewDiffAdd").fg == highlight("DiffAdd").fg)
assert(highlight("FugitiveStagedModification").fg == highlight("DiffAdd").fg)
assert(highlight("NavicIconsFunction").fg == highlight("Function").fg)
assert(highlight("DropBarMenuCurrentContext").bg == highlight("PmenuSel").bg)
assert(highlight("TreesitterContextSeparator").fg == highlight("WinSeparator").fg)
assert(highlight("RainbowDelimiterGreen").fg == highlight("String").fg)
assert(highlight("AerialConstructor").fg == highlight("Function").fg)
assert(highlight("OutlineCurrent").bg == highlight("PmenuSel").bg)
assert(highlight("NeogitChangeAdded").fg == highlight("DiffAdd").fg)
assert(highlight("NeotestFailed").fg == highlight("DiagnosticError").fg)
assert(highlight("FzfLuaFzfMatch").bg == highlight("Search").bg)
assert(highlight("RenderMarkdownH1").fg == highlight("Title").fg)
assert(highlight("IblScope").fg == 0xAF5F00)

-- Tree-sitter and LSP semantic tokens
assert(highlight("Special").fg == 0x87AF5F)
assert(highlight("@keyword.import").fg == highlight("Keyword").fg)
assert(highlight("@string.regex").fg == highlight("String").fg)
assert(highlight("@markup.heading").fg == highlight("Title").fg)
assert(highlight("@lsp.type.function").fg == highlight("Function").fg)
assert(highlight("@lsp.type.class").fg == highlight("Type").fg)
assert(highlight("@lsp.type.variable").fg == highlight("@function.call").fg)

local language_semantics = {
  ["@attribute.python"] = "PreProc",
  ["@function.javascript"] = "Function",
  ["@tag.tsx"] = "Function",
  ["@type.go"] = "Type",
  ["@attribute.rust"] = "PreProc",
  ["@keyword.sql"] = "Keyword",
  ["@field.toml"] = "Function",
  ["@keyword.dockerfile"] = "Keyword",
  ["@function.make"] = "Function",
  ["@type.c"] = "Type",
  ["@type.cpp"] = "Type",
  ["@attribute.java"] = "PreProc",
  ["@attribute.c_sharp"] = "PreProc",
  ["@tag.vue"] = "Function",
  ["@tag.svelte"] = "Function",
}
for capture, group in pairs(language_semantics) do
  assert(highlight(capture).fg == highlight(group).fg, "unexpected language highlight for " .. capture)
end

require("railscasts").setup({
  high_contrast = true,
  transparent = true,
  dim_inactive = true,
})
vim.cmd.colorscheme("railscasts")
assert(require("railscasts.colors").dark_green == "#5FAF5F")
assert(highlight("Normal").bg == nil)
assert(highlight("NormalNC").bg == nil)
assert(highlight("NormalNC").fg == 0xC7A66D)
assert(highlight("Comment").fg == 0xC7A66D)
assert(highlight("TabLineSel").bg == 0x5FAF5F)
assert(highlight("NormalFloat").bg == nil)
assert(highlight("TelescopeBorder").fg == 0xC7A66D)

local high_contrast_links = {
  CmpItemAbbrDeprecated = "Comment",
  SnacksDashboardFooter = "Comment",
  MiniStarterFooter = "Comment",
  TroubleSource = "Comment",
  NotifyTRACEIcon = "Comment",
  BufferLineCloseButton = "Comment",
  DressingInputBorder = "TelescopeBorder",
  DapUIBreakpointsDisabledLine = "Comment",
  DiffviewSecondary = "Comment",
  FugitiveStagedModification = "DiffAdd",
  NavicIconsFunction = "Function",
  DropBarMenuHoverSymbol = "Function",
  RainbowDelimiterGreen = "String",
  AerialConstructor = "Function",
  OutlineDetails = "Comment",
  NeogitChangeAdded = "DiffAdd",
  NeotestSkipped = "Comment",
  FzfLuaHeaderBind = "Comment",
  RenderMarkdownQuote = "Comment",
}
for group, target in pairs(high_contrast_links) do
  assert(highlight(group).fg == highlight(target).fg, "unexpected high-contrast highlight for " .. group)
end

package.loaded["lualine.themes.railscasts"] = nil
assert(require("lualine.themes.railscasts").visual.b.fg == "#C7A66D")
