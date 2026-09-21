local M = {}

local sections = {
  "ui",
  "syntax",
  "plugins",
  "treesitter",
  "lsp",
}

function M.setup()
  local colors = require("railscasts.colors")
  local options = require("railscasts.config").get()
  local highlights = require("railscasts.highlights")

  for _, section in ipairs(sections) do
    require("railscasts.highlights." .. section).setup(colors, options, highlights)
  end
end

return M
