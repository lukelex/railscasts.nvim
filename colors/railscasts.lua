vim.opt.background = "dark"
vim.g.colors_name = "railscasts"

-- Reload the palette and theme so option changes take effect on the next
-- `:colorscheme railscasts` invocation.
package.loaded["railscasts.colors"] = nil
package.loaded["railscasts.theme"] = nil

-- include our theme file and pass it to lush to apply
require("lush")(require("railscasts.theme"))
