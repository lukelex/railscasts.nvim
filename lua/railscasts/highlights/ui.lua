local M = {}

function M.setup(colors, options, highlights)
  local apply = highlights.apply
  local link = highlights.link
  local apply_many = highlights.apply_many
  local background = options.transparent and "NONE" or colors.background

  apply_many({ "ColorColumn" }, { bg = options.transparent and "NONE" or colors.black })
  apply("Conceal", { bg = "darkgrey", fg = colors.beige_grey })
  apply("Cursor", { bg = colors.white, fg = colors.background })
  apply("Search", { bold = true, bg = colors.yellow, fg = colors.background })
  link({ "CurSearch", "Substitute", "QuickFixLine" }, "Search")
  apply("lCursor", { bg = colors.beige_grey, fg = colors.background })
  apply("CursorColumn", { bg = "grey40" })
  apply("CursorLine", { bg = colors.grey })
  apply("Directory", { fg = colors.light_green })
  apply("NonText", { fg = "#767676" })
  link({ "EndOfBuffer", "Whitespace", "CursorLineNr", "LineNr", "LineNrAbove", "LineNrBelow", "SpecialKey" }, "NonText")
  apply("TermCursor", { reverse = true })
  apply("ErrorMsg", { bg = colors.red, fg = colors.white })
  apply("VertSplit", { bg = "#121212", fg = "#444444" })
  link({ "WinSeparator" }, "VertSplit")
  apply("Folded", { bg = "#444444", fg = colors.white })
  apply("FoldColumn", { bg = colors.grey, fg = colors.cyan })
  link({ "CursorLineFold" }, "FoldColumn")
  apply("SignColumn", { fg = colors.white })
  link({ "CursorLineSign" }, "SignColumn")
  apply("IncSearch", { reverse = true })
  apply("MatchParen", { bg = "#005f5f", fg = colors.white })
  apply("ModeMsg", { bold = true })
  apply("StatusLine", { bg = background, fg = "#e4e4e4" })
  link({ "MsgSeparator", "StatusLineNC" }, "StatusLine")
  apply("MoreMsg", { bold = true, fg = colors.light_green })
  apply("Normal", { bg = background, fg = colors.beige_grey })
  link({ "NormalFloat" }, "Normal")
  if options.dim_inactive then
    apply("NormalNC", { bg = background, fg = colors.light_brown })
  else
    link({ "NormalNC" }, "Normal")
  end
  apply("FloatTitle", { bold = true, fg = colors.beige_grey })
  apply("Pmenu", { bg = "#444444", fg = colors.white })
  link({ "PmenuKind", "PmenuExtra" }, "Pmenu")
  apply("PmenuSel", { bg = colors.light_green, fg = colors.black })
  link({ "PmenuKindSel", "PmenuExtraSel" }, "PmenuSel")
  apply("PmenuSbar", { bg = "#5a647e" })
  apply("PmenuThumb", { bg = "#a8a8a8", fg = colors.white })
  apply("Question", { bold = true, fg = colors.light_green })
  apply("SpellBad", { undercurl = true, sp = colors.red })
  apply("SpellCap", { underline = true, sp = colors.blue, fg = colors.purple })
  apply("SpellLocal", { undercurl = true, sp = colors.cyan, fg = colors.cyan })
  apply("SpellRare", { underline = true, sp = colors.purple, fg = colors.pink })
  apply("TabLine", { bg = colors.grey, fg = colors.beige_grey })
  apply("TabLineFill", { bg = background })
  apply("TabLineSel", { bold = true, bg = colors.dark_green, fg = colors.beige_grey })
  apply("Title", { bold = true, fg = colors.white })
  apply("Visual", { bg = "#5A647E" })
  apply("WarningMsg", { fg = colors.dark_orange })
  apply("WildMenu", { bg = colors.yellow, fg = colors.black })
  apply("WinBar", { bold = true, bg = colors.dark_green, fg = colors.beige_grey })
  if options.dim_inactive then
    link({ "WinBarNC" }, "NormalNC")
  else
    link({ "WinBarNC" }, "TabLine")
  end

  apply("DiagnosticError", { fg = colors.red })
  apply("DiagnosticWarn", { fg = colors.dark_orange })
  apply("DiagnosticInfo", { fg = colors.blue })
  apply("DiagnosticHint", { fg = colors.beige_grey })
  apply("DiagnosticOk", { fg = colors.light_green })
  for _, severity in ipairs({ "Error", "Warn", "Info", "Hint", "Ok" }) do
    link(
      { "DiagnosticVirtualText" .. severity, "DiagnosticFloating" .. severity, "DiagnosticSign" .. severity },
      "Diagnostic" .. severity
    )
  end
  apply("DiagnosticUnderlineError", { underline = true, sp = colors.red })
  apply("DiagnosticUnderlineWarn", { underline = true, sp = colors.dark_orange })
  apply("DiagnosticUnderlineInfo", { underline = true, sp = colors.blue })
  apply("DiagnosticUnderlineHint", { underline = true, sp = colors.beige_grey })
  apply("DiagnosticUnderlineOk", { underline = true, sp = colors.light_green })
  apply("DiagnosticDeprecated", { strikethrough = true, sp = colors.red })
  link({ "DiagnosticUnnecessary" }, "Comment")

  link({ "NvimInvalidSpacing" }, "ErrorMsg")
  link({ "NvimSpacing" }, "Normal")
  apply("FloatShadow", { bg = colors.black, blend = 80 })
  apply("FloatShadowThrough", { bg = colors.black, blend = 100 })
  apply("RedrawDebugNormal", { reverse = true })
  apply("RedrawDebugClear", { bg = "yellow" })
  apply("RedrawDebugComposed", { bg = "green" })
  apply("RedrawDebugRecompose", { bg = "red" })
  link({ "NvimInvalid" }, "Error")
  link({ "NvimString" }, "String")
  link({ "NvimNumber" }, "Number")
  link({ "NvimIdentifier" }, "Identifier")
  link({ "NvimNumberPrefix", "NvimOptionSigil" }, "Type")
  apply("NvimInternalError", { bg = colors.red, fg = colors.red })
  link(
    { "NvimFigureBrace", "NvimSingleQuotedUnknownEscape", "NvimInvalidSingleQuotedUnknownEscape" },
    "NvimInternalError"
  )
  apply_many({ "User1", "User6", "User7", "User8", "User9" }, { bold = true, bg = "#606060", fg = "#eeeeee" })
  apply("User2", { bold = true, bg = "#606060", fg = "#ffaf00" })
  apply("User3", { bold = true, bg = "#606060", fg = "#5fff00" })
  apply("User4", { bold = true, bg = "#606060", fg = "#870000" })
  apply("User5", { bold = true, bg = "#606060", fg = "#e4e4e4" })
end

return M
