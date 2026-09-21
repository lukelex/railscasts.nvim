# Colorscheme contribution rules

These rules apply to every colorscheme change, including changes made by AI agents.

## Palette fidelity

- Preserve the original Railscasts/TextMate visual language. The TextMate and Vim
  references linked from `README.md` are the source of truth when intent is unclear.
- Use only values from `lua/railscasts/colors.lua` for new highlight colors.
- Do not introduce a new color literal, palette key, or derived color without an
  explicit user request and a corresponding documented rationale.
- Prefer linking a new group to an existing semantic group (`Comment`, `String`,
  `Function`, `Keyword`, `Type`, `Special`, or a diagnostic/diff group) over
  assigning a color directly.
- Keep the default palette unchanged. Accessibility changes belong in the opt-in
  `railscasts_high_contrast` palette.

## Integration scope

- Keep the documented integrations working: Lualine, IndentBlankLine/ibl, and
  Kitty. Their files are `lua/lualine/themes/railscasts.lua`,
  `lua/railscasts/theme.lua`, and `extras/kitty.conf`.
- Treat the original TextMate and Vim themes linked in `README.md` as visual
  references, not runtime dependencies.
- Add plugin-specific highlights only when explicitly requested or when needed to
  preserve a documented integration. Use links and the established palette.

## Implementation and verification

- Use native `vim.api.nvim_set_hl`; do not add a colorscheme runtime dependency.
- Add or update a headless assertion in `tests/theme_spec.lua` for each new
  semantic category or plugin integration.
- Run `luac -p` on changed Lua files and run the headless test command from the
  CI workflow before committing.
