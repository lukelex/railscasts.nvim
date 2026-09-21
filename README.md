# Railscasts for Neovim

> A warm, dark Neovim colorscheme faithfully inspired by the original
> Railscasts TextMate theme.

[Installation](docs/INSTALLATION.md) · [Design language](DESIGN.md) · [Accessibility](docs/ACCESSIBILITY.md) · [Development](#development)

<p align="center">
  <img src="screenshots/gallery.gif" alt="Railscasts syntax highlighting for Ruby, Lua, Bash, and YAML" width="800" />
</p>

## Railscasts, carried forward

Railscasts is a love letter to the distinctive TextMate theme used throughout
[Ryan Bates’ Railscasts](http://railscasts.com/): charcoal editor surfaces,
cream text, earthy comments, and expressive syntax color. This project brings
that language to modern Neovim while respecting the differences between
TextMate scopes, Tree-sitter captures, and LSP semantic tokens.

It is maintained as a visual port, not a reinterpretation. When a choice is
unclear, the original sources remain the reference:

- [Original TextMate theme](http://media.railscasts.com/resources/textmate_theme.zip)
- [Ryan Bates’ Vim colorscheme](https://github.com/ryanb/dotfiles/blob/997d6caa218d41cdc23e8dda3953d2fd93af2740/vim/colors/railscasts.vim)
- [Bitstream Vera Sans Mono](https://www.fontmirror.com/bitstream-vera-sans-mono),
  the font associated with the original presentation

Thank you to Ryan Bates and the Railscasts community for a visual identity that
has remained immediately recognizable for years.

## Gallery

The gallery cycles through Ruby, Lua, Bash, and YAML fixtures captured from a
Kitty window running Neovim with Railscasts. This keeps the syntax, spacing, and
glyph rendering faithful to the editor.

## Language support

Railscasts works with every Neovim filetype. Its current visual tuning and
fixtures focus on:

- Ruby
- Lua
- Bash
- YAML

Modern Tree-sitter captures, LSP semantic tokens, diagnostics, diffs, Lualine,
ibl/IndentBlankLine, Kitty, and common Neovim UI plugins are covered by the
theme.

## Get started

Railscasts requires Neovim 0.9.5 or later.

```lua
vim.cmd.colorscheme "railscasts"
```

See the [installation guide](docs/INSTALLATION.md) for native packages,
lazy.nvim, vim-plug, Windows, Lualine, Kitty, high-contrast mode, and other
configuration details.

## Development

The repository includes a Docker runner for the same checks used in CI:

```sh
docker build --tag railscasts-ci .
docker run --rm railscasts-ci
```

To test the current working tree without rebuilding the image:

```sh
docker run --rm --volume "$PWD:/workspace" railscasts-ci
```

The visual regression snapshot is stored at
[`tests/snapshots/theme.svg`](tests/snapshots/theme.svg). Update it intentionally
after a reviewed visual change:

```sh
docker run --rm --env UPDATE_SNAPSHOTS=1 --volume "$PWD:/workspace" railscasts-ci
```

Future work is tracked in [TODO.md](TODO.md). Contributors should also follow
the palette and integration rules in [AGENTS.md](AGENTS.md).
