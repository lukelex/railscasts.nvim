vim.cmd.colorscheme("railscasts")

local groups = {
  { "Normal", "Railscasts" },
  { "Comment", "# A muted comment" },
  { "String", '"A string"' },
  { "Function", "render_theme()" },
  { "Keyword", "return" },
  { "Number", "2026" },
  { "Boolean", "true" },
  { "DiffAdd", "+ added line" },
  { "DiffChange", "~ changed line" },
  { "DiffDelete", "- deleted line" },
}

local function hex(color)
  return string.format("#%06X", color)
end

local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
local svg = {
  '<svg xmlns="http://www.w3.org/2000/svg" width="800" height="360" viewBox="0 0 800 360">',
  string.format('<rect width="800" height="360" fill="%s"/>', hex(normal.bg)),
  '<g font-family="monospace" font-size="24">',
}

for index, group in ipairs(groups) do
  local highlight = vim.api.nvim_get_hl(0, { name = group[1], link = false })
  table.insert(svg, string.format('<text x="48" y="%d" fill="%s">%s</text>', index * 32, hex(highlight.fg), group[2]))
end

table.insert(svg, "</g></svg>")

local snapshot = "tests/snapshots/theme.svg"
if vim.env.UPDATE_SNAPSHOTS == "1" then
  vim.fn.writefile(svg, snapshot)
else
  assert(table.concat(vim.fn.readfile(snapshot), "\n") == table.concat(svg, "\n"), "theme screenshot changed")
end
