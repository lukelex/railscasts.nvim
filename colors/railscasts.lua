vim.opt.background = "dark"

-- Reload the palette and theme so option changes take effect on the next
-- `:colorscheme railscasts` invocation.
package.loaded["railscasts.colors"] = nil
package.loaded["railscasts.theme"] = nil

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

local colors = require("railscasts.colors")
require("railscasts.terminal").apply(colors)
require("railscasts.theme").setup()
vim.g.colors_name = "railscasts"
