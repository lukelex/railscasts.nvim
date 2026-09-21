local M = {}

function M.setup(colors, _, highlights)
  local apply = highlights.apply
  local link = highlights.link

  link({
    "@lsp.type.type",
    "@lsp.type.builtinType",
    "@lsp.type.class",
    "@lsp.type.enum",
    "@lsp.type.interface",
    "@lsp.type.struct",
    "@lsp.type.typeParameter",
  }, "Type")
  link({ "@lsp.type.comment" }, "Comment")
  link({ "@lsp.type.enumMember" }, "Constant")
  link({ "@lsp.type.decorator", "@lsp.type.macro" }, "PreProc")
  link({ "@lsp.type.event" }, "Label")
  link({ "@lsp.type.keyword" }, "Keyword")
  link({ "@lsp.type.number" }, "Number")
  link({ "@lsp.type.boolean" }, "Boolean")
  link({ "@lsp.type.regexp", "@lsp.type.string" }, "String")
  link({ "@lsp.type.operator" }, "Operator")
  link({ "@lsp.type.namespace", "@lsp.type.property" }, "Identifier")
  link({ "@lsp.type.parameter", "@lsp.type.variable" }, "@function.call")
  link({ "@lsp.type.function", "@lsp.type.method" }, "Function")
  link({ "@operator.ruby" }, "PreProc")
  apply("@symbol.ruby", { fg = colors.cyan })
  link({ "@string.special.symbol" }, "@symbol.ruby")
  link({ "@tag.delimiter.html" }, "PreProc")
  link({ "@property.typescript" }, "@text")
  link({ "@field.yaml" }, "Function")
  link({ "@punctuation.special.yaml" }, "PreProc")
end

return M
