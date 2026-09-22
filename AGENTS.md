# Railscasts contributor notes

## Theme constraints

- This is a visual port of the original Railscasts TextMate/Vim themes linked
  from `README.md`; use them to resolve visual intent.
- `lua/railscasts/colors.lua` is the canonical palette. Do not add a color
  literal, palette key, or derived color without an explicit user request and
  documented rationale. The default palette is stable; contrast changes use
  the `high_contrast` setup option.
- Prefer links to existing semantic, diagnostic, or diff groups over direct
  colors for new plugin groups.
- Keep native `vim.api.nvim_set_hl` highlighting and do not add a colorscheme
  runtime dependency.

## Layout and integration changes

- `colors/railscasts.lua` is the reload-safe colorscheme entrypoint: it clears
  highlights and reloads the palette before applying `lua/railscasts/theme.lua`.
- `theme.lua` orchestrates `lua/railscasts/highlights/{ui,syntax,plugins,treesitter,lsp}.lua`;
  put new definitions in the matching section.
- Configuration accepts only boolean `high_contrast`, `transparent`, and
  `dim_inactive` options through `require("railscasts").setup()`; the legacy
  global option is intentionally unsupported.
- Keep the Lualine theme (`lua/lualine/themes/railscasts.lua`) and Kitty palette
  (`extras/kitty.conf`) aligned with the canonical palette.
- Add a `tests/theme_spec.lua` assertion for every new semantic category or
  plugin integration.

## Verification

- Build and run the same complete suite as CI:
  `docker build --tag railscasts-ci . && docker run --rm railscasts-ci`.
- To run the current working tree without rebuilding, mount it at `/workspace`:
  `docker run --rm --volume "$PWD:/workspace" railscasts-ci`.
- The Docker suite runs Lua 5.1 syntax checks, StyLua, Kitty parsing, and the
  theme/snapshot tests on Neovim 0.9.5, 0.10.4, 0.11.7, and 0.12.5. Parser-backed
  fixture tests intentionally run only on 0.11.7 and 0.12.5 because of parser ABI compatibility.
- Update `tests/snapshots/theme.svg` only for reviewed visual changes with
  `UPDATE_SNAPSHOTS=1 docker run --rm --volume "$PWD:/workspace" railscasts-ci`.
- Regenerate `screenshots/gallery.gif` with `scripts/capture_gallery.sh`; it
  captures the fixture files in Kitty/Neovim rather than composing mock text.

## Release notes

- Keep release changelogs concise and user-facing: visual changes, options,
  compatibility, breaking changes, and supported integrations.
- Exclude CI, tests, linting, formatting, and internal infrastructure unless
  explicitly requested.
