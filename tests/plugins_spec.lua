local function highlight(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

for _, plugin in ipairs({ "mini.nvim", "nvim-notify", "trouble.nvim", "snacks.nvim" }) do
  vim.opt.rtp:append("/opt/plugins/" .. plugin)
end

require("mini.files").setup()
require("notify").setup()
require("trouble").setup()
require("snacks").setup()

vim.cmd.colorscheme("railscasts")

assert(highlight("MiniFilesDirectory").fg == highlight("Directory").fg)
assert(highlight("NotifyERRORTitle").fg == highlight("DiagnosticError").fg)
assert(highlight("TroubleSignError").fg == highlight("DiagnosticError").fg)
assert(highlight("SnacksPickerMatch").bg == highlight("Search").bg)
