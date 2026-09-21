# Theme improvements

- [ ] Add screenshot regression tests using fixed Ruby, Lua, and YAML fixtures.
- [ ] Add representative Lua, Bash, and YAML screenshots to the README gallery.
- [x] Expand support for common UI plugins: nvim-cmp/Blink, GitSigns, Neo-tree/Oil, WhichKey, Lazy, Noice, render-markdown, and IndentBlankLine v3.
- [x] Complete modern Tree-sitter and semantic-token coverage, with fixture-based tests.
- [ ] Provide a `require("railscasts").setup()` API for high contrast, transparency, and inactive-window options.
- [ ] Set Neovim terminal colors from the Railscasts palette.
- [ ] Audit and improve contrast, including diagnostics, diffs, search results, and statusline modes.
- [x] Add parser-backed Tree-sitter fixture tests for Ruby, Lua, and YAML.
- [x] Run the Kitty config through Kitty's own parser in CI.
- [ ] Add a pinned StyLua formatting check after adopting a repository formatter configuration.
- [ ] Extend CI assertions across supported Neovim versions for UI, documented plugin integrations, semantic tokens, and high-contrast mode.
- [ ] Split highlight specifications into UI, syntax, Tree-sitter, plugin, and LSP modules as the theme grows.
