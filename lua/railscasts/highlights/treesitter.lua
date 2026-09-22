local M = {}

function M.setup(colors, _, highlights)
  local apply = highlights.apply
  local link = highlights.link

  apply("@text", { fg = colors.beige_grey })
  link({ "@text.title", "@markup.heading" }, "Title")
  link({ "@text.todo", "@markup.todo" }, "Todo")
  link({ "@markup" }, "@text")
  link({ "@number", "@float" }, "Number")
  link({ "@conceal" }, "NonText")
  apply("@function.call", { fg = colors.beige_grey })
  link({
    "@parameter",
    "@variable.parameter",
    "@punctuation.bracket",
    "@punctuation.delimiter",
    "@field",
    "@variable",
    "@operator",
  }, "@function.call")
  apply("@label", { fg = colors.purple })
  link({ "@variable.member" }, "@label")
  link({
    "@property",
    "@namespace",
    "@text.reference",
    "@constant",
    "@type",
    "@character",
    "@type.definition",
    "@storageclass",
  }, "Identifier")
  link({ "@module", "@module.builtin", "@tag.attribute" }, "Identifier")
  link({ "@comment", "@structure", "@text.literal" }, "Comment")
  link({
    "@preproc",
    "@attribute",
    "@function.builtin",
    "@function.macro",
    "@include",
    "@constant.macro",
    "@define",
    "@macro",
    "@type.qualifier",
  }, "PreProc")
  link({ "@function.method", "@tag", "@function", "@method" }, "Function")
  link({
    "@conditional",
    "@exception",
    "@keyword",
    "@keyword.conditional",
    "@keyword.directive",
    "@keyword.exception",
    "@keyword.function",
    "@keyword.import",
    "@keyword.repeat",
    "@keyword.return",
    "@keyword.type",
    "@repeat",
  }, "Keyword")
  link({ "@constructor", "@character.special", "@punctuation", "@debug" }, "Special")
  link({ "@string", "@string.escape", "@string.regex", "@string.special", "@string.special.path" }, "String")
  link({ "@string.special.url", "@text.uri", "@text.underline" }, "Underlined")
  link({ "@markup.link" }, "Underlined")
  link({ "@markup.raw" }, "String")
  link({ "@markup.quote" }, "Comment")
  link({ "@markup.list" }, "Special")
  link({ "@markup.math" }, "Number")
  apply("@label.json", { fg = colors.light_green })
  apply("@constant.builtin", { fg = colors.blue })
  link({ "@variable.builtin", "@boolean" }, "@constant.builtin")
  link({ "@text.diff.add" }, "diffAdded")
  link({ "@text.diff.delete" }, "diffRemoved")
  link({ "@diff.plus" }, "DiffAdd")
  link({ "@diff.delta" }, "DiffChange")
  link({ "@diff.minus" }, "DiffDelete")
  link({ "@attribute.python", "@decorator.python" }, "PreProc")
  link({ "@type.python" }, "Type")
  link({ "@function.javascript", "@function.tsx", "@tag.javascript", "@tag.tsx" }, "Function")
  link({ "@property.javascript", "@property.tsx" }, "Identifier")
  link({ "@type.go", "@type.rust", "@type.c", "@type.cpp", "@type.java", "@type.c_sharp" }, "Type")
  link(
    { "@function.go", "@function.rust", "@function.c", "@function.cpp", "@function.java", "@function.c_sharp" },
    "Function"
  )
  link({ "@attribute.rust", "@macro.rust", "@lifetime.rust" }, "PreProc")
  link({ "@keyword.sql", "@keyword.dockerfile", "@keyword.make" }, "Keyword")
  link({ "@function.sql", "@function.dockerfile", "@function.make" }, "Function")
  link({ "@field.toml" }, "Function")
  link({ "@variable.dockerfile", "@variable.make" }, "String")
  link({ "@attribute.java", "@attribute.c_sharp" }, "PreProc")
  link({ "@tag.vue", "@tag.svelte" }, "Function")
  link({ "@tag.attribute.vue", "@tag.attribute.svelte" }, "Identifier")
  link({ "@keyword.vue", "@keyword.svelte" }, "Keyword")
  link({ "@comment.error.gitcommit" }, "DiagnosticError")
end

return M
