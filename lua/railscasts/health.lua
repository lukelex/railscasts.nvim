local M = {}

local function reporter()
  local health = vim.health
  return {
    start = health.start or health.report_start,
    ok = health.ok or health.report_ok,
    warn = health.warn or health.report_warn,
    error = health.error or health.report_error,
  }
end

local function supported_version()
  local version = vim.version()
  return version.major > 0 or version.minor > 9 or (version.minor == 9 and version.patch >= 5)
end

function M.check()
  local report = reporter()
  local options = require("railscasts.config").get()
  local colors = require("railscasts.colors")

  report.start("Railscasts")
  if supported_version() then
    report.ok(
      "Neovim " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch .. " is supported"
    )
  else
    report.error("Neovim 0.9.5 or later is required")
  end

  if vim.o.termguicolors then
    report.ok("termguicolors is enabled")
  else
    report.warn("termguicolors is disabled; Railscasts will use terminal color approximations")
  end

  if options.transparent and options.darker_background then
    report.error("transparent and darker_background cannot both be enabled")
  else
    report.ok(
      "Configuration is valid: high_contrast = "
        .. tostring(options.high_contrast)
        .. ", transparent = "
        .. tostring(options.transparent)
        .. ", darker_background = "
        .. tostring(options.darker_background)
        .. ", dim_inactive = "
        .. tostring(options.dim_inactive)
    )
  end

  local expected = require("railscasts.terminal").colors(colors)
  local mismatches = {}
  for index, color in ipairs(expected) do
    if vim.g["terminal_color_" .. (index - 1)] ~= color then
      table.insert(mismatches, index - 1)
    end
  end
  if #mismatches == 0 then
    report.ok("Terminal ANSI palette matches Railscasts")
  else
    report.warn(
      "Terminal ANSI palette differs at color " .. table.concat(mismatches, ", ") .. "; reload the colorscheme"
    )
  end
end

return M
