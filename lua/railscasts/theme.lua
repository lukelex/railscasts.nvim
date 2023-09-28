--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require("lush")
local hsl = lush.hsl

local colors = require("utils.colors")

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
    ColorColumn       { bg="#1c1c1c" }, -- Columns set with 'colorcolumn'
    Conceal           { bg="darkgrey", fg=hsl(colors.beige_grey) }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor            { bg=hsl(colors.white), fg=hsl(colors.black) }, -- Character under the cursor

    Search            { bg="#5f5f87", fg=hsl(colors.black) }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    CurSearch         { Search }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    Substitute        { Search }, -- |:substitute| replacement text highlighting
    QuickFixLine      { Search }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.

    lCursor           { bg="fg", fg="bg" }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
    CursorColumn      { bg="grey40" }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine        { bg=hsl(colors.grey)}, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory         { fg="#87af5f" }, -- Directory names (and other special names in listings)
    DiffAdd           { fg=hsl(colors.dark_green) }, -- Diff mode: Added line |diff.txt|
    DiffChange        { fg=hsl(colors.cyan) }, -- Diff mode: Changed line |diff.txt|
    DiffDelete        { gui="bold", bg="#660000", fg="#000000" }, -- Diff mode: Deleted line |diff.txt|
    DiffText          { gui="bold", bg="#ff0000", fg=hsl(colors.white) }, -- Diff mode: Changed text within a changed line |diff.txt|

    NonText           { fg="#767676" }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    EndOfBuffer       { NonText }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    Whitespace        { NonText }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    CursorLineNr      { NonText }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    LineNr            { NonText }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    LineNrAbove       { NonText }, -- Line number for when the 'relativenumber' option is set, above the cursor line
    LineNrBelow       { NonText }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    SpecialKey        { NonText }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|

    TermCursor        { gui="reverse" }, -- Cursor in a focused terminal
    -- TermCursorNC   { }, -- Cursor in an unfocused terminal
    ErrorMsg          { bg="red", fg="white" }, -- Error messages on the command line

    VertSplit         { bg="#121212", fg="#444444" }, -- Column separating vertically split windows
    WinSeparator      { VertSplit }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.

    Folded            { bg="#444444", fg=hsl(colors.white) }, -- Line used for closed folds

    FoldColumn        { bg="grey", fg="cyan" }, -- 'foldcolumn'
    CursorLineFold    { FoldColumn }, -- Like FoldColumn when 'cursorline' is set for the cursor line

    SignColumn        { fg=hsl(colors.white) }, -- Column where |signs| are displayed
    CursorLineSign    { SignColumn }, -- Like SignColumn when 'cursorline' is set for the cursor line

    IncSearch         { gui="reverse" }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"

    MatchParen        { bg="#005f5f", fg=hsl(colors.white) }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg           { gui="bold" }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea        { }, -- Area for messages and cmdline

    StatusLine        { bg="#606060", fg="#e4e4e4" }, -- Status line of current window
    MsgSeparator      { StatusLine }, -- Separator for scrolled messages, `msgsep` flag of 'display'

    MoreMsg           { gui="bold", fg="seagreen" }, -- |more-prompt|
    Normal            { bg=hsl(colors.background), fg="#e4e4e4" }, -- Normal text
    NormalFloat       { bg="#444444", fg=hsl(colors.white) }, -- Normal text in floating windows.
    -- FloatBorder    { }, -- Border of floating windows.
    FloatTitle        { gui="bold", fg=hsl(colors.white) }, -- Title of floating windows.
    -- NormalNC       { }, -- normal text in non-current windows

    Pmenu             { bg="#444444", fg=hsl(colors.white) }, -- Popup menu: Normal item.
    PmenuKind         { Pmenu }, -- Popup menu: Normal item "kind"
    PmenuExtra        { Pmenu }, -- Popup menu: Normal item "extra text"

    PmenuSel          { bg="#87af5f", fg="#000000" }, -- Popup menu: Selected item.
    PmenuKindSel      { PmenuSel }, -- Popup menu: Selected item "kind"
    PmenuExtraSel     { PmenuSel }, -- Popup menu: Selected item "extra text"

    PmenuSbar         { bg="#5a647e" }, -- Popup menu: Scrollbar.
    PmenuThumb        { bg="#a8a8a8", fg=hsl(colors.white) }, -- Popup menu: Thumb of the scrollbar.
    Question          { gui="bold", fg="green" }, -- |hit-enter| prompt and yes/no questions
    SpellBad          { gui="undercurl", sp="red", fg="#d70000" }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap          { gui="underline", sp="blue", fg="#dfdfff" }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal        { gui="undercurl", sp="cyan", fg="#00ffff" }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare         { gui="underline", sp="magenta", fg="#df5f87" }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLineNC      { bg="#303030", fg="#585858" }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine           { bg=hsl(colors.light_brown), fg=hsl(colors.background) }, -- Tab pages line, not active tab page label
    TabLineFill       { bg=hsl(colors.light_brown) }, -- Tab pages line, where there are no labels
    TabLineSel        { gui="bold", bg=hsl(colors.background), fg=hsl(colors.light_brown) }, -- Tab pages line, active tab page label
    Title             { gui="bold", fg=hsl(colors.white) }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual            { bg="#5A647E" }, -- Visual mode selection
    -- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg        { fg="#800000" }, -- Warning messages
    WildMenu          { bg="yellow", fg="black" }, -- Current match in 'wildmenu' completion

    WinBar            { gui="bold" }, -- Window bar of current window
    WinBarNC          { WinBar }, -- Window bar of not-current windows

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment           { fg="#af875f" }, -- Any comment

    Constant          { fg=hsl(colors.red) }, -- (*) Any constant
    Character         { Constant }, --   A character constant: 'c', '\n'
    Identifier        { Constant }, -- (*) Any variable name
    StorageClass      { Constant }, --   static, register, volatile, etc.
    Structure         { Constant }, --   struct, union, enum, etc.
    Type              { Constant }, -- (*) int, long, char, etc.
    Typedef           { Type }, --   A typedef

    String            { fg=hsl(colors.light_green) }, --   A string constant: "this is a string"
    Number            { fg=hsl(colors.moss) }, --   A number constant: 234, 0xff
    Float             { Number }, --   A floating point constant: 2.3e10

    Boolean           { fg=hsl(colors.blue) }, --   A boolean constant: TRUE, false

    Function          { fg=hsl(colors.light_orange) }, --   Function name (also: methods for classes)

    Label             { fg=hsl(colors.purple) }, --   case, default, etc.

    Statement         { fg=hsl(colors.dark_brown) }, -- (*) Any statement
    Conditional       { Statement }, --   if, then, else, endif, switch, etc.
    Repeat            { Statement }, --   for, do, while, etc.
    Operator          { Statement }, --   "sizeof", "+", "*", etc.
    Keyword           { Statement }, --   any other keyword
    Exception         { Statement }, --   try, catch, throw

    PreProc           { fg=hsl(colors.dark_orange) }, -- (*) Generic Preprocessor
    Include           { PreProc }, --   Preprocessor #include
    Define            { PreProc }, --   Preprocessor #define
    Macro             { PreProc }, --   Same as Define
    PreCondit         { PreProc }, --   Preprocessor #if, #else, #endif, etc.

    Special           { fg=hsl(colors.dark_green) }, -- (*) Any special symbol
    SpecialChar       { Special }, -- Special character in a constant
    Tag               { Special }, -- You can use CTRL-] on this
    Delimiter         { Special }, -- Character that needs attention
    SpecialComment    { Special }, -- Special things inside a comment (e.g. '\n')
    Debug             { Special }, -- Debugging statements

    Underlined        { gui="underline", fg="#80a0ff" }, -- Text that stands out, HTML links
    Ignore            { fg="bg" }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error             { bg="#990000", fg=hsl(colors.white) }, -- Any erroneous construct
    Todo              { gui="bold", fg=hsl(colors.red) }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    DiagnosticError               { fg="red" }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn                { fg="orange" }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo                { fg="lightblue" }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint                { fg=hsl(colors.beige_grey) }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticOk                  { fg="lightgreen" }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticVirtualTextError    { DiagnosticError }, -- Used for "Error" diagnostic virtual text.
    DiagnosticVirtualTextWarn     { DiagnosticWarn }, -- Used for "Warn" diagnostic virtual text.
    DiagnosticVirtualTextInfo     { DiagnosticInfo }, -- Used for "Info" diagnostic virtual text.
    DiagnosticVirtualTextHint     { DiagnosticHint }, -- Used for "Hint" diagnostic virtual text.
    DiagnosticVirtualTextOk       { DiagnosticOk }, -- Used for "Ok" diagnostic virtual text.
    DiagnosticUnderlineError      { gui="underline", sp="red" }, -- Used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn       { gui="underline", sp="orange" }, -- Used to underline "Warn" diagnostics.
    DiagnosticUnderlineInfo       { gui="underline", sp="lightblue" }, -- Used to underline "Info" diagnostics.
    DiagnosticUnderlineHint       { gui="underline", sp=hsl(colors.beige_grey) }, -- Used to underline "Hint" diagnostics.
    DiagnosticUnderlineOk         { gui="underline", sp="lightgreen" }, -- Used to underline "Ok" diagnostics.
    DiagnosticFloatingError       { DiagnosticError }, -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    DiagnosticFloatingWarn        { DiagnosticWarn }, -- Used to color "Warn" diagnostic messages in diagnostics float.
    DiagnosticFloatingInfo        { DiagnosticInfo }, -- Used to color "Info" diagnostic messages in diagnostics float.
    DiagnosticFloatingHint        { DiagnosticHint }, -- Used to color "Hint" diagnostic messages in diagnostics float.
    DiagnosticFloatingOk          { DiagnosticOk }, -- Used to color "Ok" diagnostic messages in diagnostics float.
    DiagnosticSignError           { DiagnosticError }, -- Used for "Error" signs in sign column.
    DiagnosticSignWarn            { DiagnosticWarn }, -- Used for "Warn" signs in sign column.
    DiagnosticSignInfo            { DiagnosticInfo }, -- Used for "Info" signs in sign column.
    DiagnosticSignHint            { DiagnosticHint }, -- Used for "Hint" signs in sign column.
    DiagnosticSignOk              { DiagnosticOk }, -- Used for "Ok" signs in sign column.
    DiagnosticDeprecated          { gui="strikethrough", sp="red" },
    DiagnosticUnnecessary         { Comment },

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function.
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    sym"@comment"               { Comment },
    sym"@lsp.type.comment"      { Comment },
    sym"@text.literal"          { Comment },

    sym"@field"                 { Identifier },
    sym"@property"              { Identifier },
    sym"@namespace"             { Identifier },
    sym"@text.reference"        { Identifier },
    sym"@lsp.type.parameter"    { Identifier },
    sym"@lsp.type.property"     { Identifier },
    sym"@lsp.type.variable"     { Identifier },

    sym"@text.uri"              { Underlined },
    sym"@text.underline"        { Underlined },

    sym"@constant"              { Constant },
    sym"@lsp.type.enumMember"   { Constant },

    sym"@type"                  { Type },
    sym"@lsp.type.type"         { Type },

    sym"@preproc"                  { PreProc },
    sym"@function.builtin"         { PreProc },
    sym"@tag"                      { PreProc }, -- Tag
    sym"@punctuation.special.yaml" { PreProc }, -- For delimiters (e.g. `.`)

    sym"@text.title"            { Title },
    sym"@text.todo"             { Todo },
    sym"@string"                { String },
    sym"@number"                { Number },
    sym"@label.json"            { String },
    sym"@keyword"               { Keyword },
    sym"@symbol.ruby"           { fg=hsl(colors.cyan) },
    sym"@constructor"           { Special },
    sym"@field.yaml"            { Function },

    sym"@function.call"         { fg=hsl(colors.beige_grey) }, -- Function calls
    sym"@parameter"             { fg=hsl(colors.beige_grey) },
    sym"@punctuation.bracket"   { fg=hsl(colors.beige_grey) }, -- For brackets and parenthesis
    sym"@punctuation.delimiter" { fg=hsl(colors.beige_grey) }, -- For delimiters (e.g. `.`)
    sym"@variable"              { fg=hsl(colors.beige_grey) },
    sym"@operator"              { fg=hsl(colors.beige_grey) },
    sym"@label"                 { fg=hsl(colors.beige_grey) },

    sym"@constant.builtin"      { fg=hsl(colors.blue) },
    sym"@variable.builtin"      { fg=hsl(colors.blue) },

    -- sym"@constant.macro"        { }, -- Define
    -- sym"@define"                { }, -- Define
    -- sym"@macro"                 { }, -- Macro
    -- sym"@string.escape"         { }, -- SpecialChar
    -- sym"@string.special"        { }, -- SpecialChar
    -- sym"@character"             { }, -- Character
    -- sym"@character.special"     { }, -- SpecialChar
    -- sym"@boolean"               { }, -- Boolean
    -- sym"@float"                 { }, -- Float
    -- sym"@function"              { }, -- Function
    -- sym"@function.macro"        { }, -- Macro
    -- sym"@method"                { }, -- Function
    -- sym"@field"                 { }, -- Identifier
    -- sym"@punctuation"           { }, -- Delimiter
    -- sym"@constructor"           { }, -- Special
    -- sym"@conditional"           { }, -- Conditional
    -- sym"@repeat"                { }, -- Repeat
    -- sym"@keyword"               { }, -- Keyword
    -- sym"@exception"             { }, -- Exception
    -- sym"@variable"              { }, -- Identifier
    -- sym"@type"                  { }, -- Type
    -- sym"@type.definition"       { }, -- Typedef
    -- sym"@storageclass"          { }, -- StorageClass
    -- sym"@structure"             { }, -- Structure
    -- sym"@include"               { }, -- Include
    -- sym"@debug"                 { }, -- Debug

    NvimInvalidSpacing                           { ErrorMsg },
    NvimSpacing                                  { Normal },
    FloatShadow                                  { bg="black", blend=80 },
    FloatShadowThrough                           { bg="black", blend=100 },
    RedrawDebugNormal                            { gui="reverse" },
    RedrawDebugClear                             { bg="yellow" },
    RedrawDebugComposed                          { bg="green" },
    RedrawDebugRecompose                         { bg="red" },
    NvimInvalid                                  { Error },
    NvimString                                   { String },
    NvimNumber                                   { Number },
    NvimIdentifier                               { Identifier },
    NvimNumberPrefix                             { Type },
    NvimOptionSigil                              { Type },

    NvimInternalError                            { bg="red", fg="red" },
    NvimFigureBrace                              { NvimInternalError },
    NvimSingleQuotedUnknownEscape                { NvimInternalError },
    NvimInvalidSingleQuotedUnknownEscape         { NvimInternalError },
    User1                                        { gui="bold", bg="#606060", fg="#eeeeee" },
    User2                                        { gui="bold", bg="#606060", fg="#ffaf00" },
    User3                                        { gui="bold", bg="#606060", fg="#5fff00" },
    User4                                        { gui="bold", bg="#606060", fg="#870000" },
    User5                                        { gui="bold", bg="#606060", fg="#e4e4e4" },
    User6                                        { gui="bold", bg="#606060", fg="#e4e4e4" },
    User7                                        { gui="bold", bg="#606060", fg="#e4e4e4" },
    User8                                        { gui="bold", bg="#606060", fg="#e4e4e4" },
    User9                                        { gui="bold", bg="#606060", fg="#e4e4e4" },
    diffAdded                                    { DiffAdd },
    diffRemoved                                  { fg="#800000" },
    diffNewFile                                  { gui="bold", fg=hsl(colors.white) },
    diffFile                                     { gui="bold", fg=hsl(colors.white) },
    pythonExceptions                             { fg="#ffaf87" },
    pythonDoctest                                { fg="#8787ff" },
    pythonDoctestValue                           { fg="#87d7af" },
    mailEmail                                    { gui="italic", fg="#87af5f" },
    mailHeaderKey                                { fg="#ffdf5f" },
    mailSubject                                  { mailHeaderKey },
    xmlTag                                       { fg="#dfaf5f" },
    htmlTag                                      { xmlTag },
    xmlTagName                                   { fg="#dfaf5f" },
    htmlTagName                                  { xmlTagName },
    xmlEndTag                                    { fg="#dfaf5f" },
    htmlEndTag                                   { xmlEndTag },
    checkbox                                     { fg="#3a3a3a" },
    checkboxDone                                 { gui="bold", fg="#5fff00" },
    checkboxNotDone                              { gui="bold", fg="#005fdf" },

    IndentBlanklineSpaceChar                     { gui="nocombine", fg="#767676" }, -- IndentBlanklineSpaceChar xxx cterm=nocombine ctermfg=243 gui=nocombine guifg=#767676
    IndentBlanklineContextStart                  { gui="underline", sp="#af5f00" }, -- IndentBlanklineContextStart xxx cterm=underline gui=underline guisp=#af5f00
    IndentBlanklineSpaceCharBlankline            { gui="nocombine", fg="#767676" }, -- IndentBlanklineSpaceCharBlankline xxx cterm=nocombine ctermfg=243 gui=nocombine guifg=#767676
    IndentBlanklineContextChar                   { gui="nocombine", fg="#af5f00" }, -- IndentBlanklineContextChar xxx cterm=nocombine ctermfg=130 gui=nocombine guifg=#af5f00
    IndentBlanklineChar                          { gui="nocombine", fg="#767676" }, -- IndentBlanklineChar xxx cterm=nocombine ctermfg=243 gui=nocombine guifg=#767676

    TelescopeBorder            { fg=hsl(colors.light_brown) },
    TelescopeSelection         { fg=hsl(colors.dark_orange) },
    TelescopeTitle             { fg=hsl(colors.red) },
    TelescopePromptTitle       { TelescopeTitle },
    TelescopePromptNormal      { fg=hsl(colors.yellow) },
    TelescopePromptPrefix      { TelescopePromptNormal },
    TelescopeMatching          { TelescopePromptNormal },
  }
end)

return theme
